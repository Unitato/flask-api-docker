FROM python:3.9

RUN echo 'alias ll="ls -l --color=auto"' >> ~/.bashrc

# Set the working directory
WORKDIR /app

#update os
RUN apt update && apt upgrade -y
RUN apt -y install vim

# Copy the Python requirements file
COPY src/requirements.txt .

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy the Python web API server files
COPY src/api.py .

# Expose port 8080 for the API server
EXPOSE 8080

# Set the entrypoint as the Gunicorn server
ENTRYPOINT ["gunicorn"]

# Set the default command to start the API server using Gunicorn
CMD ["-b", "0.0.0.0:8080", "api:app"]
