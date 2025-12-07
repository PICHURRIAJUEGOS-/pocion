<!-- LLM-Assisted -->
# Pocion Examples

This directory contains example applications demonstrating how to use the Pocion videogame library.

## Available Examples

### hello_world

A comprehensive example showcasing multiple windows with different animations:
- Animated text moving vertically
- Bouncing ball animation
- Vector2-based bouncing ball

## Running the Examples

### Prerequisites

- Elixir 1.19 or later
- Erlang/OTP
- Raylib system dependencies

### hello_world Example

```bash
cd hello_world
mix deps.get
mix run --no-halt
```

The `--no-halt` flag is required to keep the application running and display the windows.

Press `Ctrl+C` twice to exit.

## What You'll See

When running the hello_world example, three windows will open:
1. **Hello World** - Displays animated text moving up and down
2. **Bouncy Ball** - Shows a ball bouncing within the window bounds
3. **Bouncy Ball Vector2** - Demonstrates Vector2-based physics

Each window runs independently as a supervised OTP process, with its own game loop updating at 60 FPS.

## Creating Your Own Example

1. Create a new Mix project
2. Add `pocion` and `raylib` dependencies (as path dependencies or from Hex)
3. Start a Pocion window in your supervision tree
4. Implement a game loop that executes drawing operations

See the hello_world example source code for implementation patterns.