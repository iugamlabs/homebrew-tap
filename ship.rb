# typed: false
# frozen_string_literal: true

# Homebrew formula for ship — updated by this tap's sync workflow.
class Ship < Formula
  desc "Docker image build, push and remote deploy CLI"
  homepage "https://github.com/heyoungai/ship"
  version "2.8.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/heyoungai/ship/releases/download/v2.8.0/ship-darwin-arm64"
      sha256 "85038fd8d02e96f1e838425dd6f51a1106655025c788bf931e13c38fe32e7c9f"

      def install
        bin.install "ship-darwin-arm64" => "ship"
      end
    end
    on_intel do
      url "https://github.com/heyoungai/ship/releases/download/v2.8.0/ship-darwin-amd64"
      sha256 "76e8f741814b89777fa17cbbc926057cf8fe4dc358873e3f88d909c74aa17221"

      def install
        bin.install "ship-darwin-amd64" => "ship"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/heyoungai/ship/releases/download/v2.8.0/ship-linux-arm64"
      sha256 "825f4f0085604d905445ab46bdf62f7c70137fafbe3336631986d8ddee6facdc"

      def install
        bin.install "ship-linux-arm64" => "ship"
      end
    end
    on_intel do
      url "https://github.com/heyoungai/ship/releases/download/v2.8.0/ship-linux-amd64"
      sha256 "b05bf771410b1ca6d65ab991b426a92bb18895658e32a2d756c7301421871dc9"

      def install
        bin.install "ship-linux-amd64" => "ship"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ship version")
  end
end
