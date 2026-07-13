class Gentic < Formula
  desc "Gentic agent: runs Claude Code or Codex over ACP for queued issues"
  homepage "https://github.com/kprovorov/gentic"
  version "0.8.0"

  on_macos do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.8.0/gentic-0.8.0-darwin-arm64.tar.gz"
      sha256 "df08e1bb1ed7680b9bd3c79d3b52f4a916847ad60dde13a7dba4c2b3a7e83e32"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.8.0/gentic-0.8.0-darwin-x64.tar.gz"
      sha256 "3bf99b405619c90626cb20a74bc9812ca5a1c6048e711ba3e8bef9fc60286466"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.8.0/gentic-0.8.0-linux-arm64.tar.gz"
      sha256 "85bb8f46a7b8825a193c2d0deadce1279589cdc28474cb9d712d63344851a04a"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.8.0/gentic-0.8.0-linux-x64.tar.gz"
      sha256 "34e41c72cff72e62e79abb7afc588ad679f2c9f6b07e54bb37fb2d262e4f975a"
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
