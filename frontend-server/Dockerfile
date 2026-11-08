
FROM node:18-alpine AS builder
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci --silent

# Copy source
COPY . .

# Increase Node memory for Vite build
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Build the application
RUN npm run build

# Production image
FROM node:18-alpine
WORKDIR /app
RUN npm i -g serve --silent
COPY --from=builder /app/dist ./dist
EXPOSE 3000
CMD ["serve","-s","dist","-l","3000"]

