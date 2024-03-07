#!/bin/false

build_nvidia_main() {
    build_nvidia_install_onetrainer
}

build_nvidia_install_onetrainer() {
    micromamba run -n onetrainer ${PIP_INSTALL} \
        torch=="${PYTORCH_VERSION}" \
        nvidia-ml-py3
    
    micromamba install -n onetrainer -c xformers xformers

    /opt/ai-dock/bin/update-onetrainer.sh
}

build_nvidia_main "$@"