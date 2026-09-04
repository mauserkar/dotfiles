---
name: changelog-automation
description: Automatically updates or creates the CHANGELOG.md file whenever code is modified.
---

# Skill: Automatic Changelog Management

## Trigger
Execute this logic automatically whenever you write, edit, or refactor code in the repository.

## Instructions
1. **Locate Changelog:** Check if `CHANGELOG.md` exists in the root directory.
2. **If `CHANGELOG.md` exists:**
   - Append the recent changes made during the current task under the appropriate section using [Keep a Changelog](https://keepachangelog.com/) standards (`Added`, `Changed`, `Fixed`, `Deprecated`, `Removed`).
3. **If `CHANGELOG.md` does NOT exist:**
   - Create `CHANGELOG.md` in the root directory.
   - Include a standard title and document the newly implemented functionality or fixes.