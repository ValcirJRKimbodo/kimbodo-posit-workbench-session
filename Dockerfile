FROM rstudio/workbench-session:ubuntu2204-r4.4.1_4.3.3-py3.12.6_3.11.10

ENV PATH="/opt/python/3.12.6/bin:$PATH"

# 1 – Ferramentas base
RUN python3.12 -m ensurepip --upgrade && \
    python3.12 -m pip install --upgrade pip && \
    python3.12 -m pip install --no-cache-dir pandas numpy matplotlib ipykernel

# 2 – Index do PPM (sem /pypi/)
RUN python3.12 -m pip config set global.index-url \
      https://posit01gcp-package.kimbodo.com/internal-python/latest/simple && \
    python3.12 -m pip config set global.trusted-host posit01gcp-package.kimbodo.com

RUN python3.12 -m pip config set global.extra-index-url https://pypi.org/simple

# 3 – Instala a sua lib
RUN python3.12 -m pip install --no-cache-dir posit-demo-utils

# 4 – Kernel Jupyter para o Workbench
RUN python3.12 -m ipykernel install \
      --name python312 --display-name "Python 3.12" \
      --prefix /opt/python/3.12.6

ENV JUPYTER_KERNEL_NAME=python312
