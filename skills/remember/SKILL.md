---
name: Remember
description: Use when the user wants to save information, learnings, or preferences for future sessions. Triggers on "/remember", "remember this", "save this for later", "don't forget", or when user wants to persist knowledge.
---

# Remember Skill

Saves information to organized memory files so it persists across sessions without bloating the main CLAUDE.md.

## When to Use
- User says "/remember [information]"
- User says "remember this", "save this for later", "don't forget that..."
- User wants to persist learnings, preferences, or notes

## Memory Structure

```
~/.claude/
  CLAUDE.md                     # Core instructions only (don't add notes here)
  memory/
    code-review.md              # Global code review learnings
    preferences.md              # Global preferences and style
    general.md                  # Other global notes

<project>/.claude/
  CLAUDE.md                     # Project instructions (don't add notes here)
  memory/
    patterns.md                 # Project-specific patterns and conventions
    learnings.md                # Project-specific learnings
    general.md                  # Other project notes
```

## How to Save

### Step 1: Determine Scope
Ask the user (or infer from context):
- **Project-specific**: Applies only to the current codebase (e.g., "@deepl/ui Icon handles aria-hidden")
- **Global**: Applies everywhere (e.g., "I prefer concise commit messages")

Use AskUserQuestion if unclear:
```
Question: "Is this specific to this project or a global preference?"
Options: ["This project only", "Global (all projects)"]
```

### Step 2: Determine Category
Based on the content, choose the appropriate file:

**Global categories** (`~/.claude/memory/`):
| Category | File | Examples |
|----------|------|----------|
| Code review | `code-review.md` | Review preferences, things to ignore/flag |
| Preferences | `preferences.md` | Communication style, formatting preferences |
| General | `general.md` | Anything else |

**Project categories** (`<project>/.claude/memory/`):
| Category | File | Examples |
|----------|------|----------|
| Patterns | `patterns.md` | Code patterns, architectural decisions |
| Learnings | `learnings.md` | Bugs found, gotchas, things that work |
| General | `general.md` | Anything else |

### Step 3: Save the Note

1. Create the `memory/` directory if it doesn't exist
2. Create or append to the appropriate file
3. Use this format:

```markdown
# <Category> Notes

- [YYYY-MM-DD] <note content>
- [YYYY-MM-DD] <another note>
```

### Step 4: Confirm
Tell the user what was saved and where.

## Example Flows

### Project-specific note
```
User: /remember @deepl/ui Icon component handles aria-hidden automatically
Assistant:
  - Scope: Project (inferred from @deepl/ui reference)
  - Category: Patterns
  - Saved to: /Users/pcil/projects/frontend/.claude/memory/patterns.md
```

### Global preference
```
User: /remember I prefer PR descriptions with bullet points
Assistant:
  - Scope: Global
  - Category: Preferences
  - Saved to: ~/.claude/memory/preferences.md
```

## Loading Memory Files

Memory files are NOT automatically loaded. They should be read on-demand by relevant skills:

- `/review` skill should read `memory/code-review.md` (both global and project)
- Other skills read relevant memory files as needed

When creating or updating other skills, add logic to read from the appropriate memory files.

## Guidelines
- Keep notes concise but complete
- One idea per bullet point
- Don't duplicate existing notes - read the file first
- Include enough context to be useful later
- Prefer specific examples over vague descriptions
