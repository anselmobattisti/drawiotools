#!/bin/bash

# Original idea (https://stackoverflow.com/questions/65404843/draw-io-how-to-export-all-tabs-to-images-using-command-line/66145548#66145548)

# the name of the file without .drawio
file=$1

# @todo check if the extension was passed 

# Export diagram to plain XML
drawio --export --format xml --uncompressed "$file.drawio"

# Count how many pages based on <diagram element>
count=$(grep -o "<diagram" "$file.xml" | wc -l)

# Export each page as an PDF
# use --embed-diagram to include in each PDF the complete drawio diagrams.
for ((i = 0 ; i <= ${count}-1; i++)); do
  drawio --export --page-index $i --output "$file-$i.pdf" "$file.drawio"
done

# remove the tmp xml file
rm $file.xml