# Use an official Node runtime as a parent image
FROM node:20.10.0

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Bundle app source
COPY . .

# Build your Next.js app
RUN npm run build

# Your Next.js app listens on port 3000, make sure your container does too
EXPOSE 3000

# Command to run your app
CMD ["npm", "start"]
