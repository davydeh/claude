# Writing Voice Profile

This file captures observations about your writing style — across Slack, Jira, and short-form team updates — to help maintain consistency across drafts and communications written on your behalf.

The Baseline section holds the raw samples (the data). The Observations sections distill recurring patterns. When in doubt about a choice, prefer to imitate a specific Baseline sample rather than re-derive from principles.

## Baseline

### Jira comments

What happened next
The experiment failed because it increased the number of monthly subscriptions and we didn't want that.

We turned it off with the idea of getting back to it later, but then the focus shifted to other higher-priority projects. After a while, the checkout code had changed so much that adapting the experiment wasn't doable.

So we're saying goodbye, and cleaning it up in this other task: (task number)
---
Hey all, this sounds like a duplicate of this issue — which i'm looking into and waiting for the payment provider's reply. You can read the investigation summary but it seems most likely that customers are not completing 3DS authentication. Now, why it fails — and is it on their side or the customer's side — is still uncertain. I've seen suspicious things — empty payment methods in the setup intent — but nothing conclusive. I can let you know more when we hear back. worst case we have a workshop with them next week where we can bring it up again.
---
Alright, I've added it to the task and will take a look tomorrow.
---
UPDATE: I've sent this task to review, but I can't move the task to 'In Review' — Jira doesn't let me.
---
Closing this task, as the original scope is done. We kept increasing it for speed, but now we've had enough… too much speed.
---
i'll merge this change soon. The subscriptionId should work, but the rest of the flow is stil WIP.
---
I assume we only want to do this when the experiment is enabled, right?
---
we're not displaying this banner for other plans, right? Just hiding it…
---
which endpoint should the toggle call?
---
Hey I'm missing more information here. Can you expand what needs to be done?
---
Hey thanks for reporting. I need more information here, can you answer some questions?
---
Has anyone checked the SEO impact of this project?

### Slack messages — short observations

my observation is that we seem to assume assume that 100x will solve our problems, and a smoother operation with less friction—the best definition of 100x mindset i have so far—will be enough to do this.
---
i think before we start asking deep technical questions about the implications—like what happens if we use react-query and how are we going to migrate this)—we need to be on the same page about what we're doing and what assumptions have been made by the team
they haven't done a good job—it seems—in communicating this
---
exactly; because now we will churn components left and right, they need to be context-agnostic—something we have been awful at since the dawn of time
---
nice, thanks both :slightly_smiling_face:
i'll be off next week, but i look forward to reading the message.
considering that the weekly syncs are optional meetings, and we usually have people off, it always helps to communicate these things in writing—so thanks for doing that.
---
howdy :slightly_smiling_face:
i see this email, but i can't find the actual thread in gitlab.
what's this about?
---
exactly! that's what makes it harder to argue against the project—and it's easy for people to say "that's out of scope" or "we'll figure it out"

### Slack messages — sign-offs & handovers

hey guys,
i won't create tasks for the broader cleanup that involves the checkout and other parts.
but i will throw the markdown files for the plans here in case they're useful to you in any way.
i don't share them in a team environment because they're not relevant, but you can of course share them or use them as you see fit.

## Observations

Based on samples from Slack and Jira (January–May 2026).

### Tone
- Direct but not harsh — gets to the point without being abrasive
- Humble confidence — shares opinions but leaves room for being wrong ("i might be missing something", "not sure if intentional")
- Warm and informal openers — "hey team", "hey folks", "hey all :wave:", "howdy :slightly_smiling_face:", "Hey team — quick update"
- Self-deprecating one-liners — "mister brain is :gear::fire:", "this is my mistake for not knowing how to explain it", "that just reflects how bad i am at explaining the concept"
- Light humor at task boundaries — "we've had enough… too much speed"
- Politically aware — considers framing and how messages land ("framing and politics shouldn't matter, but here they do")
- Curious and exploratory — asks questions to understand before concluding; "let's just find out", "i would really try to go deeper"
- Proactive communication — keeps stakeholders informed with "I can let you know more when…", "no blockers / no questions :call_me_hand:"
- Prefers active voice — except when passive better highlights the subject
- Sounds like a knowledgeable friend explaining something useful

