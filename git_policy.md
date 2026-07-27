# Git & Pull Request Policy

This document outlines the strict rules for version control, issue tracking, and repository management for the `ft_transcendence` project.

## 1. Commit Policy
Commits must be concise, descriptive, and follow a standardized format. 

**Format:**
`<type>(<scope>): <subject>

**Types examples:**
*   `feat`: A new feature.
*   `fix`: A bug fix.
*   `refactor`: Code change that neither fixes a bug nor adds a feature.
*   `docs`: Documentation changes only.
*   `chore`: Changes to the build process or auxiliary tools.

**Example:**
`feat(auth): implement silent JWT refresh`

## 2. Issue Policy
Every issue must adhere to a strict "Definition of Done" standard. An issue is invalid and cannot be processed unless it explicitly defines the task, the verification method, and external requirements. (Remember to link all issues to the github projects Board)

**Required Issue Structure:**
*   **Description:** A clear, objective explanation of the required feature, task, or bug fix.
*   **Acceptance Criteria (Checklist):** A concrete list of verifiable conditions that must be fulfilled before the issue can be marked as complete.
*   **Dependencies:** Explicit references to other issues (e.g., `#15`) that block or relate to this task, ensuring cross-team requirements are documented. Assign related people to the issue.

## 3. Masterpointer updates
Submodule pointers in the master repository are not updated for every PR. Pointers are only updated when a submodule completes a milestone, or when another submodule explicitly requires the updated code for integration.

## 4. Pull Request (PR) Protocol
All code must be reviewed before merging into the `main` branch of any submodule.

*   **Issue Link:** Every PR must be explicitly attached to an existing issue.
*   **Assignees:** The Assignee(s) on a PR must be the developer(s) who are directly related to writing or maintaining that specific code.
*   **Merge Requirement:** A PR cannot be merged by its author. It must be approved and merged by a designated Reviewer.
