class Gentic < Formula
  desc "Gentic agent: runs Claude Code or Codex over ACP for queued issues"
  homepage "https://github.com/kprovorov/gentic"
  version "0.10.0"

  on_macos do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.10.0/gentic-0.10.0-darwin-arm64.tar.gz"
      sha256 "be869ea3b4fc58847c98806109e544d96ae6833e80ff2209edcf131ae07e9987"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.10.0/gentic-0.10.0-darwin-x64.tar.gz"
      sha256 "a323175fa362b611b6fc15b98cd578468ddd6e42aefdfd0a386c119b5b86db85"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.10.0/gentic-0.10.0-linux-arm64.tar.gz"
      sha256 "86a4c43e146266bf6e533b03e676e74f43e3b6c0b4d694ba79e83cff2875b742"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.10.0/gentic-0.10.0-linux-x64.tar.gz"
      sha256 "422d9e4bfd07a999e1bf7db88077edf3a0b83f2d49cf6e8ea55d59117c2f42bd"
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
