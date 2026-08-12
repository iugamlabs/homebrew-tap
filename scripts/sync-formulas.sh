#!/usr/bin/env bash
# Sync Homebrew formulas from each app's latest GitHub Release.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

hash_for() {
  local file="$1"
  local sums="$2"
  awk -v f="$file" '
    $2 == f || $2 == ("*" f) || $2 == ("./" f) { print $1; exit }
  ' "$sums"
}

sync_ship() {
  local repo="heyoungai/ship"
  local tag version dir sums
  local d_arm d_amd l_arm l_amd
  tag="$(gh release view -R "$repo" --json tagName -q .tagName)"
  version="${tag#v}"
  dir="$TMP/ship"
  mkdir -p "$dir"
  gh release download "$tag" -R "$repo" -D "$dir" -p "checksums.txt"
  sums="$dir/checksums.txt"
  d_arm="$(hash_for "ship-darwin-arm64" "$sums")"
  d_amd="$(hash_for "ship-darwin-amd64" "$sums")"
  l_arm="$(hash_for "ship-linux-arm64" "$sums")"
  l_amd="$(hash_for "ship-linux-amd64" "$sums")"
  if [[ -z "$d_arm" || -z "$d_amd" || -z "$l_arm" || -z "$l_amd" ]]; then
    echo "error: incomplete ship checksums" >&2
    cat "$sums" >&2
    return 1
  fi

  cat > "$ROOT/ship.rb" <<EOF
# typed: false
# frozen_string_literal: true

# Homebrew formula for ship — updated by this tap's sync workflow.
class Ship < Formula
  desc "Docker image build, push and remote deploy CLI"
  homepage "https://github.com/heyoungai/ship"
  version "${version}"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/heyoungai/ship/releases/download/v${version}/ship-darwin-arm64"
      sha256 "${d_arm}"

      def install
        bin.install "ship-darwin-arm64" => "ship"
      end
    end
    on_intel do
      url "https://github.com/heyoungai/ship/releases/download/v${version}/ship-darwin-amd64"
      sha256 "${d_amd}"

      def install
        bin.install "ship-darwin-amd64" => "ship"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/heyoungai/ship/releases/download/v${version}/ship-linux-arm64"
      sha256 "${l_arm}"

      def install
        bin.install "ship-linux-arm64" => "ship"
      end
    end
    on_intel do
      url "https://github.com/heyoungai/ship/releases/download/v${version}/ship-linux-amd64"
      sha256 "${l_amd}"

      def install
        bin.install "ship-linux-amd64" => "ship"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ship version")
  end
end
EOF
  echo "ship.rb -> v${version}"
}

sync_code_porter() {
  local repo="star-plan/code-porter"
  local tag version dir sums
  local m_arm m_amd l_amd
  local a_m_arm="code-porter-macos-arm64"
  local a_m_amd="code-porter-macos-amd64"
  local a_l_amd="code-porter-linux-amd64"

  if ! tag="$(gh release view -R "$repo" --json tagName -q .tagName 2>/dev/null)"; then
    echo "code-porter: no GitHub Release yet; skip"
    return 0
  fi
  version="${tag#v}"
  dir="$TMP/code-porter"
  mkdir -p "$dir"
  if ! gh release download "$tag" -R "$repo" -D "$dir" -p "SHA256SUMS" \
      -p "$a_m_arm" -p "$a_m_amd" -p "$a_l_amd" 2>/dev/null; then
    # At least need checksums + some binaries
    gh release download "$tag" -R "$repo" -D "$dir" -p "SHA256SUMS" 2>/dev/null || true
  fi
  sums="$dir/SHA256SUMS"
  if [[ ! -f "$sums" ]]; then
    echo "code-porter: release $tag has no SHA256SUMS; skip"
    return 0
  fi
  m_arm="$(hash_for "$a_m_arm" "$sums")"
  m_amd="$(hash_for "$a_m_amd" "$sums")"
  l_amd="$(hash_for "$a_l_amd" "$sums")"
  if [[ -z "$m_arm" || -z "$m_amd" || -z "$l_amd" ]]; then
    echo "code-porter: incomplete multi-arch assets on $tag; skip"
    return 0
  fi

  cat > "$ROOT/code-porter.rb" <<EOF
# typed: false
# frozen_string_literal: true

# Homebrew formula for code-porter — updated by this tap's sync workflow.
class CodePorter < Formula
  desc "Local code archive importer/exporter (git bundle + zip)"
  homepage "https://github.com/star-plan/code-porter"
  version "${version}"
  license "Apache-2.0"
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/star-plan/code-porter/releases/download/v${version}/${a_m_arm}"
      sha256 "${m_arm}"

      def install
        bin.install "${a_m_arm}" => "code-porter"
      end
    end
    on_intel do
      url "https://github.com/star-plan/code-porter/releases/download/v${version}/${a_m_amd}"
      sha256 "${m_amd}"

      def install
        bin.install "${a_m_amd}" => "code-porter"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/star-plan/code-porter/releases/download/v${version}/${a_l_amd}"
      sha256 "${l_amd}"

      def install
        bin.install "${a_l_amd}" => "code-porter"
      end
    end
  end

  test do
    assert_match "scan", shell_output("#{bin}/code-porter --help")
  end
end
EOF
  echo "code-porter.rb -> v${version}"
}

main() {
  sync_ship
  sync_code_porter
  echo "formula sync complete"
}

main "$@"
