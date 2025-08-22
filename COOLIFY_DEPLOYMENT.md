# ACI.dev Coolify Deployment Guide

This guide explains how to deploy ACI.dev on Coolify, including both the frontend and backend components.

## Overview

ACI.dev consists of two main components:
1. **Frontend**: Next.js developer portal (port 3000)
2. **Backend**: FastAPI server (port 8000)

## Prerequisites

Before deploying, you'll need:

1. **PropelAuth Account**: Set up authentication at [PropelAuth](https://propelauth.com/)
2. **Database**: PostgreSQL with pgvector extension
3. **Environment Variables**: Configure all required environment variables

## Deployment Steps

### 1. Frontend Deployment

#### Environment Variables Required

Set these environment variables in your Coolify project:

```bash
# API Configuration
NEXT_PUBLIC_API_URL=https://your-backend-domain.com
NEXT_PUBLIC_DEV_PORTAL_URL=https://your-frontend-domain.com
NEXT_PUBLIC_ENVIRONMENT=production

# Authentication (PropelAuth)
NEXT_PUBLIC_AUTH_URL=https://your-propelauth-instance.propelauthtest.com

# Optional: Analytics
NEXT_PUBLIC_VERCEL_ANALYTICS_ID=your_vercel_analytics_id
NEXT_PUBLIC_SENTRY_DSN=your_sentry_dsn
```

#### Build Arguments

In Coolify, set these build arguments for the frontend:

```bash
NEXT_PUBLIC_API_URL=https://your-backend-domain.com
NEXT_PUBLIC_DEV_PORTAL_URL=https://your-frontend-domain.com
NEXT_PUBLIC_ENVIRONMENT=production
NEXT_PUBLIC_AUTH_URL=https://your-propelauth-instance.propelauthtest.com
```

#### Dockerfile Location
- **Path**: `frontend/Dockerfile`
- **Port**: 3000

### 2. Backend Deployment

#### Environment Variables Required

Set these environment variables in your Coolify project:

```bash
# Database
DATABASE_URL=postgresql://username:password@host:port/database
DATABASE_URL_WITH_SSL=postgresql://username:password@host:port/database?sslmode=require

# Authentication
SERVER_PROPELAUTH_AUTH_URL=https://your-propelauth-instance.propelauthtest.com
SERVER_PROPELAUTH_API_KEY=your_propelauth_api_key
SERVER_SVIX_SIGNING_SECRET=your_svix_signing_secret

# OpenAI
SERVER_OPENAI_API_KEY=your_openai_api_key

# Application
SERVER_SIGNING_KEY=your_signing_key
SERVER_ACI_DNS=your-domain.com
SERVER_DEV_PORTAL_URL=https://your-frontend-domain.com

# Optional: Stripe (for billing)
SERVER_STRIPE_SECRET_KEY=your_stripe_secret_key
SERVER_STRIPE_WEBHOOK_SIGNING_SECRET=your_stripe_webhook_secret

# Optional: Logging
LOGFIRE_WRITE_TOKEN=your_logfire_token
```

#### Dockerfile Location
- **Path**: `backend/Dockerfile.prod`
- **Port**: 8000

## Database Setup

### PostgreSQL with pgvector

Your PostgreSQL database must have the pgvector extension installed:

```sql
CREATE EXTENSION IF NOT EXISTS vector;
```

### Database Migration

After the backend is deployed, you'll need to run database migrations. You can do this by:

1. Connecting to your backend container
2. Running: `alembic upgrade head`

## PropelAuth Configuration

### 1. Create PropelAuth Project

1. Go to [PropelAuth](https://propelauth.com/) and create a new project
2. Note down your Auth URL and API Key

### 2. Configure Webhooks

Set up webhooks in PropelAuth pointing to your backend:

```
https://your-backend-domain.com/v1/webhooks/auth/user-created
```

### 3. Update Environment Variables

Update your backend environment variables with the PropelAuth credentials.

## Deployment Order

1. **Deploy Backend First**: The frontend depends on the backend API
2. **Configure Database**: Ensure PostgreSQL is running with pgvector
3. **Run Migrations**: Apply database schema changes
4. **Deploy Frontend**: Deploy the Next.js application
5. **Test Integration**: Verify both services are communicating

## Troubleshooting

### Common Issues

#### 1. Frontend Build Fails with "Invalid authUrl"

**Cause**: Missing `NEXT_PUBLIC_AUTH_URL` environment variable during build
**Solution**: Ensure all build arguments are set in Coolify

#### 2. Backend Can't Connect to Database

**Cause**: Incorrect `DATABASE_URL` or missing pgvector extension
**Solution**: Verify database connection string and install pgvector

#### 3. Authentication Not Working

**Cause**: Mismatched PropelAuth configuration between frontend and backend
**Solution**: Ensure both services use the same PropelAuth project

#### 4. CORS Errors

**Cause**: Frontend and backend domains not properly configured
**Solution**: Update `SERVER_DEV_PORTAL_URL` in backend environment variables

### Health Checks

- **Frontend**: `http://your-domain:3000/`
- **Backend**: `http://your-domain:8000/v1/health`

## Production Considerations

### Security

1. **Use HTTPS**: Configure SSL certificates for both frontend and backend
2. **Environment Variables**: Never commit sensitive environment variables
3. **Database Security**: Use strong passwords and restrict database access

### Performance

1. **Database Indexing**: Ensure proper indexes on frequently queried columns
2. **Caching**: Consider implementing Redis for session storage
3. **CDN**: Use a CDN for static assets

### Monitoring

1. **Logs**: Monitor application logs for errors
2. **Metrics**: Set up monitoring for database performance
3. **Alerts**: Configure alerts for service downtime

## Support

If you encounter issues:

1. Check the [ACI.dev documentation](https://aci.dev/docs)
2. Join the [Discord community](https://discord.com/invite/UU2XAnfHJh)
3. Open an issue on [GitHub](https://github.com/aipotheosis-labs/aci)
