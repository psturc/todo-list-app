# Base image
FROM python:3.9-slim

ARG SEALIGHTS_AGENT_TOKEN

# Set the working directory
WORKDIR /app

# Copy application files
COPY . /app

# Save the Sealights token to a file
#RUN echo "${SEALIGHTS_AGENT_TOKEN}" > /app/token.txt

# Create a timestamp to use for unique build_id
# RUN export TIMESTAMP=$(date +"%Y:%m:%d:%H:%M:%S") && \
#     echo "$TIMESTAMP" > /timestamp.txt
# RUN TIMESTAMP=$(cat /timestamp.txt) && \
#     echo "build name = todo-list-$TIMESTAMP"

# Install dependencies
# RUN pip install sealights-python-agent
# RUN pip install --no-cache-dir -r requirements.txt
# RUN pip install --no-cache-dir -r robot_requirements.txt

# RUN TIMESTAMP=$(cat /timestamp.txt) && \
#     sl-python config --appname Python-App-Todo-List --branchname sealights --buildname "PATL-$TIMESTAMP" --exclude '/app/tests/*' --workspacepath /app --tokenfile /app/token.txt
# RUN sl-python scan  --buildsessionidfile buildSessionId.txt --scm git --tokenfile /app/token.txt
# RUN sl-python start --buildsessionidfile buildSessionId.txt --teststage pytest --tokenfile /app/token.txt
# RUN sl-python start --buildsessionidfile buildSessionId.txt --teststage Robot_Tests --tokenfile /app/token.txt

# RUN sl-python pytest --buildsessionidfile buildSessionId.txt --teststage pytest --tokenfile /app/token.txt
# RUN sl-python uploadreports --buildsessionidfile buildSessionId.txt --teststage pytest --reportfile "output.xml" --tokenfile /app/token.txt
# RUN sl-python end --buildsessionidfile buildSessionId.txt --teststage pytest --tokenfile /app/token.txt

# RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
# RUN git clone https://github.com/Sealights/sealights-integration-examples.git
# RUN pip install sealights-integration-examples/robot-custom-integration/.

# Expose the application's port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
