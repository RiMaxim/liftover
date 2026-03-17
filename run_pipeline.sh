#!/bin/bash

# Создаем необходимые директории
mkdir -p data results

# Проверяем наличие обязательных файлов (только VCF и header)
required_files=(
    "data/test.vcf"
    "data/header_GCA_030864155.1.txt"
)

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Ошибка: Файл $file не найден!"
        echo "Пожалуйста, поместите test.vcf и header_GCA_030864155.1.txt в папку data/"
        exit 1
    fi
done

# Сборка образов
echo "=== Сборка Docker образов ==="
docker-compose build

# Запуск minimap2 (скачает геномы и выполнит выравнивание)
echo "=== Запуск minimap2 контейнера ==="
echo "Будут скачаны геномы из NCBI (это может занять некоторое время)..."
docker-compose up minimap2

if [ $? -eq 0 ]; then
    echo "=== minimap2 успешно завершен ==="
    
    # Запуск paftools
    echo "=== Запуск paftools контейнера ==="
    docker-compose up paftools
    
    if [ $? -eq 0 ]; then
        echo "=== Пайплайн успешно завершен! ==="
        echo "Результаты сохранены в директории results/"
        echo "Скачанные геномы сохранены в Docker томе 'genomes_volume'"
    else
        echo "Ошибка при выполнении paftools"
        exit 1
    fi
else
    echo "Ошибка при выполнении minimap2"
    exit 1
fi

# Остановка контейнеров
docker-compose down
