FROM ubuntu:22.04

# Фиксируем версии
ENV MINIMAP2_VERSION=2.24

# Устанавливаем зависимости (ДОБАВИЛ bzip2)
RUN apt-get update && apt-get install -y \
    wget \
    make \
    gcc \
    zlib1g-dev \
    samtools \
    bzip2 \
    && rm -rf /var/lib/apt/lists/*

# Скачиваем и устанавливаем minimap2
RUN wget https://github.com/lh3/minimap2/releases/download/v${MINIMAP2_VERSION}/minimap2-${MINIMAP2_VERSION}_x64-linux.tar.bz2 \
    && tar -jxvf minimap2-${MINIMAP2_VERSION}_x64-linux.tar.bz2 \
    && mv minimap2-${MINIMAP2_VERSION}_x64-linux /opt/minimap2-${MINIMAP2_VERSION}_x64-linux \
    && rm minimap2-${MINIMAP2_VERSION}_x64-linux.tar.bz2

# Добавляем в PATH
ENV PATH="/opt/minimap2-${MINIMAP2_VERSION}_x64-linux:${PATH}"

# Создаем рабочую директорию
WORKDIR /workspace

# Копируем скрипт
COPY run_minimap2.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run_minimap2.sh

# Запускаем скрипт по умолчанию
CMD ["run_minimap2.sh"]