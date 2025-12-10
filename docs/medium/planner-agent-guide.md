# my-hack-planner Custom Agent Guide

This guide explains how to use the **my-hack-planner** custom agent (`my-hack-planner.agent.md`) to create implementation plans for Product Backlog Items (PBIs). The my-hack-planner agent is specifically designed for planning tasks, not direct implementation.

> **Note**: In VS Code versions prior to 1.106 (October 2025), custom agents were called "chat modes" and used `.chatmode.md` files in `.github/chatmodes/` directory. The functionality is the same, but the terminology and file locations have changed.

## 📋 Overview

This project uses a structured two-phase GitHub Copilot workflow:

1. **Planning Phase**: Use the **my-hack-planner** custom agent to create detailed implementation plans
2. **Implementation Phase**: Use the **Agent** custom agent to execute the plan in controlled phases

This workflow ensures all code changes are well-planned, properly tested, and follow our engineering fundamentals.

## 🎯 Prerequisites

Before starting development with GitHub Copilot:
- Ensure you have access to GitHub Copilot in VS Code
- Understand the project's [engineering fundamentals](../.github/engineering-fundamentals.md)
- Familiarize yourself with the codebase structure

## 📝 Step-by-Step Workflow

### Step 1: Document Your PBI

Create a detailed PBI document that describes what you want to implement.

1. Create your PBI file in `.copilot-tracking/pbi/`
   - Sample PBIs (`pbi-001.md` and `pbi-002.md`) are available in the directory as references. They cover creating a Fruit Prices API and its accompanying Terraform infrastructure.
2. Use the naming convention: `pbi-<issue#>.md` (e.g., `pbi-327.md`)
3. Include:
   - **Title**: Clear, concise description of the feature.
   - **Description**: What needs to be built and why.
   - **Acceptance Criteria**: How you'll know it's complete.
   - **Technical Requirements**: Any specific technical constraints.

### Step 2: Switch to my-hack-planner Custom Agent

1. In VS Code, open GitHub Copilot Chat
2. Click the mode selector (dropdown of "Ask", "Edit", "Plan", "Agent", etc.)
3. Select **"my-hack-planner"** custom agent

The my-hack-planner agent is specifically configured to:
- Create implementation plans rather than writing code directly
- Research existing project patterns and structure
- Break down complex tasks into manageable phases

### Step 3: Request a Plan

Ask GitHub Copilot to create a plan for your PBI using hashtag filename annotation.

**Example request:**
```
Create a plan for #pbi-001.md
```

The my-hack-planner will:
- Analyze your PBI requirements
- Research the existing codebase to understand patterns
- Create a detailed plan saved to `.copilot-tracking/plans/`
- Generate research notes saved to `.copilot-tracking/research/`

### Step 4: Review and Refine the Plan

1. Open the generated plan file in `.copilot-tracking/plans/pbi-<issue#>.plan.md`
2. Review each phase and task for completeness
3. Ensure the plan includes:
   - Clear task descriptions
   - Success criteria for each task
   - Test creation and execution tasks
   - Proper file locations and dependencies

If the plan needs adjustments:
- Ask the my-hack-planner to refine specific phases
- Make manual adjustments if desired
- Request additional detail for complex tasks
- Ensure all engineering fundamentals are addressed

### Step 5: Create a Feature Branch

Before implementing, create a new branch for your work:

```bash
git checkout -b feat/your-name/<issue#>-<short-description>
```

**Example:**
```bash
git checkout -b feat/drew/327-api-rate-limiting
```

### Step 6: Switch to Agent Custom Agent

1. In GitHub Copilot Chat, change the custom agent from "my-hack-planner" to **"Agent"**
2. The Agent custom agent is configured for implementation and follows the project's coding standards

### Step 7: Implement Phase by Phase

Work through your plan one phase at a time, referencing the plan file with hashtag notation.

**Example request for first phase:**
```
Implement Phase 1 of #pbi-001.plan.md
```

The Agent will:
- Follow the specific tasks outlined in the plan
- Adhere to the project's engineering fundamentals
- Create tests as specified in the plan
- Follow established code patterns from the project

### Step 8: Review and Test Each Phase

After each phase implementation:

**Review the generated code:**
   - Ensure it follows the project's coding standards
   - Verify it matches the plan's success criteria
   - Check that all required files were created/modified


### Step 9: Commit Your Progress

After successfully completing and testing each phase:

```bash
git add .
git commit -m "feat: implement phase X of PBI #<issue#>

- Completed task 1
- Completed task 2
- All tests passing"
```

### Step 10: Continue Iterating

Repeat steps 7-9 for each remaining phase in your plan:

1. Request implementation of the next phase
2. Review and test the output
3. Commit successful implementations
4. Update plan progress

## 🔧 Advanced Tips

### Working with Complex Plans

For large features, consider:
- Breaking plans into smaller, focused Task-level items
- Creating ADRs (Architecture Decision Records) for significant design decisions
- Coordinating with team members if changes affect shared components

### Handling Plan Deviations

If you need to deviate from the original plan:
1. Document the reason in the research file
2. Update the plan to reflect the new approach
3. Consider creating an ADR for significant architectural changes

## 📚 Related Documentation

- [Engineering Fundamentals](../../.github/engineering-fundamentals.md) - Code quality and testing standards
- [Copilot Instructions](../../.github/copilot-instructions.md) - Technical implementation guidelines
