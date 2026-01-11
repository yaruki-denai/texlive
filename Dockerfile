FROM debian:trixie-slim

ARG TEXLIVE_YEAR="2025"
ARG TEXLIVE_ISO_URL="https://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/Images/texlive2025-20250308.iso"

ENV PATH="/usr/local/texlive/${TEXLIVE_YEAR}/bin/x86_64-linux:${PATH}"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    ghostscript \
    libarchive-tools \
    perl \
    wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/texlive \
  && cd /tmp/texlive \
  && wget -O texlive.iso "${TEXLIVE_ISO_URL}" \
  && bsdtar xvf texlive.iso \
  && ./install-tl --no-interaction \
  && rm -rf /tmp/texlive
