class Gentic < Formula
  desc "Gentic agent: runs Claude Code or Codex over ACP for queued issues"
  homepage "https://github.com/kprovorov/gentic"
  version "0.7.0"

  on_macos do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.7.0/gentic-0.7.0-darwin-arm64.tar.gz"
      sha256 "75ce0972a05336e1ffbdf80b4afb5d4a8b8855ff4da63e79730956d4f764569e"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.7.0/gentic-0.7.0-darwin-x64.tar.gz"
      sha256 "cc37f28ca45bacdb726fc43cb28a0daf6dde5e91626b7eb73753cb251fd30ddb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kprovorov/gentic/releases/download/v0.7.0/gentic-0.7.0-linux-arm64.tar.gz"
      sha256 "2e223e631b5bcc9a31a8ad150fe58b08c60e9b4950cc91816a170163add9c118"
    end
    on_intel do
      url "https://github.com/kprovorov/gentic/releases/download/v0.7.0/gentic-0.7.0-linux-x64.tar.gz"
      sha256 "c0599ae119c99fa91d0b4e871c0ac82364d287d552b2a341f3934c701090d807"
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
