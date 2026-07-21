class Gentic < Formula
  desc "Gentic agent: runs Claude Code or Codex over ACP for queued issues"
  homepage "https://github.com/kprovorov/gentic"
  version "0.11.0"

  on_macos do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.11.0/gentic-0.11.0-darwin-arm64.tar.gz"
      sha256 "61435fb6f9acb5b4f761a31e2c2a05e196002ddd8ec4e2bd6a5a4f621b2afbce"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.11.0/gentic-0.11.0-darwin-x64.tar.gz"
      sha256 "1714f2d51ec26696e731144849e05a9b4c07aac463cc3fb0b9b14e87d86d3d64"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.11.0/gentic-0.11.0-linux-arm64.tar.gz"
      sha256 "3701fe94357e6cb083055dee3c6e5d9adbcb2ff522f0cab4650d422d1eb6ab55"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.11.0/gentic-0.11.0-linux-x64.tar.gz"
      sha256 "20ecda09aba8e9ebcdec04b58eeca974cab6af6ab6ef3fa6171ea0ef1b6b5941"
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
