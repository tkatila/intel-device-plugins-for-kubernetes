# This Dockerfile is currently provided as a reference to build aesmd with ECDSA attestation
# but is not published along with the device plugin container images.
FROM ubuntu:22.04@sha256:a6d2b38300ce017add71440577d5b0a90460d0e57fd7aec21dd0d1b0761bbfb2

RUN apt update && apt install -y curl gnupg-agent \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/intel-sgx.gpg] https://download.01.org/intel-sgx/sgx_repo/ubuntu jammy main" | \
    tee -a /etc/apt/sources.list.d/intel-sgx.list \
    && curl -s https://download.01.org/intel-sgx/sgx_repo/ubuntu/intel-sgx-deb.key | \
    gpg --dearmor --output /usr/share/keyrings/intel-sgx.gpg \
    && apt update \
    && apt install -y --no-install-recommends \
       sgx-aesm-service \
       libsgx-dcap-ql \
       libsgx-aesm-ecdsa-plugin \
       libsgx-aesm-pce-plugin \
       libsgx-aesm-quote-ex-plugin \
       libsgx-dcap-default-qpl

RUN echo "/opt/intel/sgx-aesm-service/aesm" | tee /etc/ld.so.conf.d/sgx.conf \
    && ldconfig

ENV PATH=/opt/intel/sgx-aesm-service/aesm
ENTRYPOINT ["/opt/intel/sgx-aesm-service/aesm/aesm_service", "--no-daemon"]
