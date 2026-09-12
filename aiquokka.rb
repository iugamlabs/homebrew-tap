# typed: false
# frozen_string_literal: true

# Homebrew formula for aiquokka — updated by this tap's sync workflow.
class Aiquokka < Formula
  desc "Unified subscription quota monitor for Claude, Codex, Cursor, Grok, and more"
  homepage "https://github.com/star-plan/aiquokka"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.2.0/aiquokka-macos-arm64"
      sha256 "cf0a205dfa2e828d32d7afaaa7a7b4adba219b502e8d9da9bbfcd6aeff282f8e"

      def install
        bin.install "aiquokka-macos-arm64" => "aiquokka"
      end
    end

    on_intel do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.2.0/aiquokka-macos-amd64"
      sha256 "33785b0f1c217b3e073ae8619e3e6f7b582474926764a5ed5daca59d55c20d8e"

      def install
        bin.install "aiquokka-macos-amd64" => "aiquokka"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.2.0/aiquokka-linux-arm64"
      sha256 "b019db5d6bd10a9766f4bcd12b6b49f2c95867243e248c2c32c0bfd701590725"

      def install
        bin.install "aiquokka-linux-arm64" => "aiquokka"
      end
    end

    on_intel do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.2.0/aiquokka-linux-amd64"
      sha256 "18a018d211a425a745daa635582f24f299d801582fe4e9e1c94410946338b13b"

      def install
        bin.install "aiquokka-linux-amd64" => "aiquokka"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aiquokka --version")
  end
end
