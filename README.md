# Shell
# GitHub API Communication Script

This Bash script provides a simple way to interact with the GitHub REST API, allowing you to retrieve information from GitHub using your personal access token and specific API endpoints.

---

## Features

* **Easy Communication:** Make GET requests to any GitHub REST API endpoint.
* **Pagination Handling:** Automatically handles paginated results, retrieving all pages of data.
* **Secure Authentication:** Uses your GitHub Personal Access Token for authentication.

---

## Prerequisites

Before using this script, make sure you have the following:

* **`curl`:** A command-line tool for making HTTP requests (usually pre-installed on most Linux distributions).
* **GitHub Personal Access Token:** You'll need a token with appropriate permissions for the data you want to access. You can generate one in your GitHub settings under **Developer settings > Personal access tokens**.

---

## Usage

To use the script, you need to provide your GitHub Personal Access Token and the desired GitHub REST API endpoint.

```bash
./github_api_script.sh [YOUR_GITHUB_TOKEN] [REST_API_EXPRESSION]
```
Examples
1. List your public repositories:
```bash
./github_api_script.sh YOUR_TOKEN /user/repos
```
2. Get information about a specific repository (e.g., octocat/Spoon-Knife):
```bash
./github_api_script.sh YOUR_TOKEN /repos/octocat/Spoon-Knife
```
3. List all members of an organization (e.g., google):
```bash
./github_api_script.sh YOUR_TOKEN /orgs/google/members
```

## How it Works
* The script performs the following steps:

- Argument Check: Verifies that both the GitHub token and REST API expression are provided.
- Authentication & Headers: Sets up the necessary Authorization header with your token and the Accept header for GitHub API v3 JSON.
- Pagination Detection: It first makes a HEAD request to the API endpoint to check for a Link: header, which indicates if the results are paginated.
Data Retrieval:
- If no pagination is detected, it fetches the single page of data.
- If pagination is detected, it iterates through all pages, making a GET request for each page.
- Output: All retrieved data is concatenated and printed to standard output. A temporary file is used to store the results during the process.
## Troubleshooting
- "usage: ... " error: This means you haven't provided both the GitHub token and the REST API expression.
- Authentication Errors: Double-check your GitHub Personal Access Token. Ensure it's correct and has the necessary permissions for the API endpoint you're trying to access.
- Rate Limiting: GitHub has API rate limits. If you make too many requests in a short period, you might encounter rate limiting errors.
- Invalid REST API Expression: Ensure the [REST_API_EXPRESSION] you're using is a valid GitHub REST API endpoint. Refer to the GitHub API Documentation for available endpoints.
