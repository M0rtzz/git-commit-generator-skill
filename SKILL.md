---
name: git-commit-generator
description: Draft commit messages from the current Git changes. Use when the user wants a commit message or commit summary for staged, unstaged, or untracked work without creating a commit.
disable-model-invocation: true
shell: bash
---

# Git Commit Generator

## Git Context

!`bash "${CLAUDE_SKILL_DIR}/scripts/get_git_info.sh" 2>&1 || true`

## Additional Resources

- For commit type and emoji mapping, see [references/commit_types.md](references/commit_types.md).

## Your Task

Use the Git context above to draft commit messages without executing any state-changing Git command.

1. If the injected Git context contains `[ERROR] Current directory is not inside a Git work tree.`, stop and ask the user to switch to the target repository or provide `git status` and `git diff` manually.
2. If the user already provided `git status`, `git diff`, or a patch in the conversation, prefer the user's data over the injected Git context when they conflict.
3. Analyze the changed, added, deleted, renamed, staged, unstaged, and untracked files to identify the primary intent of the change.
4. Read [references/commit_types.md](references/commit_types.md) when you need the canonical type and emoji mapping. Choose the single best matching type.
5. Extract an optional scope only when it improves clarity:
   - If the change is clearly concentrated in one module, component, page, or package, you may use a logical scope such as `ui(navbar)`.
   - If the change only affects one directory, or only one file was added, removed, renamed, or modified, you may use the directory name or file name as the scope, such as `feat(api/)`, `doc(README.md)`, `remove(legacy.js)`, or `config(eslint.config.js)`.
6. Never run `git commit`, `git add`, `git push`, `git reset`, `git stash`, or any other state-changing Git command.
7. Return exactly the two output formats below and do not add preambles, explanations, or extra commentary.

## Output

Always return both of the following options:

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

- **Subject limit**: Keep the subject under 100 characters.
- **Independent subjects**: The one-line subject in Option 1 and the title in Option 2 do not need to be identical if a tighter summary improves clarity.
- **Language**: Unless the user explicitly asks otherwise, write the commit content in English.
- **Code formatting**: Wrap code identifiers, file names, variables, and routes such as `userId`, `index.js`, or `/dashboard` in backticks.
- **Stay factual**: If the available Git context is incomplete or ambiguous, do not invent details. Ask for the missing Git information instead.
