# Base image
FROM python:3.9-slim

ARG SEALIGHTS_AGENT_TOKEN
ENV SEALIGHTS_AGENT_TOKEN=$(oc describe secret sealights-token --output=yaml)

# Set the working directory
WORKDIR /app

# Copy application files
COPY . /app

# Save the Sealights token to a file
RUN echo "${SEALIGHTS_AGENT_TOKEN}" > /app/token.txt

# Create a timestamp to use for unique build_id
RUN export TIMESTAMP=$(date +"%Y%m%d%H%M%S") && \
    echo "$TIMESTAMP" > /timestamp.txt
RUN TIMESTAMP=$(cat /timestamp.txt) && \
    echo "build id = todo-list-$TIMESTAMP"

# Install dependencies
RUN pip install sealights-python-agent
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r robot_requirements.txt

RUN TIMESTAMP=$(cat /timestamp.txt) && \
    sl-python config --appname TODO-LIST --branchname main --buildname "todo-list-$TIMESTAMP" --exclude "*venv*","tests/*" --workspacepath /app --tokenfile /app/token.txt
RUN sl-python scan  --buildsessionidfile buildSessionId.txt --scm git --tokenfile /app/token.txt

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/Sealights/sealights-integration-examples.git
RUN pip install sealights-integration-examples/robot-custom-integration/.

# Expose the application's port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
