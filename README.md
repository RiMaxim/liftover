# 🧬 Genomic LiftOver Pipeline

Docker-based pipeline for transferring genomic variant coordinates between different genome assemblies using minimap2 and paftools.js.

## 📋 Overview

This pipeline performs liftOver of VCF variants from one genome assembly to another through genome alignment and coordinate conversion.

## 🔧 Components

- **minimap2**: Genome alignment and coordinate conversion
- **paftools.js**: VCF liftover utility
- **Two Docker images**: Separate containers for alignment and liftover steps

## 🚀 Usage

1. **Prepare input files** in `data/`:
   - `test.vcf` - variants to transfer
   - `header_GCA_030864155.1.txt` - target assembly header

2. **Run pipeline**:
   ```bash
   ./run_pipeline.sh
