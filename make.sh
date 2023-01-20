#!/bin/bash

if [[ "$1" == "" ]]; then
    echo "You need to pass in a name for the print!"
    echo ""
    echo "     Example; ./make.sh small_container"
    return 1
fi 

echo ""
echo "Creating a new print setup called [$1]..."

print_name="$1"
readme="$print_name/README.md"
project_file="list_of_projects.txt"
main_readme="README.md"

echo "Refuzzing main readme..."
echo "$print_name" >> $project_file

rm -f README.md
echo "# fx_printing" >> $main_readme
echo "This repo is a collection of all the designs and 3D prints that I have made and published to thingiverse; you can find my [profile](https://www.thingiverse.com/crowzfx/about) here." >> $main_readme
echo "" >> $main_readme
echo "## Prints" >> $main_readme
echo "The list is sorted by 0-9, A-Z then a-z:" >> $main_readme
echo "" >> $main_readme

sort -o $project_file{,}
while IFS= read -r project; do
  echo "Processing line: $project"
  echo "* [$project]($project/README.md)" >> $main_readme
done < $project_file

mkdir -p $print_name/{img,stl}
touch $print_name/README.md

echo "# $print_name" >> $readme
echo "Back to [MAIN README](../README.md)" >> $readme
echo "" >> $readme
echo "## Files" >> $readme
echo "[STL Files](stl/)" >> $readme
echo "" >> $readme
echo "## Print Settings" >> $readme
echo "\`\`\`" >> $readme
echo "Printer: Ender 3" >> $readme
echo "Rafts: No" >> $readme
echo "Supports: No" >> $readme
echo "Resolution: 0.15mm" >> $readme
echo "Infill: 20%" >> $readme
echo "Filament: PLA" >> $readme
echo "\`\`\`" >> $readme
echo "" >> $readme
echo "## Images" >> $readme
echo "![$print_name](img/$print_name.jpeg)" >> $readme

echo "Completed!"
echo "Files avaliable in [$print_name]..."
