#!/bin/bash

echo "Starting development container with network fixes..."

docker run -it --rm \
  -v ~/Development/mm-monorepo:/workspace \
  -w /workspace \
  --dns=8.8.8.8 \
  --dns=1.1.1.1 \
  --network bridge \
  -e http_proxy="" \
  -e https_proxy="" \
  ubuntu:latest bash -c "
    echo 'nameserver 8.8.8.8' > /etc/resolv.conf
    echo 'nameserver 1.1.1.1' >> /etc/resolv.conf
    
    echo 'Updating package lists...'
    apt update && apt install -y git curl iputils-ping
    
    echo 'Testing connectivity...'
    ping -c 2 8.8.8.8 || echo 'Direct IP failed'
    ping -c 2 google.com || echo 'DNS resolution failed'

    echo 'Installing NVM...'
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    export NVM_DIR=\"\$HOME/.nvm\"
    [ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"
    [ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\"
    
    echo 'Installing Node.js...'
    nvm install node
    nvm install v20.12.2
    nvm use v20.12.2

    echo 'Installing pyenv dependencies...'
    apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl git libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

    echo 'Installing pyenv...'
    curl -fsSL https://pyenv.run | bash
    export PYENV_ROOT=\"\$HOME/.pyenv\"
    export PATH=\"\$PYENV_ROOT/bin:\$PATH\"
    eval \"\$(pyenv init --path)\"
    eval \"\$(pyenv init -)\"
    eval \"\$(pyenv virtualenv-init -)\"
    
    echo 'Installing Python...'
    pyenv install 3.11.0
    pyenv global 3.11.0
    
    echo '=== Environment ready ==='
    echo 'Node version:' && node --version
    echo 'Python version:' && python --version

    echo 'Installing mkdocs and plugins...'
    pip install mkdocs
    pip install mkdocs-techdocs-core
    pip install -r ./pkg/idp/mkdocs/plugins/mkdocs-monorepo-plugin/requirements.txt
    python ./pkg/idp/mkdocs/plugins/mkdocs-monorepo-plugin/setup.py install
    
    bash
  "