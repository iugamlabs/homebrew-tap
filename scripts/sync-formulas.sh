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

sync_aiquokka() {
  local repo="star-plan/aiquokka"
  local tag version dir sums
  local m_arm m_amd l_arm l_amd

  local a_m_arm="aiquokka-macos-arm64"
  local a_m_amd="aiquokka-macos-amd64"
  local a_l_arm="aiquokka-linux-arm64"
  local a_l_amd="aiquokka-linux-amd64"

  # Latest GitHub Release only.
  if ! tag="$(gh release view -R "$repo" --json tagName -q .tagName 2>/dev/null)"; then
    echo "aiquokka: no GitHub Release yet; skip"
    return 0
  fi

  version="${tag#v}"
  dir="$TMP/aiquokka"
  mkdir -p "$dir"

  # GoReleaser already publishes SHA256SUMS containing hashes for every binary,
  # so there is no need to download the binaries themselves.
  if ! gh release download "$tag" \
      -R "$repo" \
      -D "$dir" \
      -p "SHA256SUMS" 2>/dev/null; then
    echo "aiquokka: release $tag has no SHA256SUMS; skip"
    return 0
  fi

  sums="$dir/SHA256SUMS"

  m_arm="$(hash_for "$a_m_arm" "$sums")"
  m_amd="$(hash_for "$a_m_amd" "$sums")"
  l_arm="$(hash_for "$a_l_arm" "$sums")"
  l_amd="$(hash_for "$a_l_amd" "$sums")"

  if [[ -z "$m_arm" || -z "$m_amd" || -z "$l_arm" || -z "$l_amd" ]]; then
    echo "aiquokka: incomplete macOS/Linux assets on $tag; skip" >&2
    cat "$sums" >&2
    return 0
  fi

  cat > "$ROOT/aiquokka.rb" <<EOF
# typed: false
# frozen_string_literal: true

# Homebrew formula for aiquokka — updated by this tap's sync workflow.
class Aiquokka < Formula
  desc "Unified subscription quota monitor for Claude, Codex, Cursor, Grok, and more"
  homepage "https://github.com/star-plan/aiquokka"
  version "${version}"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/star-plan/aiquokka/releases/download/${tag}/${a_m_arm}"
      sha256 "${m_arm}"

      def install
        bin.install "${a_m_arm}" => "aiquokka"
      end
    end

    on_intel do
      url "https://github.com/star-plan/aiquokka/releases/download/${tag}/${a_m_amd}"
      sha256 "${m_amd}"

      def install
        bin.install "${a_m_amd}" => "aiquokka"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/star-plan/aiquokka/releases/download/${tag}/${a_l_arm}"
      sha256 "${l_arm}"

      def install
        bin.install "${a_l_arm}" => "aiquokka"
      end
    end

    on_intel do
      url "https://github.com/star-plan/aiquokka/releases/download/${tag}/${a_l_amd}"
      sha256 "${l_amd}"

      def install
        bin.install "${a_l_amd}" => "aiquokka"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aiquokka --version")
  end
end
EOF

  echo "aiquokka.rb -> v${version}"
}

