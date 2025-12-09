# AtCoder Codon Environment

A complete development environment for solving AtCoder problems using **Python 3.13** and **[Codon](https://github.com/exaloop/codon)** (a high-performance Python compiler).

This repository is designed to be used with **VS Code Dev Containers**, providing a consistent environment across generic x86_64 PCs and Apple Silicon (M1/M2/M3) Macs.

## Features

- **🚀 Codon Compiler**: Write Python, run at C++ speeds. Pre-installed and configured.
- **📦 Multi-Arch Support**: Docker image supports both `linux/amd64` (Intel/AMD) and `linux/arm64` (Apple Silicon).
- **🛠️ Tools Pre-installed**:
  - `atcoder-cli` (acc)
  - `online-judge-tools` (oj)
  - Python 3.13 & Standard Libraries
  - Common CP Libraries: `ac-library-python`, `numpy`, `scipy`, `networkx`, `sortedcontainers`, `more-itertools`, and more.
- **🔒 Private User Data**: Your code and configurations (`user_data/`) are separated from the template, making it easy to manage them in a private Git repository.

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) or Docker Engine
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/liebe-magi/atcoder-codon.git
cd atcoder-codon
```

### 2. Initialize User Environment

Run the setup script to create your local configuration and contents directory. This will copy the default templates to `user_data/`.

```bash
./user_setup.sh
```

> **Note**: The `user_data/` directory is git-ignored. You can initialize a git repository inside `user_data/` effectively keeping your solutions private while using this public environment template.

### 3. Open in VS Code

Open the repository folder in VS Code. You should see a prompt to "Reopen in Container". Click it.

Alternatively:
1.  Press `F1` (or `Cmd+Shift+P`).
2.  Select **Dev Containers: Reopen in Container**.

VS Code will pull the Docker image and start the environment.

### 4. Login to AtCoder (First Time Only)

Once inside the container terminal:

```bash
# Login to atcoder-cli
acc login

# Login to online-judge-tools
oj login https://atcoder.jp/
```

## Usage

### 1. Create Contest Project

```bash
new abc300
cd abc300/a
```

### 2. Test Your Code

```bash
# Simply run with python
python main.py

# Test using oj tools (config included in tasks.json)
# You can use VS Code Tasks: Terminal -> Run Task... -> Test
```

### 3. Compile & Run with Codon

```bash
# Compile and run
codon run -release main.py

# Only compile
codon build -release -exe main.py
./main
```

### directory Structure

- `template/`: Contains the default configuration templates.
- `user_data/`: **[Important]** Your workspace. Created by `setup.sh`.
    - `user_data/config/`: Configuration files for tools and templates.
    - `user_data/contents/`: Directory where your contest codes will be stored.
- `docker/`: Dockerfile and build settings.

## Customization

You can customize the templates (e.g., `main.py`) by editing files in `user_data/config/`. Since `user_data` is yours, feel free to modify it as you like.
