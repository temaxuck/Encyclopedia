# Use the Python3.9 image
FROM python:3.9

# Set PROJECT_DIR to current dir
ENV PROJECT_DIR /bin/Encyclopedia

# Expose port
EXPOSE 8080

# Set the working directory to /encyclopedia 
WORKDIR ${PROJECT_DIR}

# Copy the current directory contents into the container at /encyclopedia 
ADD . ${PROJECT_DIR}

# Install the dependencies
# RUN pip install -r requirements.txt
RUN pip install gunicorn


# run the command to start uWSGI
# CMD ["gunicorn", "--config", "gunicorn_config.py", "wsgi:app"]
