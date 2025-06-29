# backend/Dockerfile
FROM node:18

# Set working directory inside the container
WORKDIR /app

# Copy only package.json first
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Expose port (match with server.js)
EXPOSE 3000

# Start with nodemon for hot reload
CMD ["npm", "run", "dev"]
