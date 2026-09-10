class Aiquokka < Formula
  desc "Unified subscription quota monitor for Claude, Codex, Cursor, Grok, and more"
  homepage "https://github.com/star-plan/aiquokka"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.1.2/aiquokka-macos-arm64"
      sha256 "..."
      def install
        bin.install "aiquokka-macos-arm64" => "aiquokka"
      end
    end

    on_intel do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.1.2/aiquokka-macos-amd64"
      sha256 "..."
      def install
        bin.install "aiquokka-macos-amd64" => "aiquokka"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.1.2/aiquokka-linux-arm64"
      sha256 "..."
      def install
        bin.install "aiquokka-linux-arm64" => "aiquokka"
      end
    end

    on_intel do
      url "https://github.com/star-plan/aiquokka/releases/download/v0.1.2/aiquokka-linux-amd64"
      sha256 "..."
      def install
        bin.install "aiquokka-linux-amd64" => "aiquokka"
      end
    end
  end

  test do
    system "#{bin}/aiquokka", "--version"
  end
end