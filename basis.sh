#!/bin/bash

read -p 'input directory : ' INPUT_DIRECTORY

if [ ! -d "$INPUT_DIRECTORY" ]; then
    echo "$INPUT_DIRECTORY is not a directory. exit script."
    exit 1
fi

OUTPUT_DIRECTORY="$INPUT_DIRECTORY/basis"
BASISU="./basis_universal/bin_osx/basisu"

if [ ! -d "$OUTPUT_DIRECTORY" ]; then
    echo "$OUTPUT_DIRECTORY is not a directory. creating directory."
    mkdir $OUTPUT_DIRECTORY
fi

for TEXTURE in "$INPUT_DIRECTORY"/*.{jpeg,jpg,png};
do
    OUTPUT_FILENAME="$(basename "$TEXTURE")"

    if [ ! -f "$TEXTURE" ]; then
        continue
    fi

    FILE=$(basename -- "$TEXTURE")
    ORIGINAL_SIZE=$(wc -c "${TEXTURE}" | cut -f1)
    ORIGINAL_EXTENSION="${TEXTURE##*.}"
    FILENAME="${FILE%.*}"
    OUTPUT_FILE="$INPUT_DIRECTORY/basis/$FILENAME.basis"

    if [ -f "$OUTPUT_FILE" ]; then
        echo "file $OUTPUT_FILE already exists"
        continue
    fi

    # Execute encoding
    $BASISU $TEXTURE -output_path $OUTPUT_DIRECTORY
done