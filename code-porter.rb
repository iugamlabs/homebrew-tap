# typed: false
# frozen_string_literal: true

# Homebrew formula for code-porter — updated by this tap's sync workflow.
class CodePorter < Formula
  desc "Local code archive importer/exporter (git bundle + zip)"
  homepage "https://github.com/star-plan/code-porter"
  version "0.5.3"
  license "Apache-2.0"
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/star-plan/code-porter/releases/download/v0.5.3/code-porter-macos-arm64"
      sha256 "8cb6dc5c032979492080fb643725e465f838a04f0a084b22fc08aaf13b542818"

      def install
        bin.install "code-porter-macos-arm64" => "code-porter"
      end
    end
    on_intel do
      url "https://github.com/star-plan/code-porter/releases/download/v0.5.3/code-porter-macos-amd64"
      sha256 "eedb7ef2ea62eb34950d358a831dd25d391fe407ef6e85ade89e1acbf3c8019f"

      def install
        bin.install "code-porter-macos-amd64" => "code-porter"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/star-plan/code-porter/releases/download/v0.5.3/code-porter-linux-amd64"
      sha256 "3e015ba2f7e01126da20ca06ff9105a62473be5239db9f5410f9e44757c818d8"

      def install
        bin.install "code-porter-linux-amd64" => "code-porter"
      end
    end
  end

  test do
    assert_match "scan", shell_output("#{bin}/code-porter --help")
  end
end
