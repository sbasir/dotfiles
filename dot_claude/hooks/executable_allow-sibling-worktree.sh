#!/usr/bin/env bash
# Auto-approve EnterWorktree only for BrandAlley sibling worktrees: ~/projects/brandalley/<repo>-wt-<task>
p=$(jq -r '.tool_input.path // empty')
[ -z "$p" ] && exit 0
case "$p" in ../*) p="$(pwd)/$p" ;; esac
real=$(cd "$(dirname "$p")" 2>/dev/null && pwd -P)/$(basename "$p")
if [[ "$real" =~ ^$HOME/projects/brandalley/[A-Za-z0-9._-]+-wt-[A-Za-z0-9._-]+$ ]]; then
  jq -n '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"allow",permissionDecisionReason:"BrandAlley sibling worktree"}}'
fi
exit 0
