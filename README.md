📋 Overview

This pipeline performs liftOver of VCF variants from one genome assembly to another through genome alignment and coordinate conversion.

🔧 Components

minimap2: Genome alignment and coordinate conversion
paftools.js: VCF liftover utility
Two Docker images: Separate containers for alignment and liftover steps

📁 Structure
.
├── data/               # Input files (VCF, header)
├── results/            # Output files
├── minimap2/          # Alignment container
│   ├── Dockerfile
│   └── run_minimap2.sh
├── paftools/          # Liftover container
│   ├── Dockerfile
│   └── run_paftools.sh
├── docker-compose.yml
└── run_pipeline.sh

🚀 Usage
Prepare input files in data/:
test.vcf - variants to transfer
header_GCA_030864155.1.txt - target assembly header
Run pipeline:

bash
./run_pipeline.sh
Get results from results/:

test.lifted.vcf - successfully transferred variants
test.nolifted.vcf - variants that couldn't be transferred

📦 Requirements
Docker
Docker Compose

⚙️ Versions
minimap2: 2.24
Ubuntu: 22.04
k8: 0.2.6 (included in minimap2)

📊 Pipeline Steps
Download reference genomes from NCBI
Align genomes with minimap2
Convert coordinates with paftools.js
Generate lifted VCF files

📝 Notes
Genomes are cached in Docker volume for subsequent runs
Supports ARM64 (Apple Silicon) and x86_64 architectures
Tested with soybean genome assemblies
