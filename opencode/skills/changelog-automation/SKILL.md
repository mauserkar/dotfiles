---
name: changelog-automation
description: Use this skill after any code change (write, edit, or refactor) to update CHANGELOG.md, bump the semantic version, and commit the release.
metadata:
  opencode/slash: "true"
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

4. **Determine version bump (SemVer: MAJOR.MINOR.PATCH):**
   - Read the current version from the latest entry in `CHANGELOG.md` (or from `package.json` / equivalent manifest if present).
   - Classify the changes made in this task:
     - **MAJOR**: breaking changes, incompatible API changes, removed functionality (`Removed`, breaking `Changed`).
     - **MINOR**: new backward-compatible functionality (`Added`).
     - **PATCH**: backward-compatible bug fixes (`Fixed`, minor `Changed`, `Deprecated`).
   - If multiple types of changes occurred, apply the **highest-priority** bump (MAJOR > MINOR > PATCH).
   - Increment the corresponding version number, resetting lower-order numbers to 0 (e.g., `1.2.3` → `2.0.0` for MAJOR, `1.2.3` → `1.3.0` for MINOR, `1.2.3` → `1.2.4` for PATCH).

5. **Update version references:**
   - Add the new version number and date as the heading for the new `CHANGELOG.md` entry (e.g., `## [1.3.0] - 2026-09-10`).
   - Update the version field in `package.json` (or the relevant manifest: `pyproject.toml`, `Cargo.toml`, etc.) if one exists in the repo.

6. **Commit the changes:**
   - Stage `CHANGELOG.md` and any updated manifest/version files, plus the code changes made in this task.
   - Create a commit with a message following the pattern:
      chore(release): vX.Y.Z
      <short summary of changes>
   - Do not push automatically — leave the push step to the user unless explicitly instructed otherwise.