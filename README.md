# Shell
Schell Scripts

# GitHub REST Helper (simple)

Small Bash script to call the GitHub REST API, handle basic pagination, and print combined JSON to stdout.

Usage
```
./script.sh <GITHUB_TOKEN> <REST_PATH>
```
- GITHUB_TOKEN: personal access token (or leave empty for unauthenticated calls, but rate-limited).
- REST_PATH: API path starting with `/`, e.g. `/rate_limit` or `/repos/octocat/Hello-World/issues`.

Example
```
./script.sh ghp_XXXX /users/octocat/repos | jq .
```

Requirements
- bash
- curl
- mktemp

Notes
- The script checks the `Link` header and fetches pages 1..N when paginated.
- Treat tokens like passwords — do not commit or share them.
- A small improvement: add `trap 'rm -f "$TMPFILE"' EXIT` to remove the temp file on exit.
