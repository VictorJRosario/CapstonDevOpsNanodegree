FROM python:3.7.3-stretch

## Step 1:
# Create a working directory

WORKDIR /app

## Step 2:
# Copy source code to working directory

COPY . app.py /app/
COPY . model_data /app/

## Step 3:
# Install packages from requirements.txt
# hadolint ignore=DL3013

RUN pip install pip==20.0.2
RUN pip install -r requirements.txt

## Step 4:
# Set a default port
ARG PORT=7777

## Step 5:
# Expose port 80

EXPOSE $PORT

## Step 6:
# Run app.py at container launch

CMD ["python", "app.py"]

## Re-used file from last project