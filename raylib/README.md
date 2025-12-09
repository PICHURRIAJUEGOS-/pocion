# Raylib (Experimental)

DO NOT ADD UNNECESSARY CODE!!!
EVERY LINE HAS A PRACTICAL REASON.

This library does not attempt to map the behavior of Raylib one-to-one, but rather seeks its most appropiate use.

## Requirements

Raylib must be compiled with `SUPPORT_CUSTOM_FRAME_CONTROL` enabled.

To enable this flag:
1. Edit `src/config.h` in the raylib source code
2. Uncomment or add: `#define SUPPORT_CUSTOM_FRAME_CONTROL`
3. Compile raylib

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `raylib` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:raylib, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/raylib>.


## Resources

* https://www.raylib.com/cheatsheet/cheatsheet.html

## Other implementations

* https://github.com/shiryel/rayex