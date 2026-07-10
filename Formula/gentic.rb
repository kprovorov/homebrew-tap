class Gentic < Formula
  desc "Gentic agent: runs Claude Code or Codex over ACP for queued issues"
  homepage "https://github.com/kprovorov/gentic"
  version "0.6.0"

  on_macos do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.6.0/gentic-0.6.0-darwin-arm64.tar.gz"
      sha256 "1ba05aeee5d6b5ed719aadf663fde018b0f81b1fd3725d9871e113926d2294f6"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.6.0/gentic-0.6.0-darwin-x64.tar.gz"
      sha256 "4cade99f6b82f1e7b9e7d06871003362f4a9109c32fc6b6cfe4bed760f9ac04c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.6.0/gentic-0.6.0-linux-arm64.tar.gz"
      sha256 "5a76b56541c6b6577c72c5ab1d155f77267d7464aa0fc897fae67ae3e0aa78ed"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.6.0/gentic-0.6.0-linux-x64.tar.gz"
      sha256 "a2bc83f9197cfce06aa59ed9f150f837c12de671fc477dd28c709f1a606a6efe"
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
