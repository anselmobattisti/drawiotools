#!/bin/bash

# Original idea (https://stackoverflow.com/questions/65404843/draw-io-how-to-export-all-tabs-to-images-using-command-line/66145548#66145548)

# the name of the file without .drawio
file=$1

# @todo check if the extension was passed 

# Export diagram to plain XML
drawio --export --format xml --uncompressed "$file.drawio"

# Use xmllint to extract the name attribute of all diagram elements
pages=($(xmllint --xpath "//diagram/@name" "$file.xml" 2>/dev/null | sed -e 's/ name=//g' -e 's/\"//g'))


i=0
for page in "${pages[@]}"; do    

    # The --page-index option is not working (https://github.com/jgraph/drawio/issues/3597), so we are using --page-range instead.
    # drawio --export --embed-diagram --crop --page-index $i --output "$file-$i.pdf" "$file.drawio"

    drawio --export --embed-diagram --crop --page-range $i..$i --crop --output "$file-$page.pdf" "$file.drawio"    
    ((i=i+1))
done

# remove the tmp xml file
rm $file.xml