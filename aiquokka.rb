# typed: false
# frozen_string_literal: true

# Homebrew formula for aiquokka — updated by this tap's sync workflow.
class Aiquokka < Formula
  desc "Unified subscription quota monitor for Claude, Codex, Cursor, Grok, and more"
  homepage "https://github.com/star-plan/aiquokka"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.2.1/aiquokka-macos-arm64"
      sha256 "562c201e09d482e74d0eec5e1b03eeddd4ec59065f39958c8271c06bd546c7c7"

      def install
        bin.install "aiquokka-macos-arm64" => "aiquokka"
      end
    end

    on_intel do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.2.1/aiquokka-macos-amd64"
      sha256 "67b4e671b9872aebee9bd1ea1088b88b9eba4d68fee190eaac01ffd3aabdb816"

      def install
        bin.install "aiquokka-macos-amd64" => "aiquokka"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.2.1/aiquokka-linux-arm64"
      sha256 "1f81ad59daa21d8871a5e78490919ab3d5fea0f3d56c5a869fb0dc63f0490a49"

      def install
        bin.install "aiquokka-linux-arm64" => "aiquokka"
      end
    end

    on_intel do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.2.1/aiquokka-linux-amd64"
      sha256 "9f8193b1837955237ed02beee0d1e96e5864fdd0c908b8976f268465ab0c7b6f"

      def install
        bin.install "aiquokka-linux-amd64" => "aiquokka"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aiquokka --version")
  end
end
