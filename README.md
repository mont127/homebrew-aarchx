# homebrew-aarchx

The Homebrew tap for [AArchX](https://github.com/mont127/AArchX), which runs
x86-64 macOS programs on Apple silicon.

```sh
brew install --cask mont127/aarchx/aarchx
ocerz version
ocerz /Applications/Some.app
```

The cask installs the prebuilt `ocerz` from the latest AArchX release, with
the runtime files it reads, links `ocerz` into Homebrew's `bin`, and puts
AArchX.app, the window that runs programs without Terminal, in `/Applications`.

AArchX is not notarized. Homebrew quarantines what it downloads, so the cask
removes that flag after installing; otherwise Gatekeeper would refuse to run
`ocerz` and the app.

`brew upgrade --cask aarchx` updates it. `brew uninstall --cask aarchx` removes
it, and adding `--zap` also deletes the translation cache, the app's logs and its
settings.

Cache mode needs Rosetta installed, because Rosetta's package ships Apple's
x86-64 shared cache. Native mode (`ocerz -native`) does not. See
[Getting started](https://github.com/mont127/AArchX/blob/main/docs/getting-started.md).
