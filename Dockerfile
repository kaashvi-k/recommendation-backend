# Use official Node.js image as base
FROM node:18

# Install Python 3, pip, virtualenv, and build tools required for many Python packages
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv \
    build-essential gcc python3-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a Python virtual environment
RUN python3 -m venv /opt/venv

# Activate the virtual environment by adding it to PATH
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip inside the virtual environment
RUN pip install --upgrade pip

# Set working directory early for caching purposes
WORKDIR /app

# Copy Python dependencies file and install them inside the virtual environment
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy Node.js dependency definitions and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of your app files
COPY . .

# Expose the port your app will run on
EXPOSE 2000

# Start your Node.js server (update if your start command is different)
CMD ["node", "server.js"]
