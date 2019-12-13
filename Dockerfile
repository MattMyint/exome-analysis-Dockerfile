#Use Ubuntu OS
FROM ubuntu:18.04

RUN apt-get update && apt-get install -y wget

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
/bin/bash Miniconda3-latest-Linux-x86_64.sh -f -b -p /opt/conda && \
rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH /opt/conda/bin:$PATH

LABEL description="Docker image containing all requirements for Exome analysis"

#Copy the environment file containing all the requirements to be installed using conda
COPY environment.yml /
RUN conda update -y conda && conda env create -f /environment.yml && conda clean -a
ENV PATH /opt/conda/envs/ExomeAnalysis/bin:$PATH
CMD conda activate exome-analysis
## Required to build the container properly
