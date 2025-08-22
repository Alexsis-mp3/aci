# Quick Fix for Coolify Deployment

## The Problem

The deployment is failing because the frontend build process requires environment variables to be available during build time, specifically `NEXT_PUBLIC_AUTH_URL` for PropelAuth initialization.

## The Solution

### 1. Set Build Arguments in Coolify

In your Coolify project settings, add these **Build Arguments** for the frontend:

```bash
NEXT_PUBLIC_API_URL=https://your-backend-domain.com
NEXT_PUBLIC_DEV_PORTAL_URL=https://your-frontend-domain.com
NEXT_PUBLIC_ENVIRONMENT=production
NEXT_PUBLIC_AUTH_URL=https://your-propelauth-instance.propelauthtest.com
```

### 2. Set Environment Variables

Also set these as **Environment Variables** in Coolify:

```bash
# Frontend Environment Variables
NEXT_PUBLIC_API_URL=https://your-backend-domain.com
NEXT_PUBLIC_DEV_PORTAL_URL=https://your-frontend-domain.com
NEXT_PUBLIC_ENVIRONMENT=production
NEXT_PUBLIC_AUTH_URL=https://your-propelauth-instance.propelauthtest.com

# Backend Environment Variables
DATABASE_URL=postgresql://username:password@host:port/database
SERVER_PROPELAUTH_AUTH_URL=https://your-propelauth-instance.propelauthtest.com
SERVER_PROPELAUTH_API_KEY=your_propelauth_api_key
SERVER_OPENAI_API_KEY=your_openai_api_key
SERVER_SIGNING_KEY=your_signing_key
```

### 3. Dockerfile Configuration

The updated `frontend/Dockerfile` now includes build arguments that will be passed during the build process:

```dockerfile
# Build arguments for environment variables
ARG NEXT_PUBLIC_API_URL
ARG NEXT_PUBLIC_DEV_PORTAL_URL
ARG NEXT_PUBLIC_ENVIRONMENT
ARG NEXT_PUBLIC_AUTH_URL
ARG NEXT_PUBLIC_VERCEL_ANALYTICS_ID
ARG NEXT_PUBLIC_SENTRY_DSN

# Set environment variables for build
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}
ENV NEXT_PUBLIC_DEV_PORTAL_URL=${NEXT_PUBLIC_DEV_PORTAL_URL}
ENV NEXT_PUBLIC_ENVIRONMENT=${NEXT_PUBLIC_ENVIRONMENT}
ENV NEXT_PUBLIC_AUTH_URL=${NEXT_PUBLIC_AUTH_URL}
ENV NEXT_PUBLIC_VERCEL_ANALYTICS_ID=${NEXT_PUBLIC_VERCEL_ANALYTICS_ID}
ENV NEXT_PUBLIC_SENTRY_DSN=${NEXT_PUBLIC_SENTRY_DSN}
```

### 4. Fallback for Missing Variables

The layout component now has a fallback for missing `NEXT_PUBLIC_AUTH_URL`:

```typescript
<RequiredAuthProvider authUrl={process.env.NEXT_PUBLIC_AUTH_URL || 'https://placeholder.propelauthtest.com'}>
```

## Steps to Deploy

1. **Set up PropelAuth**:
   - Go to [PropelAuth](https://propelauth.com/)
   - Create a new project
   - Note your Auth URL and API Key

2. **Configure Coolify**:
   - Add the build arguments listed above
   - Add the environment variables listed above
   - Use `frontend/Dockerfile` for the frontend
   - Use `backend/Dockerfile.prod` for the backend

3. **Deploy Backend First**:
   - Deploy the backend service
   - Ensure it's running and healthy

4. **Deploy Frontend**:
   - Deploy the frontend service
   - The build should now succeed

## Testing

After deployment, test these endpoints:

- **Frontend**: `https://your-frontend-domain.com/`
- **Backend Health**: `https://your-backend-domain.com/v1/health`

## Need Help?

Run the setup script for a quick reference:

```bash
./scripts/setup-coolify.sh
```

Or check the detailed guide: `COOLIFY_DEPLOYMENT.md`
