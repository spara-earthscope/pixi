FROM public.ecr.aws/earthscope/geolab-base-img:latest
# FROM geolab:local

ENV HOME_DIR=/home/jovyan
ENV NB_USER=jovyan
ENV CONDA_PREFIX=/opt/conda
ENV LD_LIBRARY_PATH=${CONDA_PREFIX}/lib
ENV SFG_TOOLS=/opt/

# Install pixi and es_sfgtools
WORKDIR /opt
USER root
RUN git clone --single-branch --branch main https://github.com/EarthScope/es_sfgtools.git &&\
    chown -R ${NB_USER}:${NB_USER} es_sfgtools &&\
    wget -qO- https://pixi.sh/install.sh > install.sh &&\
    chmod +x install.sh &&\
    chown ${NB_USER}:${NB_USER} install.sh &&\
    apt-get update && apt-get install -y libsuitesparse-dev &&\
    echo 'export PATH=$PATH:/opt/bin/.pixi/bin' >> /etc/profile

USER ${NB_USER}
RUN ./install.sh --prefix /opt/bin/.pixi
ENV PATH="/opt/bin/.pixi/bin:${PATH}"
WORKDIR /opt/es_sfgtools
USER root
RUN pixi shell-hook -e full -s bash >> /etc/profile
USER ${NB_USER}
RUN pixi run setup -e full
WORKDIR ${HOME_DIR}

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
