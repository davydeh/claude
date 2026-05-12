---
name: content-review
description: Review RFCs, posts, articles, and other written content to find blind spots, missed ideas, and ways to strengthen the argument.
---

# Content Review Skill

Review RFCs, posts, articles, and other content to find blind spots, missed ideas, and ways to strengthen arguments.

## Triggers

Use this skill when the user says:
- "review this [post/RFC/article/doc]"
- "critique this"
- "what did they miss"
- "analyze this [content type]"
- "find the blind spots in this"
- "steelman this"

## Input Handling

Detect input type and fetch content appropriately:

1. **URL provided** → Use WebFetch (or Atlassian MCP for Confluence URLs)
2. **File path provided** → Use Read tool
3. **Text pasted inline** → Analyze directly from the message
4. **Ambiguous source** → Ask user to clarify

### Confluence Detection

If the URL contains `atlassian.net/wiki` or looks like a Confluence page:
1. Use `mcp__atlassian__getAccessibleAtlassianResources` to get the cloudId
2. Extract the page ID from the URL
3. Use `mcp__atlassian__getConfluencePage` with `contentFormat: "markdown"`

## Output Structure

Always produce output in this order:

### 1. Quick Take (2-3 paragraphs)

Start with a brief, digestible summary:
- What is the core claim or thesis?
- What's missing or weak?
- What would make it stronger?

---

### 2. Full Analysis

After a divider, provide the complete breakdown:

#### Key Takeaways
- Bullet list of the main points the author is making

#### Argument Structure
- How does the reasoning flow?
- What's the logical chain?

#### Strengths
- Where is the argument solid?
- What evidence or reasoning is compelling?

#### Weaknesses
- Where is it shaky or unsubstantiated?
- What claims lack support?

#### Blind Spots
- **Unstated assumptions** — What does the author take for granted?
- **Missing stakeholders** — Whose perspective is absent?
- **Unconsidered alternatives** — What options weren't explored?
- **Logical gaps** — Where does the reasoning skip steps?
- **Counter-evidence** — What contradictory data exists?

#### What They Got Right
- Credit where due — acknowledge strong points

#### Argument Against (Steelman Critique)
Write 2-3 paragraphs presenting the strongest possible critique of the content. Argue against the author's position as if you were their most thoughtful opponent.

#### Argument For (Steelman Defense)
Write 2-3 paragraphs presenting the strongest possible defense of the content. Argue for the author's position as if you were their most persuasive advocate.

## Clarification Logic

Ask questions **before** analyzing only when:
- Content type is genuinely unclear (Is this satire? A draft? A final document?)
- Author's intent is ambiguous and affects interpretation
- Context matters significantly (Is this for internal or external audience? What's the goal?)

Do **not** ask clarifying questions for:
- Minor ambiguities you can reasonably interpret
- Stylistic choices
- Missing context you can work around

Default to analyzing with reasonable assumptions, noting them where relevant.

## Example Invocations

```
User: review this https://example.com/blog/our-new-strategy
→ Fetch URL with WebFetch, then analyze

User: critique this [followed by pasted text]
→ Analyze the pasted text directly

User: what did they miss in ~/docs/proposal.md
→ Read the file, then analyze

User: find the blind spots in this Confluence page https://company.atlassian.net/wiki/spaces/ENG/pages/123456789
→ Use Atlassian MCP to fetch, then analyze
```

## Voice

Follow the standard voice guidelines:
- Direct but humble
- Questions over declarations for issues
- Acknowledge when something is subjective vs objective
- Frame critiques as opportunities, not attacks
