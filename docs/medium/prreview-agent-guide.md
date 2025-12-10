# my-hack-pr-review Custom Agent Guide

This guide explains how to use the **my-hack-pr-review** custom agent (`my-hack-pr-review.agent.md`) to perform quick, consistent Pull Request reviews with minimal artifacts. It parallels the my-hack-arch-diagram guide style, but focuses on code review rather than infrastructure visualization.

> Purpose: Deliver lightweight, actionable PR reviews that focus on code quality, risk, and next steps without generating unnecessary documentation.

> **Note**: In VS Code versions prior to 1.106 (October 2025), custom agents were called "chat modes" and used `.chatmode.md` files in `.github/chatmodes/` directory. The functionality is the same, but the terminology and file locations have changed.

## 🧭 Overview

my-hack-pr-review agent analyzes Pull Request diffs and produces structured review artifacts (`summary.md` and `comments.md`) categorized by impact and severity. It provides consistent review output without modifying code or creating excessive documentation files.

## ✅ Prerequisites

- Branch with changes
- Git repository with diff capability
- Basic understanding of your project's code structure

## 🎯 When to Use This Agent

Use my-hack-pr-review custom agent when you want:
- Quick, consistent PR reviews before merging
- Structured feedback on code quality, security, and performance
- Draft review comments ready to post on PRs
- Risk assessment without deep manual review

Do NOT use it for code generation or fixing issues—that belongs to my-hack-planner or other development agents.

## ⚡ Quick Start

1. Switch to my-hack-pr-review custom agent
2. Request review: `Review this PR` or `Review changes against main`
3. The agent will:
    - Load diffs from current branch vs base (default: `main`)
    - Analyze code changes for quality, security, performance issues
    - Classify findings by severity (Blocker/Should Fix/Optional)
    - Generate review artifacts in `.copilot-tracking/pr-review/`
4. Review generated files:
    - `summary.md` – One-page overview with decisions
    - `comments.md` – Draft review comments ready to post

Command example:
```
Review the changes in branch feat/ayaka/add-fruit-price-api compared to main
```

## 📁 Output Structure

All review artifacts are stored in:
```
.copilot-tracking/pr-review/
├── summary.md      # Overview, decision, and risk assessment
└── comments.md     # Detailed review comments by file/line
```

## 📋 Review Categories

The agent classifies findings into:

**Impact Levels:**
- **High**: Critical issues affecting functionality or security
- **Medium**: Important improvements for maintainability or performance
- **Low**: Nice-to-have suggestions

**Categories:**
- **Quality**: Code structure, readability, best practices
- **Security**: Vulnerabilities, unsafe patterns, access control
- **Performance**: Efficiency, resource usage, optimization
- **Docs**: Documentation completeness and accuracy
- **Ops**: Deployment, configuration, operational concerns

**Severity:**
- **Blocker**: Must fix before merge
- **Should Fix**: Strongly recommended to address
- **Optional**: Nice-to-have improvements

## 🔄 Typical Workflow

1. **Create/Update PR**: Push changes to your branch
2. **Request Review**: Switch to my-hack-pr-review agent and ask for review
3. **Review Output**: Check `.copilot-tracking/pr-review/summary.md` for overview
4. **Address Blockers**: Fix any must-fix items identified
5. **Post Comments**: Use `comments.md` as draft for PR discussion
6. **Iterate**: Re-run review after fixes

## 🎨 Output Format

### summary.md
Contains:
- PR title/scope and decision (Block/Approve with suggestions/Approve)
- Top findings summary
- Risk and impact assessment
- Categorized issues (Must-Fix, Should-Fix, Nice-to-Have)
- Next steps checklist

### comments.md
Contains:
- Numbered comments (C-001, C-002, etc.)
- File and line references
- Category and severity tags
- Issue description, suggested fix (with diff), and rationale

## 💡 Tips

- **Run early**: Review during development, not just before merge
- **Focus on blockers**: Address must-fix items first
- **Use as draft**: comments.md provides ready-to-post PR feedback
- **Iterate quickly**: Re-run after fixes to verify resolution
- **Customize base**: Compare against feature branches or staging as needed
