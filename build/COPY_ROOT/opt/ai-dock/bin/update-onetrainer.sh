#!/bin/bash

branch=master

if [[ -n "${ONETRAINER_BRANCH}" ]]; then
    branch="${ONETRINER_BRANCH}"
fi

# -b flag has priority
while getopts b: flag
do
    case "${flag}" in
        b) branch="$OPTARG";;
    esac
done


printf "Updating OneTrainer (${branch})...\n"

cd /opt/OneTrainer
git checkout ${branch}
git pull

# Remove parts of the requirements file that are already handled by our base torch install
sed -e '/^# pytorch$/,/^torchvision/d' \
    -e '/--extra-index-url https:\/\/download.pytorch.org/d' \
    -e '/^# xformers$/,/^xformers/d' \
        requirements.txt > requirements.ai-dock.txt


micromamba run -n onetrainer ${PIP_INSTALL} -r requirements.ai-dock.txt
