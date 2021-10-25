FROM ghcr.io/oracle/oraclelinux8-compat:8-slim

# Install Python
RUN mkdir /install
WORKDIR /install
RUN dnf groupinstall "Development Tools" -y && \
    dnf install openssl-devel libffi-devel bzip2-devel wget -y && \
    wget https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz && \
    tar xvf Python-3.9.7.tgz && \
    cd Python-3.9*/ && \
    ./configure --enable-optimizations && \
    make altinstall && \
    ln -s /usr/local/bin/python3.9 /usr/local/bin/python3 && \
    ln -s /usr/local/bin/python3.9 /usr/local/bin/python && \
    ln -s /usr/local/bin/pip3.9 /usr/local/bin/pip3 && \
    ln -s /usr/local/bin/pip3.9 /usr/local/bin/pip && \
    dnf groupremove "Development Tools" -y && \
    rm -rf /var/cache/dnf

CMD ["pip -V"]
