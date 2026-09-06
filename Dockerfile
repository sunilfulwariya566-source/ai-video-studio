FROM node:20-bullseye-slim

# Install system dependencies including FFmpeg for video processing
RUN apt-get update && apt-get install -y \
    ffmpeg \
    fonts-freefont-ttf \
    curl \
    jq \
    python3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy application source code
COPY . .

# Build frontend and compile backend
RUN npm run build:client

# Expose server port
EXPOSE 3000

ENV PORT=3000
ENV NODE_ENV=production

# Start autonomous video production factory server
CMD ["npm", "run", "start"]
