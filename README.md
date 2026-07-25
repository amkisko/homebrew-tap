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

Stable tarball installs need a tagged GitHub release and a filled `sha256` in the formula.

## License

Formulas follow the license of each upstream project (MIT unless noted).
