class Gentic < Formula
  desc "Gentic agent: runs Claude Code or Codex over ACP for queued issues"
  homepage "https://github.com/kprovorov/gentic"
  version "0.9.0"

  on_macos do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.9.0/gentic-0.9.0-darwin-arm64.tar.gz"
      sha256 "922bbf423619c571c1d98f20413005e0579fd83962e39119ecad8e281e6a82e4"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.9.0/gentic-0.9.0-darwin-x64.tar.gz"
      sha256 "9a2a8737bfd38aefda7f72abe09070e62268ada42a20f9cd89854c48fa09468e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.9.0/gentic-0.9.0-linux-arm64.tar.gz"
      sha256 "ab50564c82ee33673a23299eaa21c831257cdbcb8302aa95b16675c2672e325a"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.9.0/gentic-0.9.0-linux-x64.tar.gz"
      sha256 "3ac3ddac5fcaafe3d068f77570ea31f6afc8cf9f3c8af9c2e25084eadd2d2d72"
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
