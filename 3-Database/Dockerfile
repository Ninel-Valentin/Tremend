# Use the MySQL base image
FROM mysql:latest

# Set environment variables root password and the name of the database for MySQL
ENV MYSQL_ROOT_PASSWORD="password123"
ENV MYSQL_DATABASE="CompanyDB"

# Copy the create admin sql script into the container from the current directory
COPY CreateAdmin.sql /docker-entrypoint-initdb.d/

# Copy the company.sql sql script into the container from docker-entrypoint-initdb.b/ directory which executes scripts against the MYSQL_DATABASE db after it is created
COPY Company.sql /docker-entrypoint-initdb.d/

# Copy the compute average sql script into the container from the current directory
COPY ComputeAvgPerDepartment.sql /docker-entrypoint-initdb.d/

# Make sure the scripts have the right permissions
RUN chmod 755 /docker-entrypoint-initdb.d/*.sql
