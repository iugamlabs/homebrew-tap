# typed: false
# frozen_string_literal: true

# Homebrew formula for code-porter — updated by this tap's sync workflow.
class CodePorter < Formula
  desc "Local code archive importer/exporter (git bundle + zip)"
  homepage "https://github.com/star-plan/code-porter"
  version "0.5.6"
  license "Apache-2.0"
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/star-plan/code-porter/releases/download/v0.5.6/code-porter-macos-arm64"
      sha256 "8132fcc2130368a42338dc3d738344df542e0ba95326bbfb7447561222866bb3"

      def install
        bin.install "code-porter-macos-arm64" => "code-porter"
      end
    end
    on_intel do
      url "https://github.com/star-plan/code-porter/releases/download/v0.5.6/code-porter-macos-amd64"
      sha256 "a6b0c2dca7f25aa7bb05fc62c3767101fe6687879e13abbaad956059c8a48f68"

      def install
        bin.install "code-porter-macos-amd64" => "code-porter"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/star-plan/code-porter/releases/download/v0.5.6/code-porter-linux-amd64"
      sha256 "8416b297faa415225c08eb8b0e64496aefcd4c03f2b6f1fdd339e27c71bf7d84"

      def install
        bin.install "code-porter-linux-amd64" => "code-porter"
      end
    end
  end

  test do
    assert_match "scan", shell_output("#{bin}/code-porter --help")
  end
end
