# Use an official Python Image
FROM python:3.9-slim

WORKDIR /my-app
COPY my-app/ /my-app/

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80
CMD ["python", "my-app.py"]

