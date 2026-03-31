---
name: git-commit-generator
description: Use this skill when the user wants a Git commit message, commit summary, or commit body for staged, unstaged, or untracked changes without creating a commit. It inspects local Git state or user-provided diffs and returns commit text only.
---

# Git Commit Generator

This skill drafts commit text from repository changes. It is text-only and must never change Git state.

## Resource Paths

All relative paths mentioned in this skill are resolved from the directory that contains this `SKILL.md`, referred to as `<skill_dir>`:

- Script: `<skill_dir>/scripts/get_git_info.sh`
- Reference: `<skill_dir>/references/commit_types.md`

## Workflow

1. **Locate the skill directory**: Treat the directory containing this file as `<skill_dir>`. Do not assume the resource files are in the user's current working directory.
2. **Collect Git context**:
   - Prefer running `bash <skill_dir>/scripts/get_git_info.sh` from the user's target repository working directory.
   - If the user already provided `git status`, `git diff`, or patch information, use the user's data directly.
3. **Fallback on failure**:
   - If the script does not exist, fails to run, or the current directory is not a valid Git repository, ask the user to provide `git status` and `git diff`, or switch to the target repository and try again.
4. **Analyze the changes**:
   - Identify modified, added, deleted, and renamed files together with the key code changes.
   - Determine the single primary intent of the change, such as `feat`, `fix`, `refactor`, `ui`, or `doc`.
5. **Match the convention**: Read `<skill_dir>/references/commit_types.md` as needed and choose the single best matching type and emoji.
6. **Extract scope**: If the change is clearly concentrated in one module, component, page, or package, you may add a scope such as `ui(navbar)`. If the change only affects one directory, or only one file was added, removed, renamed, or modified, you may use the directory name or file name inside `()`, such as `feat(utils/)`, `doc(README.md)`, `remove(legacy.js)`, or `config(eslint.config.js)`.
7. **Generate the output**: Return exactly the two required formats below without adding greetings, explanations, or extra commentary.

## Output

Always return both of the following formats:

### Option 1: Standard

Give a one-line commit message in this format:

```plaintext
<emoji> <type>[(scope)]: <subject>
```

**Example**:

```plaintext
💄 ui(maintenance): update maintenance UI and refine status badge contrast
```

### Option 2: Detailed

Give a title plus bullet points in this format:

```plaintext
<emoji> <type>[(scope)]: <subject>
<blank line>
- <bullet point 1>.
- <bullet point 2>.
```

**Example**:

```plaintext
💄 ui: redesign maintenance page and align status badge colors

- use `createdAt` from the API instead of `created_at`.
- rebuild the maintenance page as a centered status card with light/dark theme support.
- strengthen the secondary "View status page" button on the 400, 404, and 500 pages.
- slightly darken degraded and maintenance badge backgrounds on `/site-status`.
```

## Notes

- **Text only**: Never run `git commit`, `git push`, `git add`, `git reset`, `git stash`, or any other state-changing Git command.
- **Subject limit**: Keep the subject under 100 characters.
- **Independent subjects**: The one-line subject in Option 1 and the title in Option 2 do not need to be identical if a tighter summary improves clarity.
- **Language**: Unless the user explicitly asks otherwise, write the commit content in English.
- **Code formatting**: Wrap code identifiers, file names, variables, and routes such as `userId`, `index.js`, or `/dashboard` in backticks.
- **Stay factual**: If the available context is incomplete or ambiguous, do not invent details. Clearly ask for the missing Git information instead.
