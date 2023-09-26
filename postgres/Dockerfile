# Use the official PostgreSQL image as a base
FROM postgres:latest

# Set environment variables for PostgreSQL
ENV POSTGRES_DB=${POSTGRES_DB}
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

# Expose PostgreSQL's default port
EXPOSE 5432

# Create a user with lesser privileges
COPY init.sql /docker-entrypoint-initdb.d/