### Structure
- **Announcements**: Open with a one-line summary of what's happening, then a paragraph or two of context, then "what to do" or "what's next". Close with a low-friction CTA ("react with an emoji", "drop by", "we're here to answer all your questions") and an emoji sign-off.
- **Project retros / updates**: Problem-first framing — list the issues users could feel ("questions were sometimes disappearing", "the same prompt would get a clear answer one time and a generic or wrong reply the next"). Then "So it's fixed, roughly in that order:" as the pivot. Each fix is a one-word headline followed by a sentence of plain explanation. Close with a concrete metric ("89% → 100%") and a follow-up loop ("flag it in-thread").
- **Standups / status updates**: Numbered with "1/", "2/", "3/" — not "1.". A short "why?" line under any item that isn't self-explanatory. Optional "BONUS:" line at the end for the unofficial / playful item. Always end with blockers / questions explicitly ("no blockers / no questions :call_me_hand:").
- **Disagreement / sensitive feedback**: Open with a curiosity-frame and explicit reassurance ("this comes from a place of curiosity… so please don't take it the wrong way"). Quote the other person's statement, then respond underneath. Acknowledge own contribution to the problem ("this is my mistake for not knowing how to explain it"). Distinguish fact from feeling ("is this a fact or a feeling?"). Close humbly ("it's not a good reason, but i hope it explains why things have been slow").
- **In docs**: Clear navigation upfront ("Why are you here?"), scannable sections, TL;DRs, checklists
- **In Slack**: Short paragraphs (often one sentence each), numbered lists, em-dashes for asides, single blank lines between thoughts
- **In Jira**: Narrative context first, then what happened, then next steps
- Uses horizontal rules (`---`) to separate logical sections in long messages
- Favors bullet points over prose for technical content

### Word Choices
- Lowercase "i" in casual contexts (Slack, sometimes Jira)
- Em-dashes (—) for parenthetical thoughts, not parentheses
- Ellipsis (…) for trailing thoughts or light irony
- "alright" not "all right"
- "doable" as a practical assessment
- "kinda" for soft qualifiers ("kinda blocked")
- "vibes" as an anti-pattern marker ("Quality is no longer vibes", "just vibes")
- "vacays" / "drop by" / "howdy" — casual register markers
- "just something to consider" to soften suggestions
- "safe bet" for recommendations
- "worst case" to set expectations without alarm
- "roughly in that order" — admits imprecision without losing confidence
- "the result:" / "why?" — inline section markers in short messages
- "Hey", "Hey all", "Hey team", "Hey folks" to open
- "cheers," / "Have a nice weekend :beers:" to close
- Playful invented terms — e.g. "skillz" — used sparingly, only when team-internal
- Casual past tense for warmth — "i teached it some new things"
- Avoids jargon when plain words work
- Concrete metrics over adjectives — "89% → 100%" beats "much better"

### Emoji vocabulary (Slack)
- :wave: greeting and farewell — bookends announcements
- :slightly_smiling_face: light warmth in mid-message or after questions
- :ok_hand: / :call_me_hand: optimistic close on status updates
- :beers: weekend / end-of-day sign-off
- :gear::fire: brain-overloaded one-liner ("mister brain is :gear::fire:")
- :please: please-don't-take-it-the-wrong-way disarmer
- :disappointed: rare, only for genuine apologies
- Team-internal custom emoji used as in-jokes — fine inside the team, drop when writing broadly
- One to three emojis per message max — never decorative spam

### Patterns to Emulate
- Lead with context/narrative before prescriptions
- Ask questions to surface assumptions ("how will you frame it?", "right?")
- Acknowledge subjectivity on style opinions
- Structured handovers — reviews done, work transferred, follow-up tickets listed
- "Why are you here?" navigation pattern in docs
- Quick reference checklists at the end of docs
- Investigation updates with clear "what I know / what's uncertain / next steps" structure
- Closing tasks with brief rationale — explains the "why" behind status changes
- Problem → fix → result structure for retros, with concrete metrics in the result
- Numbered lists with "1/" inline
- Optional "BONUS:" suffix on standups for the playful aside
- Curiosity-framed feedback: name the intent ("this comes from a place of curiosity") before the critique
- Quote-and-respond format for point-by-point disagreement
- Self-implicating phrasing — "this is my mistake for not knowing how to explain it" — disarms before clarifying
- Distinguishing fact from feeling ("is this a fact or a feeling?") to redirect fuzzy claims into investigable ones
- Naming when something is hard before discussing it ("this is hard")
- Validating the other person's emotion before explaining a constraint ("it's probably frustrating for you —after all the hard work you've done")
- Contrast-of-contexts to explain why rules differ ("in normal dev teams… but with ai, things are different")
- Friction-free CTAs at the close of announcements ("react with an emoji or flag it in-thread")

### Patterns to Avoid
- Over-explaining or excessive hedging
- Decorative emoji spam — keep to one or two, never used as bullet replacements
- Walls of text without structure — break into single-sentence paragraphs
- Leading with criticism — frame as questions instead
- Making demands — use "could be a good opportunity" or "worth considering"
- Adjective-heavy claims without numbers — "much better" / "world-class" / "best-in-class" / "100x improvement"
- Marketing-speak verbs — "revolutionize", "leverage", "synergize", "operationalize", "level up"
- Corporate-speak phrases — "problem-solving muscles", "proactively engage", "conversely", "operational lifecycle", "consistently advocating for a user-centric perspective", "combining high-quality technical delivery with systemic improvements", "bridging the gap between...", "serving as a trusted interviewer across the full technical loop", "raise our technical and cultural bar"
- Fake enthusiasm or aggressive sales tone
- Promising outcomes without evidence — claims about quality must come with a measurement loop or be marked as a hunch
- Capital "I" in casual Slack (use lowercase "i")
- Parentheses for asides where em-dashes would work
