# Prerequisites

- Install git https://github.com/git-guides/install-git
- Install docker https://docs.docker.com/engine/install/

# How to install
Open a terminal and follow the instructions:

### Navigate to the directory you want to store the app
```cd MySqlDir```

- If there is no such directory you can use the following cmd to create one:
```mkdir MySqlDir```

### Clone the GitHub repository
```git clone https://github.com/Ninel-Valentin/Tremend.git```

### Navigate to the directory where the Dockerfile is located
```cd Tremend/3-Database```

### Build the Docker image 
```docker build -t my-sql-img . ```

# How to run

### Run the Docker container 
```docker run -d --name my-sql-img -e MYSQL_ROOT_PASSWORD=password123 -e MYSQL_DATABASE=CompanyDB -v mysql_data:/var/lib/mysql -p 3306:3306 my-sql-img:latest```

### Open a bash instance
```docker exec -it my-sql-img bash```

### Start SQL mode 
```mysql -u root -p```
- Enter the password of the database



# Development 

### Issues encountered during development

- There was a bug in the Company.sql script where the 40th user had the integer value of department a string "Company"
  - Replaced it with the appropriate index of the department (7)