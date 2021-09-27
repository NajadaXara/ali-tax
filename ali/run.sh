cd "Tax-Analyzer-Framework"
pip install .
cd ..;

cd "ALI-Tax-Analyzer"
pip install .
cd ..;

# test installation
tafrun --version
tafrun --test
alirun --version
alirun --test

# open GUI
aligui
