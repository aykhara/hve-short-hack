## Step 2: Using GitHub Copilot Chat

### Overview
In Step 2, we'll build on what you learned in Step 1 by focusing on GitHub Copilot Chat. Copilot Chat is an interactive AI assistant within VS Code that can answer questions, explain code, and perform tasks in your project. Target time: 10–20 minutes.

### Prerequisites
Make sure you have completed:

- **Step 1** (GitHub Copilot installed and signed in)
- **Basic coding knowledge** (familiarity with at least one programming language)
- **VS Code basics** (opening files, editing code)

### What You'll Learn
By the end of this step, you'll know how to:

- Open and use the Copilot Chat panel
- Use chat commands (`/`) for quick actions
- Use chat extensions (`@`) for domain-specific help
- Use chat context (`#`) for context
- Switch between AI models for better responses
- Leverage Edit and Agent modes for different types of tasks
- Manage and configure Copilot's tools in Agent mode

### Quick Flow
1. Access Copilot Chat
2. Ask questions in Chat
3. Use chat commands (/), extensions (@), and context (#)
4. Switch between AI models
5. Use Edit and Agent modes
6. Manage tools in Agent mode

---

## Detailed Steps

### 1. Accessing GitHub Copilot Chat

Before using Copilot Chat, ensure you have completed Step 1 (GitHub Copilot extension installed and signed in).

1-1. **Click the Copilot Chat icon** in the VS Code sidebar (looks like the Copilot logo)

   - Alternatively: Press `Ctrl+Shift+I` (Windows/Linux) or `Cmd+Shift+I` (macOS)

1-2. **Verify the chat panel is open**

   - You should see a chat interface with a text input box at the bottom
   - A mode dropdown should be visible (likely defaulting to "Ask" or "Agent")

![open-chat](images/chat-usage/open-chat.png)

### 2. Asking Questions in Chat (Ask Mode)

By default, Copilot Chat opens in **Ask mode** for interactive Q&A without modifying your code directly.

**Let's try a hands-on practice:**

2-1. **Select this entire file** in your editor

   - Press `Ctrl+A` (Windows/Linux) or `Cmd+A` (macOS) to select all content
   - Or use your mouse to select from the top to bottom

2-2. **Open Copilot Chat** (if not already open)

   - Click the Copilot icon in the sidebar or press `Ctrl+Shift+I` / `Cmd+Shift+I`

2-3. **Type the following prompt** in the chat input box:

   ```
   #selection summarize this in 20 words
   ```
![context-selection](images/chat-usage/context-selection.png)

2-4. **Press Enter** and observe the response

   - Copilot reads your selected content (`#selection`)
   - It generates a concise 20-word summary
   - Notice how `#selection` provides the context automatically

2-5. **Try other questions** with your selection:

   - `#selection what are the key topics covered here?`
   - `#selection how long will it take to complete this step?`
   - `#selection list all the keyboard shortcuts mentioned`

> **Tip**: Ask mode only reads your code and provides suggestions; it won't automatically change files. Using `#selection` is more efficient than copying and pasting content into the chat.

### 3. Using Special Chat Prefixes (/, @, #)

Copilot Chat supports three special prefixes to enhance your prompts: **chat commands** (`/`), **chat extensions** (`@`), and **chat context** (`#`). These can be combined for powerful, context-aware queries.

**Chat Commands (/) – Quick shortcuts for common tasks:**
- `/list` – Lists available tools
- `/explain` – Explains selected code or error messages
- `/fix` – Proposes a fix for selected code problems
- `/clear` – Starts a new chat session (clears context)

**Chat Extensions (@) – Domain-specific expertise:**
- `@workspace` – Expert on your current project's codebase
  - Example: `@workspace summarize the purpose of this project`
- `@vscode` – Expert on Visual Studio Code settings and commands
  - Example: `@vscode change the font size bigger`
- `@terminal` – Familiar with shell commands and terminal operations
  - Example: `@terminal search for "HVE" under the current directory`
- `@azure` – Cloud-specific extensions (if enabled)
  - Example: `@azure how many resource groups do I have now?`

**Chat Context (#) – Inject specific context into prompts:**
- `#file` – Inserts current file content
- `#selection` – Inserts currently selected text
- `#function`, `#class`, `#line` – Inserts code under cursor
- `#block` – Inserts current code block
- `#terminal` – Refers to terminal output

**Try it out – Combined usage:**

3-1. **Select some code** in your editor (any function or code block)

3-2. **Type the following** in the chat input:

   ```
   @workspace /explain #selection
   ```

![commands-combination](images/chat-usage/commands-combination.png)

3-3. **Press Enter**

   - Copilot uses workspace context (`@workspace`) to explain (`/explain`) your selected code (`#selection`)
   - You can also try: `/fix #selection` or `@terminal how do I run #file`

3-4. **Experiment with different combinations:**

   - Type `/`, `@`, or `#` to see available options
   - Mix and match based on your needs

> **Tip**: Combining these prefixes creates powerful, context-aware queries. For example:
> - `@workspace find all TODO comments` – searches your project
> - `/explain #selection` – explains selected code
> - `@terminal how do I run #file` – gets terminal command for current file

### 4. Switching Between AI Models

Copilot Chat allows you to switch between different AI models (e.g., GPT-3.5, GPT-4) for different needs.

**Why switch models?**

- Smaller models: Faster responses, less detail
- Larger models (GPT-4): More accurate, elaborate answers (may be slower)

**How to switch:**

4-1. **Locate the model selector** in the Copilot Chat panel

   - Usually a drop-down menu near the top showing current model (e.g., "GPT-4")

4-2. **Click the model name/drop-down**

   - A list of available models appears (GPT-4, GPT-3.5, Claude, etc.)

4-3. **Select the model** you want to use

   - Subsequent responses will use the selected model

> **Note**: Model availability depends on your Copilot subscription (Individual vs. Business) and organizational settings.

### 5. Using Edit and Agent Modes

Copilot Chat has two powerful modes for making changes to your code: **Edit mode** and **Agent mode**. Understanding the difference helps you choose the right tool for your task.

**Mode comparison:**

- **Ask mode**: Provides suggestions and explanations only (no code changes)
- **Edit mode**: Makes focused edits to specific files you're working on
- **Agent mode**: Autonomous multi-step actions across your entire project

**Try Edit Mode First:**

5-1. **Locate the mode dropdown** in Copilot Chat panel (default: "Ask")

5-2. **Click and select "Edit"** mode

![edit-mode](images/chat-usage/edit-mode.png)

5-3. **Open a file** in your editor (or create a new one)

5-4. **Type the following request** in the chat:

   ```
   Create a Python calculator app with add, subtract, multiply, and divide functions under `calculator_app` folder. Add unit tests and run them to verify everything works.
   ```

5-5. **Press Enter** and observe Edit mode behavior:

   - Copilot edits the currently open file
   - Shows a diff preview of proposed changes
   - You can accept or reject the changes
   - Works on one file at a time
   - You need to manually create test file and run tests separately

**Now Try Agent Mode:**

5-6. **Switch to "Agent" mode** using the mode dropdown

![agent-mode](images/chat-usage/agent-mode.png)

5-7. **Type the same request** but with more scope:

   ```
   Create a Python calculator app with add, subtract, multiply, and divide functions under `calculator_app` folder. Add unit tests and run them to verify everything works.
   ```

5-8. **Press Enter** and observe Agent mode behavior:

   - Creates project folder structure automatically
   - Creates multiple files (`calculator.py`, `test_calculator.py`)
   - Runs tests automatically using pytest
   - Shows progress and results in the chat
   - Fixes errors and re-runs if tests fail

> **Important**: Agent mode is powerful but can be unpredictable. Start with small tasks and always review proposed changes before approving them.

### 6. Managing Tools in Agent Mode

Agent mode uses various tools to perform tasks. You can control which tools are available.

**Available tools:**
- **Read File** – Reads file contents
- **Write File** – Creates or modifies files
- **Terminal** – Runs shell commands
- **Test Runner** – Executes unit tests
- And more...

**How to manage tools:**

6-1. **Switch to Agent mode** if not already in it

6-2. **Click "Tools" button (visible in Agent mode, to the right of the mode dropdown)**

   - See the list of available tools with their current status

![tool-settings](images/chat-usage/tool-settings.png)

6-3. **Toggle tools on/off** as needed

   - Disable Terminal tool if you don't want Copilot running commands
   - Disable Write File for read-only mode (analysis only)
   - Keep Test Runner enabled to automatically verify code

6-4. **Review and approve actions** during execution

   - Copilot asks for confirmation before destructive actions
   - Review diffs before applying file changes
   - Check terminal commands before they execute

---

### Summary

You've mastered GitHub Copilot Chat! You can now use chat commands (`/`), chat extensions (`@`), and chat context (`#`) to get context-aware help, switch AI models for different needs, and leverage Edit and Agent modes for different types of code changes.

### Next

Proceed to [Step 3: Customizing GitHub Copilot](./step-3-chat-customization-jp.md) to create custom instructions and custom agents for your project.
