[![Docker Build](https://github.com/ai-dock/onetrainer/actions/workflows/docker-build.yml/badge.svg)](https://github.com/ai-dock/onetrainer/actions/workflows/docker-build.yml)

# Ai-Dock + OneTrainer Docker Image

Run [OneTrainer](https://github.com/Nerogar/OneTrainer) in a docker container locally or in the cloud.

This image is an extension of [Ai-Dock/Linux-Desktop](https://github.com/ai-dock/linux-desktop) with OneTrainer preinstalled for user convenience.

These container images are tested extensively at [Vast.ai](https://link.ai-dock.org/template-vast-onetrainer) & [Runpod.io](https://link.ai-dock.org/template-runpod-onetrainer) but compatibility with other GPU cloud services is expected.

>[!NOTE]
>These images do not bundle models or third-party configurations. You should use a [provisioning script](#provisioning-script) to automatically configure your container. You can find examples in `config/provisioning`.


## Documentation

All AI-Dock containers share a common base which is designed to make running on cloud services such as [vast.ai](https://link.ai-dock.org/vast.ai) and [runpod.io](https://link.ai-dock.org/template) as straightforward and user friendly as possible.

Common features and options are documented in the [base wiki](https://github.com/ai-dock/base-image/wiki) but any additional features unique to this image will be detailed below.


#### Version Tags

The `:latest` tag points to `:latest-cuda`

Tags follow these patterns:

##### _CUDA_
- `:pytorch-[pytorch-version]-py[python-version]-cuda-[x.x.x]-base-[ubuntu-version]`

- `:latest-cuda` &rarr; `:pytorch-2.1.2-py3.10-cuda-11.8.0-base-22.04`

- `:latest-cuda-jupyter` &rarr; `:jupyter-pytorch-2.1.2-py3.10-cuda-11.8.0-base-22.04`

Browse [here](https://github.com/ai-dock/onetrainer/pkgs/container/onetrainer) for an image suitable for your target environment.

Supported Python versions: `3.10`

Supported Pytorch versions: `2.1.2`, `2.2.0`

Supported Platforms: `NVIDIA CUDA`


## Additional Environment Variables

| Variable                 | Description |
| ------------------------ | ----------- |
| `AUTO_UPDATE`            | Update OneTrainer on startup (default `true`) |
| `ONETRAINER_BRANCH`      | OneTrainer branch/commit hash. (default `master`) |
| `ONETRAINER_FLAGS`       | Startup flags. eg. `--generic-option1 --generic-option2` |

See the base environment variables [here](https://github.com/ai-dock/base-image/wiki/2.0-Environment-Variables) for more configuration options.


### Additional Micromamba Environments

| Environment    | Packages |
| -------------- | ----------------------------------------- |
| `onetrainer`   | OneTrainer and dependencies |

This micromamba environment will be activated on shell login.

See the base micromamba environments [here](https://github.com/ai-dock/base-image/wiki/1.0-Included-Software#installed-micromamba-environments).


## Pre-Configured Templates

**Vast.​ai**

- [onetrainer:latest](https://link.ai-dock.org/template-vast-onetrainer)

---

**Runpod.​io**

- [onetrainer:latest](https://link.ai-dock.org/template-runpod-onetrainer)

---

_The author ([@robballantyne](https://github.com/robballantyne)) may be compensated if you sign up to services linked in this document. Testing multiple variants of GPU images in many different environments is both costly and time-consuming; This helps to offset costs_