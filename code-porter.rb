# typed: false
# frozen_string_literal: true

# Homebrew formula for code-porter — updated by this tap's sync workflow.
class CodePorter < Formula
  desc "Local code archive importer/exporter (git bundle + zip)"
  homepage "https://github.com/star-plan/code-porter"
  version "0.5.2"
  license "Apache-2.0"
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/star-plan/code-porter/releases/download/v0.5.2/code-porter-macos-arm64"
      sha256 "f1c5a557f5d8e4da702f05d6aa1f574d61f9160f37be82ff99a77881931df6ac"

      def install
        bin.install "code-porter-macos-arm64" => "code-porter"
      end
    end
    on_intel do
      url "https://github.com/star-plan/code-porter/releases/download/v0.5.2/code-porter-macos-amd64"
      sha256 "6eca8446ca84bb5d520c20a97dc01fe7cbc43c94d782997c00596c694b1b2e15"

      def install
        bin.install "code-porter-macos-amd64" => "code-porter"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/star-plan/code-porter/releases/download/v0.5.2/code-porter-linux-amd64"
      sha256 "000cf7659fb9c4360feb9786112e4d5c4b00671a63b7d8ee863eb65f7569cee4"

      def install
        bin.install "code-porter-linux-amd64" => "code-porter"
      end
    end
  end

  test do
    assert_match "scan", shell_output("#{bin}/code-porter --help")
  end
end
