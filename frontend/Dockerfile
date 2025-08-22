# Stage 1: Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

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

# Build the application
RUN npm run build

# Stage 2: Runtime stage
FROM node:20-alpine AS runner

WORKDIR /app

# Install necessary packages
RUN apk add --no-cache curl

# Copy package files
COPY package*.json ./
RUN npm ci --production --omit=dev

# Copy built application
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/next.config.ts ./

# Create directories for persistent storage
RUN mkdir -p /app/data

# Expose port
EXPOSE 3000

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --retries=5 CMD curl -f http://127.0.0.1:3000/ || exit 1

# Start the application
CMD ["npm", "start"]
