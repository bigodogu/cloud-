!/bin/bash

INPUT="users.csv"

# Check if the file exists
if [[ ! -f $ INPUT ]]; then
  echo "CSV file not found!"
  exit 1
fi

# Skip header and read each line
tail -n +2 "$INPUT" | while IFS=',' read -r username password; do
  if id "$username" &>/dev/null; then
    echo "User '$username' already exists. Skipping..."
    continue
  fi

  useradd "$username"
 
  echo "${username}:${password}" | chpasswd

  chage -d 0 "$username"

  echo "User '$username' created successfully."
done 

