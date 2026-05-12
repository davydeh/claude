# claude-config

Personal Claude Code config, portable across machines.

## Install

```bash
git clone <repo-url> ~/projects/claude-config
cd ~/projects/claude-config
./install.sh
```

The script symlinks each file into `~/.claude/`. Existing files are backed up with a timestamp suffix before being replaced.

## Contents

- `CLAUDE.md` — Global Claude Code guidelines (voice, task endings, efficiency principles, pre-completion checklist).
- `settings.json` — Permissions, status line, `defaultMode: auto`, `alwaysThinkingEnabled`, `cleanupPeriodDays: 99999`, `skipDangerousModePermissionPrompt`. Marketplaces and plugins are not vendored — install fresh per machine.
- `statusline.sh` — Shows model name and total cost, right-aligned.
- `memory/general.md` — General persistent notes.
- `agents/chrome-devtools-frontend-tester.md` — Frontend tester driving Chrome via the chrome-devtools MCP.
- `skills/` — `content-review`, `learn-from-mistakes`, `pandora`, `remember`.

## What's intentionally not here

- Marketplace plugins (`enabledPlugins`, `extraKnownMarketplaces`) — reinstall as needed on each machine via `/plugin`.
- Runtime/cache data (`history.jsonl`, `sessions/`, `tasks/`, `todos/`, `telemetry/`, etc.).
- Anything employer- or project-specific.

## Workflow

Files are symlinks, so edits in `~/.claude/` write back into this repo. Commit and push to sync.
