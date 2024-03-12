CREATE USER 'Admin'@'%' 
    IDENTIFIED BY 'AdminPass123';
GRANT ALL PRIVILEGES 
    ON company.*
    TO 'Admin'@'%';
FLUSH PRIVILEGES;
