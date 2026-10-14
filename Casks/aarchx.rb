cask "aarchx" do
  version "0.7.3"
  sha256 "884d74428559f288b2d7f5a8dcc80f60de7ff4a4309ed9774e033bbda921474c"

  url "https://github.com/mont127/AArchX/releases/download/v#{version}/aarchx-macos-arm64.tar.gz"
  name "AArchX"
  desc "Runs x86-64 macOS programs on Apple silicon"
  homepage "https://github.com/mont127/AArchX"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64

  app "aarchx/AArchX.app"
  binary "aarchx/ocerz"

  # Nothing here is notarized; Homebrew quarantines what it downloads, and
  # Gatekeeper would refuse ocerz and the app until the flag is gone.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/aarchx"]
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/AArchX.app"]
  end

  zap trash: [
    "~/Library/Caches/ocerz",
    "~/Library/Logs/AArchX",
    "~/Library/Preferences/io.github.mont127.aarchx.plist",
  ]
end
