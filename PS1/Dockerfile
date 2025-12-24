# Use a lightweight base image
FROM ubuntu:latest

# Update and install prerequisites
RUN apt-get update && apt-get install -y \
    fortune-mod \
    cowsay \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Add cowsay and fortune to the PATH
ENV PATH="/usr/games:${PATH}"

# Set the working directory
WORKDIR /app

# Copy the application script
COPY wisecow.sh .

# Make the script executable
RUN chmod +x wisecow.sh

# Expose the communication port
EXPOSE 4499

# Healthcheck to verify the service is running
HEALTHCHECK --interval=30s --timeout=3s \
    CMD nc -z localhost 4499 || exit 1

# Run the script
CMD ["./wisecow.sh"]
