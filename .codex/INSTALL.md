# Installing Superpowers for Codex

Codex-facing skill source-of-truth has moved to the separate `codex-skills` repository. This file remains as a redirect.

## Prerequisites

- Git

## Installation

1. Clone or open your local `codex-skills` repository.
2. Rebuild `codex-skills/runtime/skills`.
3. Ensure `~/.codex/skills` points to that runtime overlay.
4. Restart Codex.

## Codex CLI Tool Mapping

Superpowers skill text may mention generic patterns. In Codex CLI, use:
- Task/checklist tracking: `update_plan`
- Parallel specialist agents: `spawn_agent` + `wait`
- Skill usage: read matching `SKILL.md` from discovered skill folders before acting

## Migrating from old bootstrap

If you installed superpowers before native skill discovery, you need to:

1. **Update the repo:**
   ```bash
   cd ~/.codex/superpowers && git pull
   ```

2. **Create the skills symlink** (step 2 above) — this is the new discovery mechanism.

3. **Remove the old bootstrap block** from `~/.codex/AGENTS.md` — any block referencing `superpowers-codex bootstrap` is no longer needed.

4. **Restart Codex.**

## Verify

```bash
ls -la ~/.agents/skills/superpowers
```

You should see the unified Codex runtime skills directory exposed from `codex-skills`.

## Updating

Update `codex-skills`, not this repository, when you want to change Codex skills.

## Uninstalling

```bash
rm ~/.agents/skills/superpowers
```

Optionally delete the clone: `rm -rf ~/.codex/superpowers`.
