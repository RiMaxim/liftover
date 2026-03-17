#!/bin/bash
set -e

echo "=== Запуск paftools.js для liftover ==="

# Проверяем наличие PAF-файла от первого контейнера
if [ ! -f /results/GCA_030864155.1_VS_GCF_000004515.6.sorted.paf ]; then
    echo "Ошибка: PAF-файл не найден! Сначала запустите minimap2 контейнер."
    exit 1
fi

# Шаг 3: BED-файл
echo "=== Шаг 3: BED-файл ==="
grep -v "^#" /data/test.vcf | awk '{print $1"\t"$2-1"\t"$2}' > /results/variants.bed
echo ""

# Шаг 4: liftover
echo "=== Шаг 4: liftover ==="
/opt/minimap2-2.24_x64-linux/k8 /opt/minimap2-2.24_x64-linux/paftools.js liftover \
    /results/GCA_030864155.1_VS_GCF_000004515.6.sorted.paf \
    /results/variants.bed > /results/variants.lifted.bed
echo ""

# Шаг 5: Обработка координат
echo "=== Шаг 5: Обработка координат ==="
awk -F'\t' '{split($4, a, "_"); print a[1]"_"a[2]"|"a[4]"\t"$1"\t"$3}' /results/variants.lifted.bed > /results/tmp
cat /results/variants.bed | awk -F'\t' '{print $1"|"$3}' > /results/tmp2
awk 'NR==FNR{a[$1]=$2"\t"$3; next} {if($1 in a) print a[$1]; else {split($1,b,"|"); print b[1]"\t"b[2]}}' \
    /results/tmp /results/tmp2 > /results/tmp3
echo ""

# Шаг 6: Создание временного файла с данными VCF
echo "=== Шаг 6: Подготовка данных VCF ==="
grep -v "^#" /data/test.vcf | cut -f3- > /results/vcf_data.tmp
echo ""

# Шаг 6: Создание test.nolifted.vcf
echo "=== Шаг 6: Создание test.nolifted.vcf ==="
grep "^#" /data/test.vcf > /results/test.nolifted.vcf
paste /results/tmp3 /results/vcf_data.tmp | grep -v "CP" >> /results/test.nolifted.vcf || true
echo ""



# Шаг 7: Создание test.lifted.vcf
echo "=== Шаг 7: Создание test.lifted.vcf ==="
cat /data/header_GCA_030864155.1.txt > /results/test.lifted.vcf
grep "#CHROM" /data/test.vcf >> /results/test.lifted.vcf
paste /results/tmp3 /results/vcf_data.tmp | grep -v "NC_\|NW_" >> /results/test.lifted.vcf || true
echo ""

# Шаг 8: Очистка
rm /results/tmp /results/tmp2 /results/tmp3 /results/vcf_data.tmp /results/variants.lifted.bed /results/variants.bed /results/GCA_030864155.1_VS_GCF_000004515.6.paf

