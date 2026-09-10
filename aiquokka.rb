# typed: false
# frozen_string_literal: true

# Homebrew formula for aiquokka — updated by this tap's sync workflow.
class Aiquokka < Formula
  desc "Unified subscription quota monitor for Claude, Codex, Cursor, Grok, and more"
  homepage "https://github.com/star-plan/aiquokka"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.1.2/aiquokka-macos-arm64"
      sha256 "16d4083bf9f038e21766c2bddff09ffdea433c20e28bc1720d785248bb719124"

      def install
        bin.install "aiquokka-macos-arm64" => "aiquokka"
      end
    end

    on_intel do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.1.2/aiquokka-macos-amd64"
      sha256 "7cafb325f34f67f7650b149ada451c7af9a14027c14a8c6dafb7c8d54d31bd5f"

      def install
        bin.install "aiquokka-macos-amd64" => "aiquokka"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.1.2/aiquokka-linux-arm64"
      sha256 "d83715b95840905c408035912a0934eda489832ad5180836a9680e20c940c8b2"

      def install
        bin.install "aiquokka-linux-arm64" => "aiquokka"
      end
    end

    on_intel do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.1.2/aiquokka-linux-amd64"
      sha256 "afd8a99b6a1e4687d69cc5fc4bf2103d68730368af15c87dc254709198dcb8eb"

      def install
        bin.install "aiquokka-linux-amd64" => "aiquokka"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aiquokka --version")
  end
end
