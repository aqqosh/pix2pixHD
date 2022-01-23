FROM pytorch/pytorch:0.4.1-cuda9-cudnn7-runtime

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
	sudo vim wget ca-certificates

ARG USER_ID=1000
RUN useradd -m --no-log-init --system  --uid ${USER_ID} appuser -g sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER appuser
WORKDIR /home/appuser

ENV FORCE_CUDA="1"

RUN pip install --user cython dominate \
    && git clone https://github.com/NVIDIA/pix2pixHD

VOLUME /home/appuser/pix2pixHD
WORKDIR /home/appuser/pix2pixHD