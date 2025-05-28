FROM python:2.7-slim

# Install required system packages
RUN apt-get update && apt-get install -y \
    gcc \
    git \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    python-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone the evaluation script repo
RUN git clone https://github.com/kotfic/i2b2_evaluation_scripts.git .

# Install Python dependencies
# Note: requirements.txt is not present in the repo, so we install manually if needed
RUN pip install -r requirements.txt

# Default command to show usage (can be overridden with docker run args)
ENTRYPOINT ["python", "evaluate.py"]
