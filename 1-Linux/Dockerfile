# Use the Ubuntu base image
FROM ubuntu:latest

# Update package lists and install necessary packages + clean unused packages to shrink image size
RUN apt-get update && apt-get install -y dnsutils \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a new user called "john"
RUN useradd -ms /bin/bash john

# Copy the create_large_file bash script to the image and run it 
COPY create_large_file.sh .
RUN sh create_large_file.sh

# Copy the passwd_check bash script to the image and run it 
COPY passwd_check.sh .
ENTRYPOINT ["/passwd_check.sh"]