class Gentic < Formula
  desc "Gentic agent: runs Claude Code or Codex over ACP for queued issues"
  homepage "https://github.com/kprovorov/gentic"
  version "0.4.1"

  on_macos do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.4.1/gentic-bun-darwin-arm64.tar.gz"
      sha256 "7a32594ab3742b0efbb30a7f28217233b840d42d2b3a7478d1531543cd80d205"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.4.1/gentic-bun-darwin-x64.tar.gz"
      sha256 "e07bb55b5fb713f3dcc8476db2837be741cd1e83791c00efb473b12cb06d8a1a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.4.1/gentic-bun-linux-arm64.tar.gz"
      sha256 "1086af9543d06af265305fd5a046565843786f3c3c2bbdbeb68d845f58089872"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.4.1/gentic-bun-linux-x64.tar.gz"
      sha256 "ab8b6431054f0f721bd5f6a623fdca86a984db2bc19d0045670f6030d1dc98fd"
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
