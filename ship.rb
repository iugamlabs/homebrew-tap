# typed: false
# frozen_string_literal: true

# Homebrew formula for ship — updated by this tap's sync workflow.
class Ship < Formula
  desc "Docker image build, push and remote deploy CLI"
  homepage "https://github.com/heyoungai/ship"
  version "2.8.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/heyoungai/ship/releases/download/v2.8.3/ship-darwin-arm64"
      sha256 "da1820042e79f99ada04a543d9e2207e06f2caceec3d3eb199824c61a1fe286d"

      def install
        bin.install "ship-darwin-arm64" => "ship"
      end
    end
    on_intel do
      url "https://github.com/heyoungai/ship/releases/download/v2.8.3/ship-darwin-amd64"
      sha256 "b206a6e81198e976493371b9b383dbf5084b6737f312ff4e93681fb3fd7d9ec1"

      def install
        bin.install "ship-darwin-amd64" => "ship"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/heyoungai/ship/releases/download/v2.8.3/ship-linux-arm64"
      sha256 "798c35beb955521808e73bf220e9a14f661af3e54bb7b52df6b8925e1e5ed10a"

      def install
        bin.install "ship-linux-arm64" => "ship"
      end
    end
    on_intel do
      url "https://github.com/heyoungai/ship/releases/download/v2.8.3/ship-linux-amd64"
      sha256 "18f33b412ebcd5cb059e2b890dfdfac9ff7fe26659d89ff4e092b75055d28d44"

      def install
        bin.install "ship-linux-amd64" => "ship"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ship version")
  end
end
