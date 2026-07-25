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

## Automated formula bumps

When a project pushes a `v*` tag, its `homebrew-tap.yml` workflow dispatches into this repository. The `bump-formula` workflow then:

1. waits for the GitHub source archive to exist
2. computes `sha256`
3. updates `Formula/<name>.rb` `url` + `sha256`
4. commits to `main`

### One-time secret setup

Create a fine-grained PAT (or classic PAT) with access to **this** repository:

- Contents: Read and write
- Metadata: Read

Add it as repository secret `HOMEBREW_TAP_TOKEN` on each upstream project that should bump formulas (`bmx.rs`, `timely-cli.rs`, `scout-cli.rs`, `status-cli.rs`, `kiskolabs/pray`).

Manual bump from this repo:

```bash
gh workflow run bump-formula.yml \
  -f formula=bmx \
  -f tag=v0.1.3 \
  -f repository=amkisko/bmx.rs
```

## License

Formulas follow the license of each upstream project (MIT unless noted).
