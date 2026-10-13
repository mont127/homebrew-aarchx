cask "aarchx" do
  version "0.7.1"
  sha256 "3f3bd4e6fa97844eec33ca2c9775b42f2d7e85705416bc25539b0f4602962458"

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
