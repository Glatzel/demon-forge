---
name: glatzel-tool-discovery
description: Help the agent discover and leverage locally available CLI tools, especially tools installed through Pixi Global, to extend its task-solving capabilities.
---

# Tool Discovery

## Objective

Expand the agent's effective capabilities by discovering tools already available in its execution environment.

The agent must not assume that it can only use built-in tools. Locally installed CLI utilities may provide additional capabilities for document processing, image manipulation, audio and video processing, data analysis, file conversion, searching, and automation.

## Discover available tools

When a task could benefit from an external utility:

1. Run `pixi global list` to inspect tools installed through Pixi Global.
2. Treat the results as a catalog of potentially available capabilities, not as a list of tools to install.
3. Identify relevant tools based on the task.
4. Verify that a selected executable is accessible in the current environment when necessary.
5. Consult its command-line help when usage or supported capabilities are unclear.
6. Use the available tool to complete the task when appropriate.

Do not run discovery commands for every trivial task. Discover tools when doing so could materially improve the solution.

## Tool usage

- Prefer already installed tools over reimplementing their functionality.
- Consider tools beyond the language or framework explicitly mentioned in the task.
- Combine utilities when a pipeline can accomplish a task efficiently.
- Check supported formats and capabilities before relying on a tool.
- Verify command results and generated artifacts.
- If a listed tool is inaccessible in the current execution environment, explain the limitation and consider other available options.

## Scope and restrictions

- Do not install, update, remove, or configure Pixi Global packages as part of tool discovery.
- Do not interpret a missing tool as permission to install it.
- Do not modify the user's environment merely to explore available capabilities.
- `pixi global list` is for discovering existing tools, not managing installations.

## Guiding principle

Discover what the environment can already do, then use those capabilities to solve the task.
