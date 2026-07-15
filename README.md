# Git Commit Message Generator

A Gemini CLI agent skill that inspects local Git changes and drafts commit messages without running `git commit`.

## What It Does

- Reads the current repository's `git status` and `git diff`
- Suggests a standard commit message and a detailed commit message
- Keeps the workflow text-only and does not change Git state

## Install

Install the skill directly with Gemini CLI:

```text
gemini skills install /path/to/git-commit-msg-generator
```

Link it instead of copying it:

```text
gemini skills link /path/to/git-commit-msg-generator
```

Install or link it into the current workspace:

```text
gemini skills install /path/to/git-commit-msg-generator --scope workspace
gemini skills link /path/to/git-commit-msg-generator --scope workspace
```

Gemini CLI also discovers skills placed under `.gemini/skills/` or the cross-tool alias `.agents/skills/`.

## Use

Ask Gemini naturally, for example:

```text
draft a commit message from the current git changes
write a detailed commit summary for this diff
```

Gemini CLI will activate the skill automatically when the request matches the `SKILL.md` description.

`SKILL.md` is the runtime instruction file for the agent. `scripts/` and `references/` contain the bundled resources the skill uses when it is activated.
