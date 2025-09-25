# CPU-only, multi-arch base
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive TZ=UTC
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl wget git nano vim tini \
    build-essential pkg-config python3 python3-pip python3-venv \
    ffmpeg libsm6 libxext6 libgl1 \
    && rm -rf /var/lib/apt/lists/*

ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd -g ${USER_GID} ${USERNAME} && \
    useradd -m -s /bin/bash -u ${USER_UID} -g ${USER_GID} ${USERNAME}

# Install tesseract
RUN apt-get update && apt install -y tesseract-ocr libtesseract-dev

USER ${USERNAME}
WORKDIR /workspace

# Create venv and install JupyterLab
RUN python3 -m venv ~/.venv && \
    ~/.venv/bin/pip install --upgrade pip && \
    ~/.venv/bin/pip install jupyterlab ipykernel ipywidgets numpy scipy pandas matplotlib

ENV PATH=/home/${USERNAME}/.venv/bin:$PATH
RUN python -m ipykernel install --user --name "py" --display-name "Python (venv)"

WORKDIR /home/zhengxin.chai/GenFlowchart

# Copy files
COPY requirements.txt .

# Install pypi packages
RUN pip install -r requirements.txt

EXPOSE 8888
ENTRYPOINT ["/usr/bin/tini","--"]
CMD ["bash","-lc","jupyter lab --ip=0.0.0.0 --port=8888 --no-browser"]
