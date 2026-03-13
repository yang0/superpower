# Superpowers for Codex

Guide for the Superpowers workflow model in Codex. The Codex-facing skill source-of-truth now lives in the separate `codex-skills` repository.

## Quick Install

Use `codex-skills/runtime/skills` as the single Codex runtime target.

## Manual Installation

### Prerequisites

- OpenAI Codex CLI
- Git

### Steps

1. Clone or open the `codex-skills` repository.
2. Rebuild the runtime overlay from `codex-skills/scripts/rebuild_runtime_skills_overlay.ps1`.
3. Ensure `~/.codex/skills` points to `codex-skills/runtime/skills`.
4. Restart Codex.

### Windows

Use a junction instead of a symlink (works without Developer Mode):

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
cmd /c mklink /J "$env:USERPROFILE\.agents\skills\superpowers" "$env:USERPROFILE\.codex\superpowers\skills"
```

## How It Works

Codex has native skill discovery. In this environment, the runtime view is provided through the `codex-skills` overlay:

```
~/.codex/skills/ → <codex-skills>/runtime/skills/
```

The `using-superpowers` skill is discovered automatically and enforces skill usage discipline — no additional configuration needed.

## Codex Tool Mapping

When Superpowers asks for workflow primitives, use Codex-native tools:
- checklist/todo tracking -> `update_plan`
- parallel specialist workers -> `spawn_agent` and `wait`
- skill invocation -> read the matching `SKILL.md` and follow it before coding

## Usage

Skills are discovered automatically. Codex activates them when:
- You mention a skill by name (e.g., "use brainstorming")
- The task matches a skill's description
- The `using-superpowers` skill directs Codex to use one

### Personal Skills

Create your own skills in `~/.agents/skills/`:

```bash
mkdir -p ~/.agents/skills/my-skill
```

Create `~/.agents/skills/my-skill/SKILL.md`:

```markdown
---
name: my-skill
description: Use when [condition] - [what it does]
---

# My Skill

[Your skill content here]
```

The `description` field is how Codex decides when to activate a skill automatically — write it as a clear trigger condition.

## Updating

```bash
cd ~/.codex/superpowers && git pull
```

Skills update instantly through the symlink.

## Uninstalling

```bash
rm ~/.agents/skills/superpowers
```

**Windows (PowerShell):**
```powershell
Remove-Item "$env:USERPROFILE\.agents\skills\superpowers"
```

Optionally delete the clone: `rm -rf ~/.codex/superpowers` (Windows: `Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\superpowers"`).

## Troubleshooting

### Skills not showing up

1. Verify the symlink: `ls -la ~/.agents/skills/superpowers`
2. Check skills exist: `ls ~/.codex/superpowers/skills`
3. Restart Codex — skills are discovered at startup

### Windows junction issues

Junctions normally work without special permissions. If creation fails, try running PowerShell as administrator.

## Getting Help

- Report issues: https://github.com/obra/superpowers/issues
- Main documentation: https://github.com/obra/superpowers
