# frozen_string_literal: true

# Timely CLI - Homebrew Formula
# Install: brew install amkisko/tap/timely-cli
class TimelyCli < Formula
  desc "Timely API CLI, MCP server, and local Memory reader"
  homepage "https://github.com/amkisko/timely-cli.rs"
  url "https://github.com/amkisko/timely-cli.rs/archive/refs/tags/v0.1.1.tar.gz"
  # Fill after first tagged release:
  # shasum -a 256 <(curl -sL https://github.com/amkisko/timely-cli.rs/archive/refs/tags/v0.1.0.tar.gz)
  sha256 "64794896a2702d58f569677ee5cfd937d934d9f829253d1aaece9c80676d1201"
  license "MIT"
  head "https://github.com/amkisko/timely-cli.rs.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "timely")
    bash_completion.install shell_output("#{bin}/timely completions bash"), "timely"
    zsh_completion.install shell_output("#{bin}/timely completions zsh"), "_timely"
    fish_completion.install shell_output("#{bin}/timely completions fish"), "timely.fish"
    man1.install shell_output("#{bin}/timely man"), "timely.1"
  end

  test do
    assert_match "timely #{version}", shell_output("#{bin}/timely version")
  end
end
