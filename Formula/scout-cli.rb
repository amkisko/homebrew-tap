# frozen_string_literal: true

# ScoutAPM CLI - Homebrew Formula
# Install: brew install amkisko/tap/scout-cli
class ScoutCli < Formula
  desc "ScoutAPM CLI — query apps, endpoints, traces, metrics, and errors"
  homepage "https://github.com/amkisko/scout-cli.rs"
  url "https://github.com/amkisko/scout-cli.rs/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "37fdd47ef3750cee00f46c3494c55736a318f8bfd774ef6f385eb16124197b54"
  license "MIT"
  head "https://github.com/amkisko/scout-cli.rs.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "scout")
    bash_completion.install shell_output("#{bin}/scout completions bash"), "scout"
    zsh_completion.install shell_output("#{bin}/scout completions zsh"), "_scout"
    fish_completion.install shell_output("#{bin}/scout completions fish"), "scout.fish"
    man1.install shell_output("#{bin}/scout man"), "scout.1"
  end

  test do
    assert_match "scout #{version}", shell_output("#{bin}/scout version")
  end
end
