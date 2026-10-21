cask "aarchx" do
  version "0.9"
  sha256 "305d0cd1617daf301d58534f48e92c816ba64682cb2d4297c3e4372d8d7aa135"

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
    # The C++ and X11 libraries 32-bit games need, which no release carries:
    # MacPorts' packages (about 15 MB), fetched into the staged runtime, over
    # Apple's TLS: macOS's curl defaults to LibreSSL, which still trusts the
    # eMudhra intermediate CAs whose keys became public in October 2026.
    run "/bin/sh", args: ["-c", "'{{staged_path}}/aarchx/tools/fetch_guest32_cxx.sh' >/dev/null && " \
                                "'{{staged_path}}/aarchx/tools/fetch_guest32_x11.sh' >/dev/null || " \
                                "echo 'aarchx: the 32-bit runtimes could not be fetched; see the README'"],
        env: { "CURL_SSL_BACKEND" => "secure-transport" }, network_access: true, print_stdout: true
  end

  zap trash: [
    "~/Library/Caches/ocerz",
    "~/Library/Logs/AArchX",
    "~/Library/Preferences/io.github.mont127.aarchx.plist",
  ]
end
