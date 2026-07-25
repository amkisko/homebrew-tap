# frozen_string_literal: true

# pray - Homebrew Formula (kiskolabs/pray / agentfile)
# Install: brew install amkisko/tap/pray
class Pray < Formula
  desc "Reference CLI for Prayfile — package manager for pre-inference input"
  homepage "https://pray.kisko.dev"
  url "https://github.com/kiskolabs/pray/archive/refs/tags/v1.2.1.tar.gz"
  # Fill after tagged release:
  # shasum -a 256 <(curl -sL https://github.com/kiskolabs/pray/archive/refs/tags/v1.2.0.tar.gz)
  sha256 "2b0e019a6ec2c8c78c99dc010e4edc2fc8db3de015db53dba63b5afee6c23ca4"
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
