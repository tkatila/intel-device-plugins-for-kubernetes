FROM ubuntu:22.04@sha256:7af9ba4f0a47d9bc8b1ffa492c6b0276476f1889cf4e699fba2236924e5932ed

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
