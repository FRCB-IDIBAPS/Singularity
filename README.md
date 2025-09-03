# Singularity Container Project

This repository stores **Dockerfiles** used to build Docker images that will later be converted to **Singularity images** for HPC (Nord4) environment.  

The workflow allows you to:  
1. **Develop and test locally** using Docker  
2. **Convert Docker images to Singularity images**  
3. **Transfer the Singularity images to the HPC** for running processes in a reproducible environment  

---

## 📂 Repository Structure
```
singularity/
│
├── Dockerfiles/                # Directory with all Dockerfiles for different environments
│   ├── scanpy/
│   │   ├── scanpy.Dockerfile
│   │   └── requirements.txt    # Example: Python dependencies if needed
│   └── ...
│
├── Singularity-recipes/        # Singularity definition files
│   ├── R-tidyverse/
│   │   └── Singularity
│   └── ...
│
└── README.md                   # Project documentation
```

---

## 🚀 Getting Started

### 1. Generating images from Dockerfile
#### 1.1. Build Docker Image
Inside the project folder, choose the Dockerfile you want and run:
```bash
cd Dockerfiles/[env-name]/
docker build -t my-image -f scanpy.Dockerfile .
```

#### 1.2. Convert Docker Image to Singularity Image
Use `singularity build` to convert:
```bash
singularity build my-image.sif docker-daemon://my-image:latest
```
- `my-image.sif` → final Singularity image  
- `my-image:latest` → Docker image tag  

### 2. Generating images from Singularity definition files
#### 2.1. Build Singularity Image
Inside the project folder, choose the Dockerfile you want and run:
```bash
cd Singularity-recipes/[img-name]/
sudo apptainer build my-image.img Singularity
```

#### 3. Run Container on HPC
```bash
# In the HPC environment
singularity exec my-image.[sif/img] python myscript.py
```

---

## 🛠 Requirements

- **Docker** installed locally for building images  
- **Singularity** installed on your system or accessible on the HPC  
- **Internet access** to install dependencies while building images  

---

## 📝 Tips & Best Practices

- Keep Dockerfiles modular (one environment per file).  
- Always pin library versions in `requirements.txt` for reproducibility.  
- [Optional] Test Docker images locally before converting to Singularity.  

---

## 🤝 Contributing

1. Fork the repository  
2. Create a new branch:  
   ```bash
   git checkout -b feature/my-feature
   ```
3. Commit your changes and push  
4. Submit a merge request  

---
