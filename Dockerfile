FROM continuumio/anaconda3
 
MAINTAINER thomas thomas.krebs@t-systems.com
RUN mkdir /opt/notebooks && mkdir /opt/notebooks/work
WORKDIR /opt/notebooks
RUN /opt/conda/bin/conda install jupyter -y --quiet && \
         git clone https://github.com/totalgood/nlpia.git && \
         apt-get update -y && apt-get install -y gcc g++ portaudio19-dev pandoc texlive-xetex
WORKDIR /opt/notebooks/nlpia
RUN conda env create -f conda/environment.yml && \
    /bin/bash -c "source activate nlpia"  && \
    conda install nbconvert &&  \
    pip install -e .

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents
# kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 8888
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--notebook-dir=/opt/notebooks"]
