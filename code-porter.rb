# typed: false
# frozen_string_literal: true

# Homebrew formula for code-porter — updated by this tap's sync workflow.
class CodePorter < Formula
  desc "Local code archive importer/exporter (git bundle + zip)"
  homepage "https://github.com/star-plan/code-porter"
  version "0.6.0"
  license "Apache-2.0"
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/star-plan/code-porter/releases/download/v0.6.0/code-porter-macos-arm64"
      sha256 "fa4d84ba1389ba721054b97a4d3c06c8541609845690c3db10073561adefffdb"

      def install
        bin.install "code-porter-macos-arm64" => "code-porter"
      end
    end
    on_intel do
      url "https://github.com/star-plan/code-porter/releases/download/v0.6.0/code-porter-macos-amd64"
      sha256 "e9d1ee48b9bbf3d44d582aa9b60a712c80516b3af0ce368019063fd469f9fe6a"

      def install
        bin.install "code-porter-macos-amd64" => "code-porter"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/star-plan/code-porter/releases/download/v0.6.0/code-porter-linux-amd64"
      sha256 "47a022f21cfaea0cf042f13e58dd6ccef27432fad7273659717ab637f7df1ce8"

      def install
        bin.install "code-porter-linux-amd64" => "code-porter"
      end
    end
  end

  test do
    assert_match "scan", shell_output("#{bin}/code-porter --help")
  end
end
