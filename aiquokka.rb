# typed: false
# frozen_string_literal: true

# Homebrew formula for aiquokka — updated by this tap's sync workflow.
class Aiquokka < Formula
  desc "Unified subscription quota monitor for Claude, Codex, Cursor, Grok, and more"
  homepage "https://github.com/iugamlabs/aiquokka"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/iugamlabs/aiquokka/releases/download/v0.3.1/aiquokka-macos-arm64"
      sha256 "583df90adeabf9aafd9f84d522333bdfef759d5195067f51ce2298363108b44e"

      def install
        bin.install "aiquokka-macos-arm64" => "aiquokka"
      end
    end

    on_intel do
      url "https://github.com/iugamlabs/aiquokka/releases/download/v0.3.1/aiquokka-macos-amd64"
      sha256 "b05617a5494227670b15465647dd821916b5bbf1a2d5450cddfef77f0d6c4ac3"

      def install
        bin.install "aiquokka-macos-amd64" => "aiquokka"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/iugamlabs/aiquokka/releases/download/v0.3.1/aiquokka-linux-arm64"
      sha256 "1080838fd18f96797fdc69f3a51f9d43a27a3edf66ec2eb1339f4f8d17ccb829"

      def install
        bin.install "aiquokka-linux-arm64" => "aiquokka"
      end
    end

    on_intel do
      url "https://github.com/iugamlabs/aiquokka/releases/download/v0.3.1/aiquokka-linux-amd64"
      sha256 "89bf453f9ee4585f68bad342c20f7535f06862efc0a72ae3f023253663373956"

      def install
        bin.install "aiquokka-linux-amd64" => "aiquokka"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aiquokka --version")
  end
end
