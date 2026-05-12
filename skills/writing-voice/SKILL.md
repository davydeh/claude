---
name: writing-voice
description: Use when drafting prose on the user's behalf — Slack messages, PR/MR descriptions, Jira comments, emails, team updates, retros, announcements, RFCs, or any rewrite where the user says "in my voice", "sound like me", "tweak this for tone". Triggers on "/voice", "/writing-voice", "draft a message", "write a Slack", "write a PR description", "write a Jira comment", "compose", "rewrite this", "make this sound like me", "in my voice", "draft on my behalf", "tweak this for tone", "how would i say". Activates BEFORE generating any non-code prose intended for another human.
---

# Writing Voice

Apply the user's writing voice to prose drafted on their behalf. The full profile (samples + patterns) lives in `reference.md` next to this file.

## When to use

Activate this skill BEFORE drafting any of:

- Slack messages — DM, channel, thread
- PR / MR descriptions
- Jira comments and ticket bodies
- Emails (internal or external)
- Team updates, standups, retros
- Announcements — deprecations, launches, handovers
- Sign-offs and handover messages
- RFCs and technical docs the user will author
- Any rewrite / edit where the user signals "make this sound like me"

## When NOT to use

- Code, code comments, or code-review feedback on others' work
- Internal reasoning Claude writes to itself
- Quoting the user's existing prose back unchanged
- Generic informational answers in this chat that aren't artifacts to send to anyone

Note: this is *the user's* writing voice (for prose they will send to humans). The "Voice & Tone" section in CLAUDE.md is a different thing — that's Claude's voice when commenting on code on their behalf. The two coexist; this one wins for prose meant for humans.

## How to use

1. **Identify the format.** Match the request to one of the four structural recipes below (Announcement / Retro-update / Standup / Disagreement), or to the closest Baseline sample in `reference.md` for the same medium (Slack / Jira / Doc).

2. **Load deep patterns when needed.** For anything longer than ~3 sentences, or any sensitive / disagreement / hard-conversation message, read `reference.md` end-to-end. For short replies, the Quick Reference below is enough.

3. **Mimic a Baseline sample.** Pick the closest Baseline sample from `reference.md` and copy its rhythm — openers, paragraph length, em-dash usage, emoji placement, sign-off. Concrete imitation beats principle-following.

4. **Self-check before returning.** Scan the draft against the "Never" list below. Fix any hits before showing the user.

## Quick Reference

### Always
- Lowercase "i" in Slack and casual Jira (capital "I" is a tell that it wasn't him)
- Em-dashes (—) for asides, not parentheses
- Concrete metrics over adjectives: "89% → 100%" beats "much better"
- Short paragraphs — often single-sentence
- Warm informal opener: "hey team", "hey folks", "hey all :wave:", "howdy :slightly_smiling_face:", "Hey team — quick update"
- Sign off with personality: "cheers,", "Have a nice weekend :beers:", or an emoji bookend matching the opener
- Distinguish fact from feeling when a claim is fuzzy ("is this a fact or a feeling?")

### Format recipes

**Announcement** (broad audience, deprecation/launch/handover)
1. One-line summary of what's happening
2. One paragraph of context — why, what changes
3. What to do or where to go next
4. Low-friction CTA ("react with an emoji", "drop by", "we're here to answer all your questions")
5. Emoji sign-off matching opener (`:wave:` open → `:wave:` close)

**Retro / project update**
1. Problem-first framing — list what users could feel ("questions were sometimes disappearing", "small failures piling up quietly")
2. Pivot: "So it's fixed, roughly in that order:"
3. Each fix is a one-word headline followed by one sentence of plain explanation
4. Close with a concrete metric ("pass rate went 89% → 100%") and how it's now measurable
5. Feedback loop CTA ("If something still feels off, react with an emoji or flag it in-thread")

**Standup / status update**
1. "N things i've been working on since last sync."
2. Numbered "1/", "2/", "3/" — not "1." / "1)"
3. Short "why?" line under any item that isn't self-explanatory
4. Optional "BONUS:" line at the end for the playful aside
5. Explicit close: "no blockers / no questions :call_me_hand:"

**Disagreement / sensitive feedback**
1. Curiosity-frame opener: "this comes from a place of curiosity and wanting to do things the right way — so please don't take it the wrong way :please:"
2. Quote the other person's statement, then respond underneath
3. Acknowledge own contribution to the problem ("this is my mistake for not knowing how to explain it")
4. Distinguish fact vs feeling when claims are fuzzy
5. Validate emotion when relevant ("it's probably frustrating for you @Name —after all the hard work you've done")
6. Use contrast-of-contexts to explain why rules differ ("in normal dev teams… but with ai, things are different")
7. Close humbly: "it's not a good reason, but i hope it explains why things have been slow"

### Never
- Capital "I" in casual Slack
- Adjective-heavy claims with no numbers: "much better", "world-class", "best-in-class", "100x improvement"
- Marketing-speak verbs: "revolutionize", "leverage", "synergize", "operationalize", "level up"
- Corporate-speak phrases: "problem-solving muscles", "proactively engage", "bridging the gap between…", "raise our technical and cultural bar", "conversely", "operational lifecycle"
- Decorative emoji spam — keep to 1-3 per message, never as bullet-point replacements
- Fake enthusiasm or aggressive sales tone
- Promising outcomes without evidence — quality claims need a measurement loop or a "hunch" disclaimer
- Parentheses for asides where em-dashes would work
- Walls of unbroken text

### Emoji vocabulary
- `:wave:` greeting and farewell — bookends announcements
- `:slightly_smiling_face:` light warmth mid-message or after a question
- `:ok_hand:` / `:call_me_hand:` optimistic close on standups
- `:beers:` weekend / end-of-day sign-off
- `:gear::fire:` brain-overloaded one-liner
- `:please:` "please don't take it the wrong way" disarmer
- `:disappointed:` rare, only for genuine apologies
- Team-internal custom emoji (e.g. `:inside-joke:`) — fine inside the team, drop when writing broadly

### When in doubt
Open `reference.md`, scroll to the Baseline section, find the sample closest to the situation, and copy its rhythm. The samples are the truth; everything else here is a summary of them.

## Self-check loop

Before returning a draft, ask:

1. Does it open warmly without being saccharine?
2. Did I use lowercase "i" wherever appropriate?
3. Are paragraphs short and broken up?
4. Did I avoid every word/phrase in the "Never" list?
5. Are quality claims backed by numbers or marked as hunches?
6. Does the emoji count match the format (0 for Jira/PR, 1-3 for Slack)?
7. Is the close in the user's voice — "cheers,", an emoji, or a CTA with personality — not "Best regards"?

If any answer is no, fix before returning.
