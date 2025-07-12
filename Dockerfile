FROM rstudio/workbench-session:ubuntu2204-r4.4.1_4.3.3-py3.12.6_3.11.10

ENV PATH="/opt/python/3.12.6/bin:$PATH"

# Atualiza pip e instala pacotes no Python 3.12 interno
RUN python3.12 -m ensurepip --upgrade && \
    python3.12 -m pip install --upgrade pip && \
    python3.12 -m pip install --no-cache-dir pandas numpy matplotlib ipykernel

# Registra o kernel no local correto para o Workbench
RUN python3.12 -m ipykernel install \
    --name python312 \
    --display-name "Python 3.12" \
    --prefix /opt/python/3.12.6

# Opcional: define o kernel default para novas sessões
ENV JUPYTER_KERNEL_NAME=python312
