#!/bin/false

source /opt/ai-dock/etc/environment.sh
onetrainer_git="https://github.com/Nerogar/OneTrainer"

build_common_main() {
    build_common_create_env
    build_common_install_jupyter_kernels
    build_common_clone_onetrainer
}

build_common_create_env() {
    apt-get update
    $APT_INSTALL \
        libgl1-mesa-glx \
        libtcmalloc-minimal4

    ln -sf $(ldconfig -p | grep -Po "libtcmalloc_minimal.so.\d" | head -n 1) \
        /lib/x86_64-linux-gnu/libtcmalloc.so
        
    
    # A new pytorch env costs ~ 300Mb
    exported_env=/tmp/${MAMBA_DEFAULT_ENV}.yaml
    micromamba env export -n ${MAMBA_DEFAULT_ENV} > "${exported_env}"
    $MAMBA_CREATE -n onetrainer --file "${exported_env}"
    python_version="$(micromamba -n onetrainer run python -V | tail -n1 | awk '{print $2}' | cut -d '.' -f1,2)"
    printf "/opt/micromamba/envs/onetrainer/lib\n" >> /etc/ld.so.conf.d/x86_64-linux-gnu.micromamba.10-onetrainer.conf
    printf "/opt/micromamba/envs/onetrainer/lib/python%s/site-packages/torch/lib/\n" "$python_version" >> /etc/ld.so.conf.d/x86_64-linux-gnu.micromamba.10-onetrainer.conf
}


build_common_install_jupyter_kernels() {
    if [[ $IMAGE_BASE =~ "jupyter-pytorch" ]]; then
        $MAMBA_INSTALL -n onetrainer \
            ipykernel \
            ipywidgets
        
        kernel_path=/usr/local/share/jupyter/kernels
        
        # Add the often-present "Python3 (ipykernel) as a onetrainer alias"
        rm -rf ${kernel_path}/python3
        dir="${kernel_path}/python3"
        file="${dir}/kernel.json"
        cp -rf ${kernel_path}/../_template ${dir}
        sed -i 's/DISPLAY_NAME/'"Python3 (ipykernel)"'/g' ${file}
        sed -i 's/PYTHON_MAMBA_NAME/'"onetrainer"'/g' ${file}
        
        dir="${kernel_path}/onetrainer"
        file="${dir}/kernel.json"
        cp -rf ${kernel_path}/../_template ${dir}
        sed -i 's/DISPLAY_NAME/'"OneTrainer"'/g' ${file}
        sed -i 's/PYTHON_MAMBA_NAME/'"onetrainer"'/g' ${file}
    fi
}

build_common_clone_onetrainer() {
    cd /opt
    git clone ${onetrainer_git}
}

build_common_main "$@"