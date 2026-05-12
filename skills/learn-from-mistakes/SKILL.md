---
name: learn-from-mistakes
description: Use when the user wants to capture lessons from mistakes the model made in a session and persist them as durable feedback so future sessions don't repeat them. Triggers on "/learn-from-mistakes", "before we wrap up", "what did I do wrong", "capture mistakes", "session postmortem", "teach me not to repeat that", or any end-of-session retrospective request. Also use when the user points at a past session JSONL or pastes a transcript and asks to extract lessons.
---

# Learn From Mistakes

Turn a session's mistakes into durable, scope-routed feedback memory so the model stops repeating them.

## When to Use
- End-of-session ritual: user is wrapping up and wants to capture what went wrong before context is lost
- Retrospective: user points at a past session file or pastes a transcript and asks for lessons
- Whenever the user references "mistakes", "things to fix", "don't do that again" in a review-the-session sense

**Not for:**
- Saving arbitrary notes — use `remember` instead
- Documenting *solutions* to problems — use `compound-engineering:ce-compound`
- Searching past sessions — use `compound-engineering:ce-sessions`

## Core Pipeline

```
Identify source → Detect signals → Draft candidates → Review per-lesson → Persist routed by scope
```

1. **Identify source**
   - No argument → current session (use the in-context conversation directly; do NOT read JSONL for the live session)
   - Path argument → read `<path>` (a `.jsonl` session transcript)
   - `paste` argument → ask user to paste the transcript, then work from that
   - If unsure which session, list recent files in `~/.claude/projects/<encoded-cwd>/` sorted by mtime and ask

2. **Detect signals** — scan for mistake markers (these seed candidates, not final lessons). Each signal has a confidence weight:
   - **High confidence** (always seed a candidate):
     - User direct teaching: "remember to", "always", "never", "from now on", "going forward"
     - Frustration markers: "ugh", "again?", "third time", "why do you keep", caps, swearing
     - Explicit reverts: user asked to undo / revert / "go back to"
   - **Medium confidence** (seed if combined with another signal or specific content):
     - Strong corrections: "stop", "no, that's wrong", "don't do that"
     - Repeated clarifications: user re-explained the same thing twice
   - **Low confidence** (skip unless co-occurring with high/medium):
     - Soft redirects: "actually", "not quite", "hmm", "let's try"
     - Failed approaches: tool errors followed by different approaches (often just exploration, not a mistake)

   Drop low-confidence-only signals — these are usually the user changing their mind, not the model erring. When in doubt, the user can always invoke `/learn-from-mistakes` again to capture more.

3. **Draft candidates** — for each signal, draft a lesson with this shape:
   - **Rule** (one sentence, imperative)
   - **Why** (the reason — preferably quoting or paraphrasing the user)
   - **How to apply** (when/where this kicks in)
   - **Suggested scope:** `global` (applies anywhere) or `project` (specific to a codebase, framework, technology, or repo convention)

4. **Review per-lesson, blocking** — for each candidate use `AskUserQuestion` with options:
   - `Keep` — persist as drafted
   - `Edit` — after the user picks this, ask a free-text question for the new wording, then re-show the updated candidate and re-ask Keep / Drop / Toggle scope
   - `Drop` — discard
   - `Toggle scope` — flip global↔project, then re-ask Keep / Edit / Drop only (do NOT offer Toggle again — cap at one toggle to prevent loops)

   Before the per-lesson loop, offer one batch affordance: "Approve all N candidates as drafted?" with options `Yes, persist all` / `No, review one at a time`. If the user picks `Yes`, skip the per-lesson loop and persist all candidates. Otherwise enter the per-lesson loop.

   **Auto mode does not bypass this gate.** This skill's whole value is high-precision memory; persisting unreviewed lessons would poison future sessions. Always block on `AskUserQuestion`, even when auto mode is active.

   Process candidates one at a time, in order. Never persist a candidate without explicit confirmation (either via the batch affordance or the per-lesson `Keep`).

