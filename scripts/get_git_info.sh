#!/usr/bin/env bash

set -euo pipefail

function terminalWidth() {
    local width="${COLUMNS:-}"

    if ! [[ "${width}" =~ ^[0-9]+$ ]] || [ "${width}" -le 0 ]; then
        if command -v tput >/dev/null 2>&1; then
            width=$(tput cols 2>/dev/null || true)
        fi
    fi

    if ! [[ "${width}" =~ ^[0-9]+$ ]] || [ "${width}" -le 0 ]; then
        width=80
    fi

    printf '%s\n' "${width}"
}

function repeatChar() {
    local char="${1:-=}"
    local width="${2:-$(terminalWidth)}"
    local line

    line=$(printf '%*s\n' "${width}" '' | tr ' ' "${char}")
    printf '%s' "${line%$'\n'}"
}

function printSection() {
    local title="$1"
    local width
    local label
    local fill_width
    local left_width
    local right_width

    width=$(terminalWidth)
    label=" ${title} "

    if [ "${#label}" -ge "${width}" ]; then
        printf '%s\n' "${title}"
        return
    fi

    fill_width=$((width - ${#label}))
    left_width=$((fill_width / 2))
    right_width=$((fill_width - left_width))

    printf '%s%s%s\n' \
        "$(repeatChar '=' "${left_width}")" \
        "${label}" \
        "$(repeatChar '=' "${right_width}")"
}

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    printf '%s\n' '[ERROR] Current directory is not inside a Git work tree.'
    exit 1
fi

printSection "GIT STATUS"
git status -s

printf '\n'
printSection "GIT DIFF (已跟踪文件)"
if git rev-parse --verify HEAD >/dev/null 2>&1; then
    # 正常仓库：输出所有已暂存和未暂存的修改
    git diff HEAD
else
    # 全新仓库：输出已暂存的文件（如果有的话）
    git diff --cached
fi

printf '\n'
printSection "UNTRACKED FILES (未跟踪的新文件)"
git ls-files --others --exclude-standard | while read -r file; do
    if [ -f "${file}" ]; then
        git diff --no-index -- /dev/null "${file}" || true
    fi
done

printf '%s\n' "$(repeatChar '=' "$(terminalWidth)")"
printf "💡 提示: 复制以上完整输出，触发 '使用 git-commit-generator' 即可。\n"
