#!/bin/bash

# Define the filename to check
passwd_file_name="/etc/passwd"

function print_home() {
    printf '#%.0s' {1..50}
    echo
    # Print the home dir for the user
    echo "1. Home directory for current user is \"$HOME\""
}

function list_usernames() {
    printf '#%.0s' {1..50}
    echo
    echo "2. Reading users from the passwd file":
    # Loop through each line in the file
    while IFS= read -r line; do 
        # We save the first field (separating by ":") from the line value in the user_name variable
        user_name=$(echo "$line" | awk -F: '{print $1}')
        echo "$user_name"
        # You can add your own commands here to process each line
    done < "$passwd_file_name"
}

function count_users() {
    # We count the number of lines that are not empty or that do not start with # I.E. comments
    num_users=$(grep -v '^#' /etc/passwd | grep -v '^$' | wc -l)
    printf '#%.0s' {1..50}
    echo
    echo "3. The number of users is: $num_users"
}

function print_home_dir_for_user() {
    printf '#%.0s' {1..50}
    echo
    echo "4. Please enter the user for who you want to find the home directory:"
    read find_user

    # Using the grep cmd, we find the line which contains the regex ^ which is a line that starts with the input user value
    searched_user_row=$(grep "^$find_user:" /etc/passwd)

    # We first check if such an user exists by checking the found row if it's empty or not
    if [ -z "$searched_user_row" ]; then
        echo "There is no such user as $find_user"
    else
        # We save the 6th field (separating by ":") from the searched_user_row value in the home_directory variable
        home_directory=$(echo "$searched_user_row" | awk -F: '{print $6}')

        echo "The home directory for $find_user is \"$home_directory\""
    fi
}

function list_users_by_uid() {
    min_bound=10
    max_bound=50

    printf '#%.0s' {1..50}
    echo
    echo "5. The users with the UID within the $min_bound-$max_bound range are:"

    # Loop through each line in the file
    while IFS= read -r line; do 
        # We save the 3rd field (separating by ":") from the line value in the uid variable
        uid=$(echo "$line" | awk -F: '{print $3}')
        # If the uid variable is >= min_bound and <= max_bound we store the user_name the same way and print it
        if [ "$uid" -ge "$min_bound" ] && [ "$uid" -le "$max_bound" ]; then
            user_name=$(echo "$line" | awk -F: '{print $1}')
            echo "$user_name has the UID $uid"
        fi
    done < "$passwd_file_name"
}

function list_users_by_shell() {
    shell_type_1="/bin/bash"
    shell_type_2="/bin/sh"
    echo "6. The users with the shell like \"$shell_type_1\" or \"$shell_type_2\" :"

    while IFS= read -r line; do 
        # We save the last field (separating by ":") from the line value in the shell variable
        shell=$(echo "$line" | awk -F: '{print $7}')
        # If the shell variable is matches any of the 2 shell types print the userName
        if [ "$shell" = "$shell_type_1" ] || [ "$shell" = "$shell_type_2" ]; then
            user_name=$(echo "$line" | awk -F: '{print $1}')
            echo "$user_name has the shell $shell"
        fi
    done < "$passwd_file_name"
}

function copy_and_replace_passwd() {
    # Check if the file is writable I.E. if we have permission to write files
    if [ -w "$passwd_file_name-modified" ]; then
        # Use the sed command which globally (g) replaces the \/ slash with \\ blackslash (both escaped here) and write to the passwd-modified file
        # sec dmg syntax is 's/find/replace/g' which replaces the find sequence with the replace sequence
        sed 's/\//\\/g' "$passwd_file_name" > "$passwd_file_name-modified"
        echo "File modified successfully."
    else
        echo "You do not have permission to modify the file."
    fi
}

function print_private_ip() {
    private_ip=$(hostname)
    # Print the hostname and private IP address
    echo "Private IP Address: $private_ip"
}

function print_public_ip() {
    # For this I have added the dnsutils package to be able to get the public IP from which we use the dig cmd
    public_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
    echo "Public IP Address: $public_ip"
}

function switch_to_user_john() {
    su - john
}

# Check if the filename is "passwd"
if [ "$(basename "$passwd_file_name")" = "passwd" ]; then
    echo "The filename is 'passwd'."
    
    #################### 1. Print the home directory ####################
    print_home

    #################### 2. List all usernames from the passwd file ####################
    list_usernames

    #################### 3. Count the number of users ####################
    count_users

    #################### 4. Find the home directory of a specific user (prompt to enter the username value) ####################
    print_home_dir_for_user

    #################### 5. List users with specific UID range (e.g. 1000-1010) ####################
    list_users_by_uid

    #################### 6. Find users with standard shells like /bin/bash or /bin/sh ####################
    list_users_by_shell

    #################### 7. Replace the “/” character with “\” character in the entire /etc/passwd file and redirect the content to a new file ####################
    copy_and_replace_passwd

    #################### 8. Print the private IP ####################
    print_private_ip

    #################### 9. Print the public IP ####################
    print_public_ip

    #################### 10. Switch to john user ####################
    switch_to_user_john
    
    #################### 11. Print the home directory ####################
    # Use the script defined earlier
    print_home

else
    echo "The filename is not 'passwd'."
fi

