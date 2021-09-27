#!/bin/sh

conda init bash

conda create -n ali-tax python=3.9 # optionally can be changed > 3
conda activate ali-tax
echo ">> Virtual environment ali-tax created."

# pip install -r requirements.txt
curl -k https://chiselapp.com/user/PSG/repository/Tax-Analyzer-Framework/zip/94f0c71095/Tax-Analyzer-Framework-94f0c71095.zip -L -O
curl -k https://chiselapp.com/user/WBG/repository/ALI-Tax-Analyzer/zip/287590ce94/ALI-Tax-Analyzer-287590ce94.zip -L -O
echo ">> Packages downloaded."

packages=(`ls Tax*.zip`, `ls ALI*.zip`)
for zipped_package in "${packages[@]}";
do
    echo $zipped_package
    package_name="${zipped_package%.*}"  # get package name without .zip
    echo $package_name
    (
         unzip $package_name;
         cd "$package_name"
         echo ">> Unziped package $package_name."
         pip install .
         echo ">> Installed package $package_name."
         # shellcheck disable=SC2103
         cd ..; rm -r $zipped_package; # cleanup
     )&
done

# test installation
alirun --version
alirun --test

# open GUI
aligui
