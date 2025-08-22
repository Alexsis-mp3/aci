#!/bin/bash

# ACI.dev Coolify Setup Script
# This script helps you set up the required environment variables for Coolify deployment

echo "🚀 ACI.dev Coolify Deployment Setup"
echo "=================================="
echo ""

# Frontend Environment Variables
echo "📋 Frontend Environment Variables (set these in Coolify):"
echo ""
echo "# API Configuration"
echo "NEXT_PUBLIC_API_URL=https://your-backend-domain.com"
echo "NEXT_PUBLIC_DEV_PORTAL_URL=https://your-frontend-domain.com"
echo "NEXT_PUBLIC_ENVIRONMENT=production"
echo ""
echo "# Authentication (PropelAuth)"
echo "NEXT_PUBLIC_AUTH_URL=https://your-propelauth-instance.propelauthtest.com"
echo ""

# Backend Environment Variables
echo "🔧 Backend Environment Variables (set these in Coolify):"
echo ""
echo "# Database"
echo "DATABASE_URL=postgresql://username:password@host:port/database"
echo "DATABASE_URL_WITH_SSL=postgresql://username:password@host:port/database?sslmode=require"
echo ""
echo "# Authentication"
echo "SERVER_PROPELAUTH_AUTH_URL=https://your-propelauth-instance.propelauthtest.com"
echo "SERVER_PROPELAUTH_API_KEY=your_propelauth_api_key"
echo "SERVER_SVIX_SIGNING_SECRET=your_svix_signing_secret"
echo ""
echo "# OpenAI"
echo "SERVER_OPENAI_API_KEY=your_openai_api_key"
echo ""
echo "# Application"
echo "SERVER_SIGNING_KEY=your_signing_key"
echo "SERVER_ACI_DNS=your-domain.com"
echo "SERVER_DEV_PORTAL_URL=https://your-frontend-domain.com"
echo ""

# Build Arguments
echo "🔨 Frontend Build Arguments (set these in Coolify):"
echo ""
echo "NEXT_PUBLIC_API_URL=https://your-backend-domain.com"
echo "NEXT_PUBLIC_DEV_PORTAL_URL=https://your-frontend-domain.com"
echo "NEXT_PUBLIC_ENVIRONMENT=production"
echo "NEXT_PUBLIC_AUTH_URL=https://your-propelauth-instance.propelauthtest.com"
echo ""

echo "📝 Next Steps:"
echo "1. Set up PropelAuth at https://propelauth.com/"
echo "2. Create a PostgreSQL database with pgvector extension"
echo "3. Configure the environment variables above in Coolify"
echo "4. Deploy backend first, then frontend"
echo "5. Run database migrations: alembic upgrade head"
echo ""
echo "📚 For detailed instructions, see COOLIFY_DEPLOYMENT.md"
