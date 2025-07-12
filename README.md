# Posit Workbench Session Image – Python 3.12

This custom Docker image is designed to be used as a *Session Image* within [Posit Workbench](https://posit.co/products/workbench/) (formerly RStudio Workbench), optimized for Python 3.12 development inside a Kubernetes environment.

## 🐳 Base Image

This image is based on:

```
rstudio/workbench-session:ubuntu2204-r4.4.1_4.3.3-py3.12.6_3.11.10
```

It comes preloaded with R 4.4.1 and both Python 3.12.6 and 3.11.10. This Dockerfile customizes the environment to fully enable **Python 3.12** as a Jupyter-compatible kernel.

## 🔧 What’s Included

- Updates the `PATH` to prioritize Python 3.12
- Installs and upgrades:
  - `pip`
  - `pandas`
  - `numpy`
  - `matplotlib`
  - `ipykernel`
- Registers a Jupyter kernel with:
  - **Name:** `python312`
  - **Display Name:** `Python 3.12`
- Sets this kernel as the default via the `JUPYTER_KERNEL_NAME` environment variable

## 📦 Building the Image

To build the image locally:

```bash
docker build -t imbodovalcir/kimbodo-posit:latest .
```

## 🚀 Using in Posit Workbench (Kubernetes)

1. Push the built image to your container registry (e.g., Docker Hub, GCR, etc.).
2. Configure your Helm chart or `values.yaml` with the custom image:

```yaml
config:   
  profiles:
    launcher.kubernetes.profiles.conf:
      "*":        
        container-images: 
          - kimbodovalcir/kimbodo-posit:latest
```

3. Restart the Workbench deployment and launch a new session.

## ✅ Verifying in Workbench

When starting a new session in Posit Workbench:

- Select the kernel **Python 3.12**
- Run a quick test to verify that packages are available:

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
```

## 📝 Notes

- This Dockerfile does not remove other available kernels (e.g., R or Python 3.11).
- You may further customize the image if you need to restrict available environments.
- If using a private PyPI mirror (such as Posit Package Manager), you can configure `pip` via `pip config`.

---

**Author:** Valcir Balbinotti Junior  
**Project:** Custom Python session image for Posit Workbench on Kubernetes
