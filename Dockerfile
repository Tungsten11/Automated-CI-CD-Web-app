# Use an official Python Image
FROM python:3.11-slim-bookworm

WORKDIR /app
COPY app/ /app/

RUN apt-get update && apt-get upgrade -y && apt-get clean
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80
CMD ["python", "app.py"]

