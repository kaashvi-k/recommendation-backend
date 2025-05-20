# Use official Node image as base
FROM node:18

# Install Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Install Python dependencies
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Set working directory
WORKDIR /app

# Copy Node backend files
COPY package*.json ./
RUN npm install

COPY . .

# Expose the port your app listens on
EXPOSE 2000

# Start your Node server
CMD ["node", "server.js"]
