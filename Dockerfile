# Base image
FROM registry.access.redhat.com/ubi9/python-39@sha256:6f89c966a1939d3fcd8919f1e823f1794721e68fb3b31388230529ff622eebef

# Set the working directory
WORKDIR /app

# Copy application files
COPY . /app

# # Install dependencies
RUN chmod +x /app/app.py
RUN chown 1000:1000 /app/app.py
RUN chown 1000:1000 /app/
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r robot_requirements.txt

# Expose the application's port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]