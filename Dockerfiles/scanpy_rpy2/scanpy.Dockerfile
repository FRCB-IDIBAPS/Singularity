# Use a base image with Python
FROM python:3.9-slim-bookworm

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

# -------------------------------
# Install R dependencies and system libs
# -------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcairo2-dev \
    libxt-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    libfreetype6-dev \
    libfontconfig1-dev\
    libharfbuzz-dev \
    libfribidi-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R + Bioconductor packages
RUN Rscript -e "install.packages(c('BiocManager','Matrix'), repos='https://cloud.r-project.org', lib='/usr/local/lib/R/site-library')" && \
    Rscript -e "BiocManager::install(c('scran','scater','SingleCellExperiment','BiocParallel','scuttle'), ask=FALSE, update=TRUE, lib='/usr/local/lib/R/site-library')" && \
    Rscript -e "cat('Installed packages:', installed.packages()[,'Package'])" && \
    Rscript -e "options(warn=2); library(scran); library(scater); library(SingleCellExperiment); library(BiocParallel)"

   
RUN echo '.libPaths("/usr/local/lib/R/site-library")' >> /usr/lib/R/etc/Rprofile.site

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies (ensure rpy2 builds against installed R)
RUN pip install --no-cache-dir -r requirements.txt

# Default command
CMD ["python3"]

