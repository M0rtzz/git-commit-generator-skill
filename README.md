# Git Commit Generator

A Claude Code skill that inspects local Git changes and drafts commit messages without running `git commit`.

## What It Does

- Reads the current repository's `git status` and `git diff`
- Suggests a standard commit message and a detailed commit message
- Keeps the workflow text-only and does not change Git state

## Install

Place this directory in a Claude Code skills path, for example:

```text
~/.claude/skills/git-commit-generator
```

or:

```text
<project>/.claude/skills/git-commit-generator
```

## Use

Invoke the skill directly with `/git-commit-generator` when you want commit message suggestions from the current repository changes.

`SKILL.md` is the runtime instruction file Claude Code reads. This `README.md` is only a short human-facing overview.
