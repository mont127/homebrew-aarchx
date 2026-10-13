cask "aarchx" do
  version "0.7"
  sha256 "1d289a3f823b09a39025b9759e31c58ae1307e7914dc67f7e5985cd357e0149f"

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
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{staged_path}/aarchx"]
  end

  zap trash: "~/Library/Caches/ocerz"
end
