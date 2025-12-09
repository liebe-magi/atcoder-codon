FROM ubuntu:24.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install sudo and basic tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo curl wget git xz-utils bzip2 build-essential \
    lsb-release software-properties-common gnupg pkg-config \
    libopenblas-dev liblapack-dev libgmp-dev libmpfr-dev libfftw3-dev \
    libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
    libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
    lzma lzma-dev tk-dev uuid-dev zlib1g-dev llvm-bolt ansifilter \
    && echo "ubuntu ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu \
    && rm -rf /var/lib/apt/lists/*

# 2. Install Python 3.13
RUN add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y python3.13 python3.13-dev python3.13-venv && \
    rm -rf /var/lib/apt/lists/*

# 3. Install pip for Python 3.13
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.13

# 4. Install Codon 0.19.3
# Using the official release tarball with multi-arch support
ARG TARGETARCH
RUN if [ "$TARGETARCH" = "amd64" ]; then \
    CODON_ARCH="x86_64"; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
    CODON_ARCH="aarch64"; \
    else \
    CODON_ARCH="x86_64"; \
    fi && \
    wget "https://github.com/exaloop/codon/releases/download/v0.19.3/codon-linux-${CODON_ARCH}.tar.gz" && \
    tar -xvf "codon-linux-${CODON_ARCH}.tar.gz" && \
    cp -r "codon-deploy-linux-${CODON_ARCH}/"* /usr/local/ && \
    rm -rf "codon-deploy-linux-${CODON_ARCH}" "codon-linux-${CODON_ARCH}.tar.gz"

# 5. AtCoder Tools (online-judge-tools, atcoder-cli)
# Need Node.js for atcoder-cli
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g atcoder-cli

# Install online-judge-tools using pip (python 3.13)
RUN python3.13 -m pip install --break-system-packages online-judge-tools aclogin

# 6. Install Libraries
# Using requirements file approach can be cleaner, but straight pip install is fine for Dockerfile.
# torch URL provided by user request
RUN if [ "$TARGETARCH" = "amd64" ]; then \
    TORCH_URL="https://download.pytorch.org/whl/cpu/torch-2.8.0%2Bcpu-cp313-cp313-manylinux_2_28_x86_64.whl"; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
    TORCH_URL="https://download.pytorch.org/whl/cpu/torch-2.8.0%2Bcpu-cp313-cp313-manylinux_2_28_aarch64.whl"; \
    else \
    TORCH_URL="https://download.pytorch.org/whl/cpu/torch-2.8.0%2Bcpu-cp313-cp313-manylinux_2_28_x86_64.whl"; \
    fi && \
    python3.13 -m pip install --break-system-packages \
    "${TORCH_URL}" \
    CPyCppyy==1.13.0 \
    Cython==3.1.3 \
    Jinja2==3.1.6 \
    MarkupSafe==3.0.2 \
    PuLP==3.2.2 \
    absl-py==2.3.1 \
    bitarray==3.6.1 \
    cppyy==3.5.0 \
    cppyy-backend==1.15.3 \
    cppyy-cling==6.32.8 \
    filelock==3.19.1 \
    fsspec==2025.7.0 \
    gmpy2==2.2.1 \
    immutabledict==4.2.1 \
    joblib==1.5.1 \
    lightgbm==4.6.0 \
    llvmlite==0.44.0 \
    more-itertools==10.7.0 \
    mpmath==1.3.0 \
    networkx==3.5 \
    numba==0.61.2 \
    numpy==2.2.6 \
    ortools==9.14.6206 \
    pandas==2.3.2 \
    polars==1.31.0 \
    protobuf==6.31.1 \
    pyrsistent==0.20.0 \
    python-dateutil==2.9.0.post0 \
    pytz==2025.2 \
    rustworkx==0.16.0 \
    scikit-learn==1.7.1 \
    scipy==1.16.1 \
    shapely==2.1.1 \
    six==1.17.0 \
    sortedcontainers==2.4.0 \
    sympy==1.14.0 \
    threadpoolctl==3.6.0 \
    typing_extensions==4.14.1 \
    tzdata==2025.2 \
    z3-solver==4.15.3.0

# Install libraries likely from git or simple naming
# ac-library-python and acl-cpp-python
RUN python3.13 -m pip install --break-system-packages \
    git+https://github.com/not522/ac-library-python \
    git+https://github.com/tatyam-prime/acl-cpp-python@v0.6.2

# Set default python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.13 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 1

# User setup
USER ubuntu
ENV HOME=/home/ubuntu
WORKDIR $HOME

# Working path
WORKDIR /workspace