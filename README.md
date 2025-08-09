# GitHub API Fetcher Script

## Overview

This shell script enables users to interact with the GitHub REST API using a personal access token. It handles both single-page and paginated responses, retrieving and displaying JSON-formatted data from any valid GitHub REST endpoint.

## Author

**Abhishek**

## Version

`v1`

## Features

- Access GitHub REST API using a token.
- Handles paginated API responses.
- Stores and outputs the retrieved data in raw JSON format.
- Easily extendable for more complex GitHub automation tasks.

## Prerequisites

- `bash` shell
- `curl` command-line tool
- A valid [GitHub Personal Access Token (PAT)](https://github.com/settings/tokens)

## Usage

```bash
./github_api_fetch.sh <GITHUB_TOKEN> <GITHUB_REST_API_ENDPOINT>

```

## Example

    ./github_api_fetch.sh ghp_YourTokenHere /users/octocat/repos

This example fetches the list of public repositories for the GitHub user octocat.
