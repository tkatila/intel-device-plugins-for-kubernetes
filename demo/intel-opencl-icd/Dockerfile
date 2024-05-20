FROM ubuntu:22.04@sha256:a6d2b38300ce017add71440577d5b0a90460d0e57fd7aec21dd0d1b0761bbfb2

ARG APT="env DEBIAN_FRONTEND=noninteractive apt"

RUN ${APT} update && ${APT} install -y curl gpg-agent \
    && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/gpu/ubuntu jammy/lts/2350 unified' | \
       tee -a /etc/apt/sources.list.d/intel.list \
    && curl -s https://repositories.intel.com/graphics/intel-graphics.key | \
       gpg --dearmor --output /usr/share/keyrings/intel-graphics.gpg \
    && ${APT} update \
    && ${APT} install -y --no-install-recommends \
       intel-opencl-icd \
       clinfo \
    && ${APT} remove -y curl gpg-agent \
    && ${APT} autoremove -y