sync_starblog_publisher() {
  local repo="star-blog/starblog-publisher"
  local tag version dir sums
  local aot_m_arm aot_m_amd aot_l_amd fd_m_arm fd_m_amd fd_l_amd sc_m_arm sc_m_amd sc_l_amd
  local aot_h_m_arm aot_h_m_amd aot_h_l_amd fd_h_m_arm fd_h_m_amd fd_h_l_amd sc_h_m_arm sc_h_m_amd sc_h_l_amd

  if ! tag="$(gh release view -R "$repo" --json tagName -q .tagName 2>/dev/null)"; then
    echo "starblog-publisher: no GitHub Release yet; skip"
    return 0
  fi

  version="${tag#v}"
  dir="$TMP/starblog-publisher"
  mkdir -p "$dir"
  if ! gh release download "$tag" -R "$repo" -D "$dir" -p "SHA256SUMS" 2>/dev/null; then
    echo "starblog-publisher: release $tag has no SHA256SUMS yet; skip"
    return 0
  fi

  sums="$dir/SHA256SUMS"
  aot_m_arm="StarBlogPublisher-macOS-arm64-aot-${version}.tar.gz"
  aot_m_amd="StarBlogPublisher-macOS-aot-${version}.tar.gz"
  aot_l_amd="StarBlogPublisher-linux-aot-${version}.tar.gz"
  fd_m_arm="StarBlogPublisher-macOS-arm64-framework-dependent-${version}.tar.gz"
  fd_m_amd="StarBlogPublisher-macOS-framework-dependent-${version}.tar.gz"
  fd_l_amd="StarBlogPublisher-linux-framework-dependent-${version}.tar.gz"
  sc_m_arm="StarBlogPublisher-macOS-arm64-self-contained-${version}.tar.gz"
  sc_m_amd="StarBlogPublisher-macOS-self-contained-${version}.tar.gz"
  sc_l_amd="StarBlogPublisher-linux-self-contained-${version}.tar.gz"

  aot_h_m_arm="$(hash_for "$aot_m_arm" "$sums")"
  aot_h_m_amd="$(hash_for "$aot_m_amd" "$sums")"
  aot_h_l_amd="$(hash_for "$aot_l_amd" "$sums")"
  fd_h_m_arm="$(hash_for "$fd_m_arm" "$sums")"
  fd_h_m_amd="$(hash_for "$fd_m_amd" "$sums")"
  fd_h_l_amd="$(hash_for "$fd_l_amd" "$sums")"
  sc_h_m_arm="$(hash_for "$sc_m_arm" "$sums")"
  sc_h_m_amd="$(hash_for "$sc_m_amd" "$sums")"
  sc_h_l_amd="$(hash_for "$sc_l_amd" "$sums")"

  if [[ -z "$aot_h_m_arm" || -z "$aot_h_m_amd" || -z "$aot_h_l_amd" || -z "$fd_h_m_arm" || -z "$fd_h_m_amd" || -z "$fd_h_l_amd" || -z "$sc_h_m_arm" || -z "$sc_h_m_amd" || -z "$sc_h_l_amd" ]]; then
    echo "starblog-publisher: incomplete macOS/Linux release assets for $tag; skip" >&2
    return 0
  fi

  python3 - "$ROOT" "$version" \
    "$aot_h_m_arm" "$aot_h_m_amd" "$aot_h_l_amd" \
    "$fd_h_m_arm" "$fd_h_m_amd" "$fd_h_l_amd" \
    "$sc_h_m_arm" "$sc_h_m_amd" "$sc_h_l_amd" <<'PY'
from pathlib import Path
import sys

(root, version, aot_m_arm, aot_m_amd, aot_l_amd,
 fd_m_arm, fd_m_amd, fd_l_amd,
 sc_m_arm, sc_m_amd, sc_l_amd) = sys.argv[1:12]
repo = "https://github.com/star-blog/starblog-publisher"

variants = [
    ("starblog-publisher", "StarblogPublisher", "aot", "Native AOT desktop application", False,
     aot_m_arm, aot_m_amd, aot_l_amd),
    ("starblog-publisher-framework-dependent", "StarblogPublisherFrameworkDependent", "framework-dependent",
     "Framework-dependent desktop application", True, fd_m_arm, fd_m_amd, fd_l_amd),
    ("starblog-publisher-self-contained", "StarblogPublisherSelfContained", "self-contained",
     "Self-contained (non-AOT) desktop application", False, sc_m_arm, sc_m_amd, sc_l_amd),
]

for package, klass, mode, description, needs_dotnet, h_m_arm, h_m_amd, h_l_amd in variants:
    asset_m_arm = f"StarBlogPublisher-macOS-arm64-{mode}-{version}.tar.gz"
    asset_m_amd = f"StarBlogPublisher-macOS-{mode}-{version}.tar.gz"
    asset_l_amd = f"StarBlogPublisher-linux-{mode}-{version}.tar.gz"
    dependency = '  depends_on "dotnet@10"\n' if needs_dotnet else ''
    if needs_dotnet:
        install = f'''  def install
    libexec.install Dir["*"]
    (bin/"{package}").write <<~EOS
      #!/bin/bash
      export DOTNET_ROOT="#{{HOMEBREW_PREFIX}}/opt/dotnet@10/libexec"
      exec "#{{libexec}}/StarBlogPublisher" "$@"
    EOS
    chmod 0755, bin/"{package}"
  end
'''
    else:
        install = f'''  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"StarBlogPublisher" => "{package}"
  end
'''
    formula = f'''# typed: false
# frozen_string_literal: true

# Generated by scripts/sync-formulas.sh from the latest GitHub Release.
class {klass} < Formula
  desc "{description}"
  homepage "{repo}"
  version "{version}"
  license "MIT"
{dependency}
  on_macos do
    on_arm do
      url "{repo}/releases/download/v{version}/{asset_m_arm}"
      sha256 "{h_m_arm}"
    end

    on_intel do
      url "{repo}/releases/download/v{version}/{asset_m_amd}"
      sha256 "{h_m_amd}"
    end
  end

  on_linux do
    on_intel do
      url "{repo}/releases/download/v{version}/{asset_l_amd}"
      sha256 "{h_l_amd}"
    end
  end

{install}
  test do
    assert_predicate bin/"{package}", :executable?
  end
end
'''
    Path(root, f"{package}.rb").write_text(formula, encoding="utf-8")
    print(f"{package}.rb -> v{version}")
PY
}

main() {
  sync_ship
  sync_code_porter
  sync_aiquokka
  sync_starblog_publisher
  echo "formula sync complete"
}

main "$@"
