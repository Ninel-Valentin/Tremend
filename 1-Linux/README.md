# Prerequisites

- Install git https://github.com/git-guides/install-git
- Install docker https://docs.docker.com/engine/install/

# How to install
Open a terminal and follow the instructions:

### Navigate to the directory you want to store the app
```cd AppDir```

- If there is no such directory you can use the following cmd to create one:
```mkdir AppDir```

### Clone the GitHub repository
```git clone https://github.com/Ninel-Valentin/Tremend.git```

### Navigate to the directory where the Dockerfile is located
```cd Tremend/1-Linux```

### Build the Docker image 
```docker build -t linux_app . ```

# How to run

### Run the Docker container (replace 'container_name' with your desired container name)
```docker run -ti --rm linux_app /bin/bash```

## Output will now be visible in the terminal

# Development 

### Issues encountered during development

- create_large_file had a typo at the moving command (lage_file instead of large_file)
- a bit hard to understand what was requested in the test