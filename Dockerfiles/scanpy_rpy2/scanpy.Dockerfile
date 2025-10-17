# Use a base image with Python
FROM python:3.9.23-bookworm

# Avoid writing .pyc files + force flush stdout
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies + R
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    ca-certificates \
    libopenblas-dev \
    liblapack-dev \
    gfortran \
    pkg-config \
    libhdf5-dev \
    procps \
    r-base \
    r-base-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R packages via Rscript
RUN Rscript -e "install.packages(c('BiocManager'), repos='https://cloud.r-project.org')" && \
    Rscript -e "BiocManager::install(c('scran', 'scater', 'SingleCellExperiment', 'BiocParallel'), ask=FALSE)"

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies (ensure rpy2 builds against installed R)
RUN pip install --no-cache-dir -r requirements.txt

# Default command
CMD ["python3"]

