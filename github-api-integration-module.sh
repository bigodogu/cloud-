#!/bin/bash
set -euo pipefail

GITHUB_TOKEN="${GITHUB_TOKEN:-}"
GITHUB_API_REST="${1:-}"

# Validation
if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "Error: GITHUB_TOKEN environment variable not set" >&2
  echo "Usage: GITHUB_TOKEN=ghp_xxx $0 /users/octocat" >&2
  exit 1
fi

if [[ -z "$GITHUB_API_REST" || ! "$GITHUB_API_REST" =~ ^/ ]]; then
  echo "Error: Provide REST path starting with / (e.g., /users/octocat)" >&2
  exit 1
fi

TMPFILE=$(mktemp) || { echo "Temp file creation failed"; exit 1; }
trap 'rm -f "$TMPFILE"' EXIT

rest_call() {
  curl -f -s "https://api.github.com$1" \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token $GITHUB_TOKEN" >> "$TMPFILE"
}

# Get last page from Link header
last_page=$(curl -sI "https://api.github.com${GITHUB_API_REST}" \
  -H "Authorization: token $GITHUB_TOKEN" 2>/dev/null \
  | grep '^Link:' | grep -o 'page=[0-9]*>; rel="last"' | grep -o '[0-9]*' || echo "")

if [[ -z "$last_page" ]]; then
  rest_call "$GITHUB_API_REST"
else
  for p in $(seq 1 "$last_page"); do
    rest_call "${GITHUB_API_REST}?page=$p"
  done
fi

# Output result
if command -v jq &>/dev/null; then
  jq . "$TMPFILE"
else
  cat "$TMPFILE"
fi