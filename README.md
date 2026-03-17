# 🧬 Genomic LiftOver Pipeline

Docker-based pipeline for transferring genomic variant coordinates between different genome assemblies using minimap2 and paftools.js.

## 📋 Overview

This pipeline performs liftOver of VCF variants from one genome assembly to another through genome alignment and coordinate conversion.

## 🔧 Components

- **minimap2**: Genome alignment and coordinate conversion
- **paftools.js**: VCF liftover utility
- **Two Docker images**: Separate containers for alignment and liftover steps

## 📁 Structure

.
├── data/ # Input files (VCF, header)
├── results/ # Output files
├── minimap2/ # Alignment container
│ ├── Dockerfile
│ └── run_minimap2.sh
├── paftools/ # Liftover container
│ ├── Dockerfile
│ └── run_paftools.sh
├── docker-compose.yml
└── run_pipeline.sh
