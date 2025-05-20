# Use official Node.js image as base
FROM node:18

# Install Python 3, pip, and virtualenv support
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Create a Python virtual environment
RUN python3 -m venv /opt/venv

# Activate the virtual environment by adding it to PATH
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip inside the virtual environment
RUN pip install --upgrade pip

# Copy Python dependencies file and install them inside venv
COPY requirements.txt .
RUN pip install -r requirements.txt

# Set working directory for Node app
WORKDIR /app

# Copy Node.js dependency definitions and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of your app files
COPY . .

# Expose the port your app will run on
EXPOSE 2000

# Start your Node.js server
CMD ["node", "server.js"]
