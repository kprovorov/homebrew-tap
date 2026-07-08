class Gentic < Formula
  desc "Gentic agent: runs Claude Code or Codex over ACP for queued issues"
  homepage "https://github.com/kprovorov/gentic"
  version "0.4.0"

  on_macos do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.4.0/gentic-bun-darwin-arm64.tar.gz"
      sha256 "5dc3171953165452442c713046a7f5340820e83dac3024e4fe1d8544a151d01e"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.4.0/gentic-bun-darwin-x64.tar.gz"
      sha256 "33d1f2f44f0a360d7b6fd3a25dba5c0e15e78ba13a334b61458c871e2ef3eb46"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.4.0/gentic-bun-linux-arm64.tar.gz"
      sha256 "eb0daa3c0023459437511817e2b20f4da46e6ff20297fe2d7123b6eb094912d6"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.4.0/gentic-bun-linux-x64.tar.gz"
      sha256 "f3c2817ccb4cc0405e0a2a5844c9f2a4f8b2d79f645b5ee6484cc651e85d8653"
    end
  end

  def install
    # vendor/ (the ACP agent sidecars spawned by src/session.ts) has to land
    # next to the gentic binary itself, not just anywhere under the prefix.
    # bin/ in a Homebrew keg is a symlink into libexec, and process.execPath
    # resolves through that symlink to the real file — so installing both
    # into libexec and symlinking bin -> libexec/gentic keeps
    # dirname(execPath)/vendor pointing at the right place. Verified against
    # a real bun-compiled binary run through a simulated Cellar/bin symlink
    # layout; see packaging/homebrew-gentic/README.md.
    libexec.install "gentic", "vendor"
    bin.install_symlink libexec/"gentic"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gentic --version")
  end
end
