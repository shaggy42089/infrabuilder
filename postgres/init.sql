-- Create the "db_user" user with a password
 CREATE USER db_user WITH PASSWORD 'db_password';
-- Grant all privileges on existing tables to "db_user"
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO db_user;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO db_user;

ALTER DEFAULT PRIVILEGES FOR ROLE your_username IN SCHEMA public
GRANT SELECT, DELETE, UPDATE ON TABLES TO db_user;
