FROM python:3.8-slim

ENV PYTHONBUFFERED=1

WORKDIR /app

COPY requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

EXPOSE 5000

# CMD ["python", "run.py"]

# Using gunicorn for production
CMD ["gunicorn", "--log-level=debug", "--access-logfile", "-", "--error-logfile", "-", "-b", "0.0.0.0:5000", "app:app"]