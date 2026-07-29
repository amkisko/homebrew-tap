# frozen_string_literal: true

# pray - Homebrew Formula (kiskolabs/pray / agentfile)
# Install: brew install amkisko/tap/pray
class Pray < Formula
  desc "Reference CLI for Prayfile — package manager for pre-inference input"
  homepage "https://pray.kisko.dev"
  url "https://github.com/kiskolabs/pray/archive/refs/tags/v1.7.0.tar.gz"
  # Fill after tagged release:
  # shasum -a 256 <(curl -sL https://github.com/kiskolabs/pray/archive/refs/tags/v1.2.0.tar.gz)
  sha256 "7a47e3e96302fdb34e384cfa387778665e6b4c9c4e9d9ac5b12d0d4e2b45dc58"
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
