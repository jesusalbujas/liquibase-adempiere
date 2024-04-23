# Utiliza la imagen oficial de PostgreSQL 13 como base
FROM postgres:13

# Instalar curl, wget y unzip
RUN apt-get update && \
    apt-get install -y curl wget unzip && \
    rm -rf /var/lib/apt/lists/*

RUN apt update && \
    apt install -y default-jre default-jdk

# Instalar Liquibase
RUN mkdir -p /opt/liquibase && \
    cd /opt/liquibase && \
    wget -O liquibase.tar.gz "https://github.com/liquibase/liquibase/releases/download/v4.27.0/liquibase-4.27.0.tar.gz" && \
    tar -xzf liquibase.tar.gz && \
    rm liquibase.tar.gz && \
    chmod +x /opt/liquibase/liquibase && \
    ln -s /opt/liquibase/liquibase /usr/local/bin/

# Configurar Liquibase en la variable de entorno PATH
ENV PATH="/opt/liquibase:${PATH}"
# Agregar Java al PATH

# Establecer el directorio de trabajo predeterminado
WORKDIR /liquibase