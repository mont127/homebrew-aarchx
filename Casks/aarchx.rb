cask "aarchx" do
  version "0.7"
  sha256 "ee703276f7ecd7cc8f27b42ee120eaed6f3c97b62e3508dfa080c0c4a851bdd6"

  url "https://github.com/mont127/AArchX/releases/download/v#{version}/aarchx-macos-arm64.tar.gz"
  name "AArchX"
  desc "Runs x86-64 macOS programs on Apple silicon"
  homepage "https://github.com/mont127/AArchX"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64

  binary "aarchx/ocerz"

  # ocerz is not notarized; Homebrew quarantines what it downloads, and
  # Gatekeeper would refuse the binary until the flag is gone.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/aarchx"]
  end

  zap trash: "~/Library/Caches/ocerz"
end
