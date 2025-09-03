# Singularity Container Project

This repository stores **Dockerfiles** used to build Docker images that will later be converted to **Singularity images** for HPC (Nord4) environment.  

The workflow allows you to:  
1. **Develop and test locally** using Docker  
2. **Convert Docker images to Singularity images**  
3. **Transfer the Singularity images to the HPC** for running processes in a reproducible environment  

---

## 📂 Repository Structure
```
singularity-project/
│
├── Dockerfiles/           # Directory with all Dockerfiles for different environments
│   ├── scanpy.Dockerfile
│   ├── base.Dockerfile
│   └── ...
│
├── Singularity-recipes/   # Optional: Singularity definition files if needed
│
├── README.md              # Project documentation
└── requirements.txt       # Example: Python dependencies if needed
```

---

## 🚀 Getting Started

### 1. Build Docker Image
Inside the project folder, choose the Dockerfile you want and run:
```bash
docker build -t my-image -f dockerfiles/scanpy.Dockerfile .
```

### 2. Convert Docker Image to Singularity Image
Use `singularity build` to convert:
```bash
singularity build my-image.sif docker-daemon://my-image:latest
```
- `my-image.sif` → final Singularity image  
- `my-image:latest` → Docker image tag  

### 3. Run Container on HPC
```bash
singularity exec my-image.sif python myscript.py
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
- Test Docker images locally before converting to Singularity.  

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

## 📄 License

This project is licensed under [MIT License](LICENSE) (or your preferred license).  
