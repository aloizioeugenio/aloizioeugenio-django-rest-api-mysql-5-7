FROM alpine:3.18
# Set unbuffered output for python

ENV PYTHONUNBUFFERED 1

# Create app directory
WORKDIR /app

# Bundle app source
COPY . .

# Expose port
EXPOSE 8000

# Install Python
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN apk add --virtual build-deps gcc python3-dev musl-dev
RUN apk add --no-cache mysql-dev
RUN apk add --no-cache tzdata
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
RUN pip3 install mysqlclient
RUN pip3 install -r requirements.txt
RUN source venv/bin/activate

# entrypoint to run the django.sh file
# ENTRYPOINT ["/app/django.sh"]

# Executing Django
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# Running the command slepp to keep the container running
CMD ["sleep", "3600"]