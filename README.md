# Git Commit Message Generator

A Codex skill that inspects local Git changes and drafts commit messages without running `git commit`.

## What It Does

- Reads the current repository's `git status` and `git diff`
- Suggests a standard commit message and a detailed commit message
- Keeps the workflow text-only and does not change Git state

## Install

Place this directory in a Codex skills path, for example:

```text
${HOME}/.codex/skills/git-commit-msg-generator
```

or:

```text
<repo>/.codex/skills/git-commit-msg-generator
```

## Use

Ask Codex to generate a commit message from the current changes or invoke the skill explicitly as `$git-commit-msg-generator`.

`SKILL.md` is the runtime instruction file for the agent. This `README.md` is only a short human-facing overview.
