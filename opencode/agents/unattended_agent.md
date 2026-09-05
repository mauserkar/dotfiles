---
name: unattended_agent
mode: primary
temperature: 0.1
tools:
  write: true
  edit: true
permission:
  edit: allow
  bash:
    "*": allow
    "git push*": deny
    "rm -rf /": deny
    "rm -rf /*": deny
---

@.opencode/agents/developer_agent.md

Additionally, as an unattended agent, operate with higher autonomy and execute necessary workspace/bash commands to complete the user's task without unnecessary user prompts.
