FROM python:3.9-slim

#work directory
WORKDIR /app

#copy requirements file
COPY requirements.txt .

# run dependance config
RUN pip install --no-cache-dir -r requirements.txt

#copie file in work directory
COPY service/ ./service/

#create user
RUN useradd --uid 100 theia && chown -R theia /app
USER theia

#export port
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]