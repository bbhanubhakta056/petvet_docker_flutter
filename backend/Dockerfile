FROM node:18

WORKDIR /app

# Copy package.json before rest (for Docker cache)
COPY package.json ./

# Install dependencies
RUN npm install

# Now copy the rest of the app
COPY . .

EXPOSE 3000
CMD ["node", "index.js"]
