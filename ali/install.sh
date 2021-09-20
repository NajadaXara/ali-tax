#!/bin/sh

conda init bash

conda create -n ali-tax python=3.9
conda activate ali-tax
echo ">> Virtual environment ali-tax created."

# pip install -r requirements.txt
curl -k https://chiselapp.com/user/PSG/repository/Tax-Analyzer-Framework/zip/cb7189b8e5/Tax-Analyzer-Framework-cb7189b8e5.zip -L -O  && \
curl -k https://chiselapp.com/user/WBG/repository/ALI-Tax-Analyzer/zip/fcc3b82bfb/ALI-Tax-Analyzer-fcc3b82bfb.zip -L -O && \
echo ">> Packages downloaded."

# Have to be git sorted as framework installation comes first
for zipped_package in *.zip;
do
    echo $zipped_package
    $package_name="${zipped_package%.*}"  # get package name without .zip
    (
        unzip "$package_name";
         cd "$package_name"
         pip install .
         # shellcheck disable=SC2103
         cd ..; rm -r "$zipped_package" # cleanup
     )&
done
