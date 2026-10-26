# frozen_string_literal: true

# pray - Homebrew Formula (kiskolabs/pray / agentfile)
# Install: brew install amkisko/tap/pray
class Pray < Formula
  desc "Reference CLI for Prayfile — package manager for pre-inference input"
  homepage "https://pray.kisko.dev"
  url "https://github.com/kiskolabs/pray/archive/refs/tags/v1.25.0.tar.gz"
  # Fill after tagged release:
  # shasum -a 256 <(curl -sL https://github.com/kiskolabs/pray/archive/refs/tags/v1.2.0.tar.gz)
  sha256 "52e4cc482775ab2f62db16a35d1f9b180781f015a0dfab544a350449a9cef9ce"
  license "MIT"
  head "https://github.com/kiskolabs/pray.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/pray-cli")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pray --version")
  end
end
