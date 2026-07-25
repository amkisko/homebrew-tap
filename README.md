# amkisko/homebrew-tap

Homebrew formulas for [amkisko](https://github.com/amkisko) and related CLI tools.

## Install

```bash
brew tap amkisko/tap
brew install status-cli
```

Or in one step:

```bash
brew install amkisko/tap/status-cli
```

### Available formulas

| Formula | Binary | Project |
|---------|--------|---------|
| `status-cli` | `status` | [status-cli.rs](https://github.com/amkisko/status-cli.rs) |
| `scout-cli` | `scout` | [scout-cli.rs](https://github.com/amkisko/scout-cli.rs) |
| `timely-cli` | `timely` | [timely-cli.rs](https://github.com/amkisko/timely-cli.rs) |
| `bmx` | `bmx` | [bmx.rs](https://github.com/amkisko/bmx.rs) |
| `pray` | `pray` | [kiskolabs/pray](https://github.com/kiskolabs/pray) |

### Head (latest main)

```bash
brew install --HEAD amkisko/tap/status-cli
brew install --HEAD amkisko/tap/timely-cli
brew install --HEAD amkisko/tap/bmx
brew install --HEAD amkisko/tap/pray
```

## Local formula bumps (no GitHub secrets)

After you push a `v*` tag to the upstream GitHub repo, bump the formula locally:

```bash
# from this tap checkout
make bump FORMULA=bmx TAG=v0.1.3 COMMIT=1 PUSH=1

# or
./scripts/bump-formula.sh --formula timely-cli --tag v0.1.0 --commit --push
./scripts/bump-formula.sh --formula pray --tag v1.2.0 --commit --push
```

From an upstream tool repo (sibling checkout expected at `../homebrew-tap`):

```bash
make bump-homebrew
```

That target reads `Cargo.toml` version, fetches the GitHub archive checksum, updates `Formula/*.rb`, and commits in the tap. Push the tap when ready.

Optional packaging mirror (keeps in-repo `packaging/homebrew/*.rb` in sync):

```bash
./scripts/bump-formula.sh --formula bmx --tag v0.1.3 \
  --mirror ../bmx.rs/packaging/homebrew/bmx.rb --commit
```

## License

Formulas follow the license of each upstream project (MIT unless noted).
