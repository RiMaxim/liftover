#!/bin/bash
set -e

echo "=== Запуск minimap2 для выравнивания геномов ==="
echo "Версия minimap2: $(minimap2 --version)"

mkdir -p /genomes
cd /genomes

echo "Скачивание геномов из NCBI..."

# Скачивание геномов (ваши ссылки)
if [ ! -f "GCA_030864155.1_ASM3086415v1_genomic.fna" ]; then
    echo "Скачивание GCA_030864155.1..."
    wget -q --show-progress https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/030/864/155/GCA_030864155.1_ASM3086415v1/GCA_030864155.1_ASM3086415v1_genomic.fna.gz
    gunzip GCA_030864155.1_ASM3086415v1_genomic.fna.gz
fi

if [ ! -f "GCF_000004515.6_Glycine_max_v4.0_genomic.fna" ]; then
    echo "Скачивание GCF_000004515.6..."
    wget -q --show-progress https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/004/515/GCF_000004515.6_Glycine_max_v4.0/GCF_000004515.6_Glycine_max_v4.0_genomic.fna.gz
    gunzip GCF_000004515.6_Glycine_max_v4.0_genomic.fna.gz
fi

# Выравнивание
/opt/minimap2-2.24_x64-linux/minimap2 -x asm5 --cs -c -t 60 \
    /genomes/GCA_030864155.1_ASM3086415v1_genomic.fna \
    /genomes/GCF_000004515.6_Glycine_max_v4.0_genomic.fna \
    > /results/GCA_030864155.1_VS_GCF_000004515.6.paf

# Сортировка
sort -k6,6 -k8,8n /results/GCA_030864155.1_VS_GCF_000004515.6.paf \
    > /results/GCA_030864155.1_VS_GCF_000004515.6.sorted.paf

echo "=== Выравнивание завершено ==="