---
name: git-commit-generator
description: Generate commit messages from local Git changes when the user asks to summarize staged, unstaged, or untracked work into a commit message, commit summary, or 提交信息. Text only: inspect `git status` and `git diff`, return commit message options, and never run `git commit`, `git push`, or other state-changing Git commands.
---

# Git Commit Generator

## Use This Skill When

- 用户要求根据当前仓库变更生成 commit message、提交说明、提交摘要，或要求“帮我写 commit”。
- 用户提供了 `git status`、`git diff`、暂存区/未暂存/未跟踪文件信息，希望整理成语义化 commit。
- 用户要的是文本建议，不是实际执行提交。

## Do Not Use This Skill When

- 用户明确要求实际执行 `git commit`、`git push`、`git add`、`git reset`、`git stash` 或其他会改变仓库状态的 Git 命令。
- 用户主要诉求是分支管理、冲突解决、历史改写、发布流程或 Git 教学，而不是生成 commit 文本。

## Resource Paths

本技能内提到的相对路径，都应以当前这个 `SKILL.md` 所在目录作为基准，也就是技能目录 `<skill_dir>`：

- 脚本：`<skill_dir>/scripts/get_git_info.sh`
- 参考资料：`<skill_dir>/references/commit_types.md`

## Workflow

1. **定位技能目录**：先将本文件所在目录视为 `<skill_dir>`，不要假设资源文件位于用户当前工作目录。
2. **收集 Git 上下文**：
   - 优先在用户目标仓库的当前工作目录执行 `bash <skill_dir>/scripts/get_git_info.sh`。
   - 如果用户已经提供 `git status` / `git diff` / patch 信息，则直接使用用户给出的内容。
3. **失败回退**：
   - 如果脚本不存在、执行失败，或当前目录不是有效 Git 仓库，要求用户提供 `git status` 和 `git diff`，或切换到目标仓库后再试。
4. **分析变更**：
   - 识别修改、新增、删除、重命名的文件及主要代码改动。
   - 判断最核心的单一变更意图，例如 `feat`、`fix`、`refactor`、`ui`、`doc`。
5. **匹配规范**：按需读取 `<skill_dir>/references/commit_types.md`，选择最匹配的单个 Type 和 Emoji。
6. **提取范围**：如果改动明显集中在单个模块、组件、页面、包或目录，可添加 scope，例如 `ui(navbar)`。
7. **生成输出**：严格输出“普通版”和“详细版”两种格式，不要附加寒暄或解释。

## Output

每次必须输出以下两种格式（不要包含多余的寒暄）：

### Option 1: 普通版 (Standard)

直接给出一行式的 commit，格式为：

```plaintext
<emoji> <type>[(scope)]: <subject>
```

**示例**：

```plaintext
💄 ui(maintenance): update maintenance UI and refine status badge contrast
```

### Option 2: 详细版 (Detailed)

包含标题和分点描述（Body），格式为：

```plaintext
<emoji> <type>[(scope)]: <subject>
<空行>
- <bullet point 1>.
- <bullet point 2>.
```

**示例**：

```plaintext
💄 ui: redesign maintenance page and align status badge colors

- use `createdAt` from the API instead of `created_at`.
- rebuild the maintenance page as a centered status card with light/dark theme support.
- strengthen the secondary "View status page" button on the 400, 404, and 500 pages.
- slightly darken degraded and maintenance badge backgrounds on `/site-status`.
```

## Notes

- **Subject 限制**：简短描述（subject）不要超过 100 个字符。
- **内容独立性**：普通版（Option 1）的一行式描述与详细版（Option 2）的标题（`<subject>`）不必完全一致，可根据“精简概括”和“引领下文”的不同语境独立优化表达。
- **语言要求**：如果没有特殊指定，默认使用**英文**编写具体的 commit 内容。
- **代码格式化**：当描述中出现具体的代码片段、变量名、文件名或路由（如 `userId`、`index.js`、`/api/login`）时，必须使用反引号 ("`") 进行包裹。
- **仅生成文本**：本技能仅作为文本生成器，不得触发任何系统级的 `git commit`、`git push` 或其他状态变更命令。
- **信息不足时要收敛**：如果上下文不足以判断真实变更意图，不要编造细节，应明确指出缺少哪些 Git 信息。
