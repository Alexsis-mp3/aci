#!/bin/bash

echo "Starting ACI Backend..."
echo "Environment: $SERVER_ENVIRONMENT"
echo "Database URL: $DATABASE_URL"
echo "Python path: $PYTHONPATH"

# Check if required environment variables are set
if [ -z "$SERVER_ENVIRONMENT" ]; then
    echo "ERROR: SERVER_ENVIRONMENT is not set"
    exit 1
fi

if [ -z "$DATABASE_URL" ]; then
    echo "ERROR: DATABASE_URL is not set"
    exit 1
fi

if [ -z "$SERVER_PROPELAUTH_AUTH_URL" ]; then
    echo "ERROR: SERVER_PROPELAUTH_AUTH_URL is not set"
    exit 1
fi

echo "All required environment variables are set"

# Start the application
exec uvicorn aci.server.main:app --host 0.0.0.0 --port 8000 --log-level debug
