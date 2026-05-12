# Skills

Personal skills loaded by Claude Code from `~/.claude/skills/` (via the symlinks `install.sh` sets up).

| Skill | What it does | Trigger |
|---|---|---|
| [`content-review`](./content-review/SKILL.md) | Review RFCs, posts, articles, and other written content. Outputs Quick Take + full analysis (argument structure, blind spots, steelman for/against). Detects Confluence URLs and uses the Atlassian MCP when needed. | "review this post", "critique this", "find the blind spots", "steelman this" |
| [`learn-from-mistakes`](./learn-from-mistakes/SKILL.md) | End-of-session retrospective. Scans the transcript for correction/frustration signals, drafts feedback candidates, and (after per-lesson confirmation) persists them to global feedback memory or project `.claude/memory/learnings.md`. | "/learn-from-mistakes", "before we wrap up", "what did I do wrong", "session postmortem" |
| [`pandora`](./pandora/SKILL.md) | Scaffolds a new Laravel 13 / Inertia v3 / React 19 / Fortify / Wayfinder project from the `davydeh/pandora` starter kit. Handles the installer prompts or runs the manual steps if non-interactive. | "/pandora", "new laravel project", "create a new app" |
| [`remember`](./remember/SKILL.md) | Persists notes to scoped memory files (`~/.claude/memory/` for global, `<project>/.claude/memory/` for project-specific) instead of bloating CLAUDE.md. Asks for scope when ambiguous. | "/remember", "remember this", "save this for later", "don't forget" |

## Adding a new skill

1. Create `skills/<name>/SKILL.md` with YAML frontmatter (`name`, `description`).
2. Add a row to the table above.
3. Re-run `./install.sh` from the repo root to symlink the new skill into `~/.claude/skills/`.
4. Restart Claude Code so it picks up the new entry.
