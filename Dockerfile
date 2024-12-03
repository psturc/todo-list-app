# Base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy application files
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r robot_requirements.txt

# Expose the application's port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
