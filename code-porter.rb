# typed: false
# frozen_string_literal: true

# Homebrew formula for code-porter — updated by this tap's sync workflow.
class CodePorter < Formula
  desc "Local code archive importer/exporter (git bundle + zip)"
  homepage "https://github.com/star-plan/code-porter"
  version "0.5.4"
  license "Apache-2.0"
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/star-plan/code-porter/releases/download/v0.5.4/code-porter-macos-arm64"
      sha256 "09f6738bcb1ddcd1b7bf6da61a9bf10f6c17ae87ea0e3318c5ec0d8029736794"

      def install
        bin.install "code-porter-macos-arm64" => "code-porter"
      end
    end
    on_intel do
      url "https://github.com/star-plan/code-porter/releases/download/v0.5.4/code-porter-macos-amd64"
      sha256 "d09fb2d4d3e59c5be0d89fd18af48770b6ee7d375da3d9672b1de32a292b8f39"

      def install
        bin.install "code-porter-macos-amd64" => "code-porter"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/star-plan/code-porter/releases/download/v0.5.4/code-porter-linux-amd64"
      sha256 "20f249b1676156d0fb2e3e52aa2b8f4d5d4ab7381230515279673348a897a75c"

      def install
        bin.install "code-porter-linux-amd64" => "code-porter"
      end
    end
  end

  test do
    assert_match "scan", shell_output("#{bin}/code-porter --help")
  end
end
