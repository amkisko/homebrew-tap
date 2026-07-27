# frozen_string_literal: true

# pray - Homebrew Formula (kiskolabs/pray / agentfile)
# Install: brew install amkisko/tap/pray
class Pray < Formula
  desc "Reference CLI for Prayfile — package manager for pre-inference input"
  homepage "https://pray.kisko.dev"
  url "https://github.com/kiskolabs/pray/archive/refs/tags/v1.4.0.tar.gz"
  # Fill after tagged release:
  # shasum -a 256 <(curl -sL https://github.com/kiskolabs/pray/archive/refs/tags/v1.2.0.tar.gz)
  sha256 "0a866e72aa3c490fcd09f0313a2086dbb8b7e4ac8a6b9b0dc0f5ed0f926c4d40"
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