5. **Persist routed by scope**
   - **Global** → `~/.claude/projects/-Users-pcil-projects/memory/feedback_<topic>.md` + index entry in `MEMORY.md` (this path is constant — it is the user's primary memory directory, not derived from the current cwd)
   - **Project** → `<project-root>/.claude/memory/learnings.md` (append entry)

   Project root resolution:
   1. Run `git rev-parse --show-toplevel`.
   2. If it succeeds AND the result is not the umbrella projects directory (`/Users/pcil/projects` or any path that contains many subprojects), use that as project root.
   3. If it fails (not in a git repo) OR resolves to the umbrella dir, do NOT silently fall back. Instead, ask the user via `AskUserQuestion`:
      - `Promote to global` — persist as global instead
      - `Pick project` — user provides an absolute path
      - `Drop` — discard the candidate
   4. Never write `learnings.md` to `/Users/pcil/projects` itself. That dir contains many subprojects and a learnings file there would leak across all of them.

## Output Formats

### Global feedback file
Path: `~/.claude/projects/-Users-pcil-projects/memory/feedback_<short-topic>.md`

```markdown
---
name: <Short title in sentence case>
description: <One-line description used to decide relevance in future conversations>
type: feedback
---

<Rule — one sentence, imperative.>

**Why:** <Reason. Quote the user when possible.>

**How to apply:** <When and where this guidance kicks in.>
```

Then append to `~/.claude/projects/-Users-pcil-projects/memory/MEMORY.md` under the **## Feedback** section, at the end of the existing list:

```markdown
- [<Short title>](feedback_<short-topic>.md) — <one-line hook, ≤150 chars>
```

If the **## Feedback** section doesn't exist, create it as the last section in MEMORY.md (after any existing sections). Do not reorder existing entries — append only. MEMORY.md is a chronological-ish index, not alphabetical.

### Project learnings file
Path: `<project-root>/.claude/memory/learnings.md`

```markdown
# Learnings

- [YYYY-MM-DD] <Rule>. **Why:** <reason>. **How to apply:** <when/where>.
```

If the file doesn't exist, create it with the `# Learnings` heading. Match the date format used by the `remember` skill.

## Naming the topic file

Generate a slug from the rule:
- Lowercase, hyphenated, ≤ 4 words
- Examples: `feedback_verify_before_claiming.md`, `feedback_no_emoji_in_files.md`

**Collision handling:**
1. List existing `feedback_*.md` files in the global memory dir before drafting candidates.
2. **Exact slug match** → open the existing file and offer (`AskUserQuestion`): `Append section to existing` / `Replace existing` / `Use a different slug`.
3. **Near match** (one shared keyword in the slug, e.g. existing `feedback_verify_output.md` vs new `feedback_verify_before_claiming.md`) → surface the existing file's content during dedup review and ask: `Update existing file` / `Add as separate file` / `Drop`. Do NOT silently merge — the user decides.
4. **No match** → create new file.

## Date source

Use the `currentDate` value from the in-context system reminder (e.g. `Today's date is 2026-04-30`). Do NOT shell out to `date` — the in-context value is authoritative for this skill. Format: `YYYY-MM-DD`.

## Dedup Check

Before drafting candidates, read:
- `~/.claude/projects/-Users-pcil-projects/memory/MEMORY.md` (already in context for Claude Code)
- `<project-root>/.claude/memory/learnings.md` if it exists

For each candidate, if it duplicates or contradicts an existing entry, flag it during review:
- "Already have a similar lesson at `<file>`. Update it / Add as new / Drop?"

Use `AskUserQuestion` for the dedup decision.

## Quick Reference

| Step | Action | Tool |
|------|--------|------|
| Source | Determine current vs path vs paste | Bash `ls -t` for picker |
| Signals | Scan transcript for correction markers | grep / in-context reading |
| Candidates | Draft rule + why + how to apply + scope | — |
| Dedup | Read existing memory and learnings | Read |
| Review | One candidate at a time | `AskUserQuestion` |
| Persist global | Write feedback file + index | Write/Edit |
| Persist project | Append to learnings.md | Edit |

## Common Mistakes

- **Persisting without per-lesson confirmation.** Always block on `AskUserQuestion` per candidate. No batch writes.
- **Hallucinating mistakes that weren't mistakes.** A user redirection is not always a model mistake — sometimes the user just changed their mind. When unsure, mark the candidate as low-confidence and let the user drop it.
- **Generic rules.** "Be more careful" is useless. Each rule must be specific enough that a future Claude can recognize when it applies.
- **Missing the why.** Without `**Why:**`, the rule rots — future Claude can't judge edge cases. Always include the reason.
- **Wrong scope.** Framework-specific rules (Rails conventions, design-system patterns) belong in project memory. Voice/tone, communication style, generic engineering principles belong in global. When ambiguous, default to project.
- **Editing CLAUDE.md directly.** This skill writes to memory files, never to CLAUDE.md. Memory files are designed for accumulation; CLAUDE.md is for stable instructions.
- **Reading the live session JSONL.** The JSONL for the active session is being written to as the conversation runs. For the current session, work from the in-context conversation only.

## Encoded cwd reference (for retrospective mode only)

When the user invokes retrospective mode without a specific path, list session JSONLs from `~/.claude/projects/<encoded-cwd>/`. The encoding is: full absolute path with `/` → `-` (a leading `/` becomes a leading `-`). Example: `/Users/pcil/projects/design-system` → `-Users-pcil-projects-design-system`.

This encoding is ONLY for picking session JSONL files. It is NOT used for global memory persistence — global memory always lives at the constant path `~/.claude/projects/-Users-pcil-projects/memory/` regardless of where the session was held.

## Confirmation

After persisting, briefly summarize:
- N lessons captured: M global, K project
- File paths written
- Suggest the user start a fresh session for the lessons to take effect (memory is loaded at session start)
