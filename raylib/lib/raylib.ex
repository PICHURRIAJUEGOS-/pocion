defmodule Raylib do
  @moduledoc """
  Documentation for `Raylib`.
  """

  use Zig, otp_app: :raylib

  ~Z"""
  pub const InitWindowOptions = struct { width: u32, height: u32, title: []u8 };
  const beam = @import("beam");

  pub fn init_window(options: InitWindowOptions) beam.term {
  if (options.width > 0) {}
  return beam.make(.ok, .{});
  }

  pub fn close_window() beam.term {
  return beam.make(.ok, .{});
  }
  """
end
