FROM ubuntu:22.04

ENV MINIMAP2_VERSION=2.24

# Устанавливаем зависимости
RUN apt-get update && apt-get install -y \
    wget \
    make \
    gcc \
    zlib1g-dev \
    bzip2 \
    && rm -rf /var/lib/apt/lists/*

# Скачиваем и устанавливаем minimap2 (уже включает k8 и paftools.js)
RUN wget https://github.com/lh3/minimap2/releases/download/v${MINIMAP2_VERSION}/minimap2-${MINIMAP2_VERSION}_x64-linux.tar.bz2 \
    && tar -jxvf minimap2-${MINIMAP2_VERSION}_x64-linux.tar.bz2 \
    && mv minimap2-${MINIMAP2_VERSION}_x64-linux /opt/minimap2-${MINIMAP2_VERSION}_x64-linux \
    && rm minimap2-${MINIMAP2_VERSION}_x64-linux.tar.bz2

# Добавляем в PATH
ENV PATH="/opt/minimap2-${MINIMAP2_VERSION}_x64-linux:${PATH}"

WORKDIR /workspace
COPY run_paftools.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run_paftools.sh

CMD ["run_paftools.sh"]