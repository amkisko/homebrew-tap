#!/usr/bin/env bash
# Bump a formula's GitHub archive url + sha256 after an upstream tag exists.
#
# Usage:
#   ./scripts/bump-formula.sh --formula bmx --tag v0.1.3
#   ./scripts/bump-formula.sh --formula timely-cli --tag v0.1.0 --commit
#   ./scripts/bump-formula.sh --formula bmx --tag v0.1.3 --commit --push
#   ./scripts/bump-formula.sh --formula bmx --tag v0.1.3 \
#       --mirror ../bmx.rs/packaging/homebrew/bmx.rb --commit

set -euo pipefail

formula=""
tag=""
repository=""
mirror=""
do_commit=0
do_push=0

default_repository() {
  case "$1" in
    bmx) echo "amkisko/bmx.rs" ;;
    timely-cli) echo "amkisko/timely-cli.rs" ;;
    scout-cli) echo "amkisko/scout-cli.rs" ;;
    status-cli) echo "amkisko/status-cli.rs" ;;
    pray) echo "kiskolabs/pray" ;;
    *) return 1 ;;
  esac
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --formula)
      formula="${2:?}"
      shift 2
      ;;
    --tag)
      tag="${2:?}"
      shift 2
      ;;
    --repository)
      repository="${2:?}"
      shift 2
      ;;
    --mirror)
      mirror="${2:?}"
      shift 2
      ;;
    --commit)
      do_commit=1
      shift
      ;;
    --push)
      do_push=1
      do_commit=1
      shift
      ;;
    -h | --help)
      sed -n '2,12p' "$0"
      exit 0
      ;;
    *)
      echo "unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

if [[ -z "$formula" || -z "$tag" ]]; then
  echo "--formula and --tag are required" >&2
  exit 2
fi

if [[ -z "$repository" ]]; then
  repository="$(default_repository "$formula")" || {
    echo "unknown formula '$formula'; pass --repository owner/repo" >&2
    exit 2
  }
fi

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

formula_path="Formula/${formula}.rb"
if [[ ! -f "$formula_path" ]]; then
  echo "missing $formula_path" >&2
  exit 1
fi

url="https://github.com/${repository}/archive/refs/tags/${tag}.tar.gz"
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

echo "fetching $url"
for attempt in $(seq 1 36); do
  if curl -fsSL -o "$tmp" "$url"; then
    break
  fi
  if [[ "$attempt" -eq 36 ]]; then
    echo "tarball not available after retries: $url" >&2
    echo "push the tag to GitHub first, then re-run." >&2
    exit 1
  fi
  sleep 5
done

sha256="$(shasum -a 256 "$tmp" | awk '{print $1}')"
echo "sha256=$sha256"

python3 "$root/scripts/bump_formula.py" \
  "$formula_path" \
  --repository "$repository" \
  --tag "$tag" \
  --sha256 "$sha256"

if [[ -n "$mirror" ]]; then
  if [[ ! -f "$mirror" ]]; then
    echo "missing mirror formula: $mirror" >&2
    exit 1
  fi
  python3 "$root/scripts/bump_formula.py" \
    "$mirror" \
    --repository "$repository" \
    --tag "$tag" \
    --sha256 "$sha256"
  echo "mirrored to $mirror"
fi

if [[ "$do_commit" -eq 1 ]]; then
  if git diff --quiet -- "$formula_path"; then
    echo "tap formula already current; nothing to commit"
  else
    git add "$formula_path"
    git commit -m "Bump ${formula} to ${tag}"
  fi
fi

if [[ "$do_push" -eq 1 ]]; then
  git push origin HEAD
fi

echo "done: ${formula} -> ${tag}"
