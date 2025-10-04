# 🐚 GitHub REST API Helper Script

A lightweight **Bash script** to interact with the **GitHub REST API** directly from the command line.  
It supports **authentication**, **pagination**, and outputs **JSON responses** for easy automation and scripting.

---

## ✍️ Author

**Author:** Abhishek  
**Version:** v1  
**License:** MIT  

---

## ⚙️ Features

✅ Works with any GitHub REST API endpoint  
✅ Supports authentication via Personal Access Token (PAT)  
✅ Automatically handles paginated results  
✅ Outputs complete JSON data  
✅ No dependencies beyond `bash` and `curl`  

---

## 🧩 Requirements

Before using the script, ensure you have:

- **Bash** (v4.0 or newer)  
- **curl** installed  
- A **GitHub Personal Access Token (PAT)**  
  👉 Create one at [https://github.com/settings/tokens](https://github.com/settings/tokens)  

---

## 🚀 Usage

### Syntax
```bash
./github_api_helper.sh [GITHUB_TOKEN] [REST_API_ENDPOINT]

