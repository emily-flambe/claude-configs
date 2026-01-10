# Sync Installation

Verify the symlink is correctly set up and the installed version matches the repo.

## Steps:

1. Check if `~/.claude/CLAUDE.md` exists
2. Verify it's a symlink pointing to this repo's CLAUDE.md
3. Compare file contents to detect any divergence
4. Report status and suggest fixes if needed

## Commands to run:

```bash
# Check symlink
ls -la ~/.claude/CLAUDE.md

# Verify target
readlink ~/.claude/CLAUDE.md

# Compare if needed
diff ~/.claude/CLAUDE.md ./CLAUDE.md
```
