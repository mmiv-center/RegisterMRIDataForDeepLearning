#!/usr/bin/env bash

#
# Register some volumes into a common reference frame with fsl
# For reference see here
#   https://gate.nmr.mgh.harvard.edu/wiki/whynhow/images/8/8f/WhyNhow_FSL_final-WEB.pdf
# Usage:
#     <input folder> <reference volume> <output folder>
#

if [ ! command -v flirt &> /dev/null ]; then
    echo "Error: this script requires flirt from fsl to be installed"
    exit 1
fi

input="$1"
if [ -z "$input" ]; then
    echo "Usage: $0 <input folder> <reference> <output folder>"
    exit 1
fi
if [ ! -d "$input" ]; then
    echo "Error: input folder $input does not exist"
    exit 1
fi

reference="$2"
if [ -z "$reference" ]; then
    echo "Usage: $0 <input folder> <reference> <output folder>"
    exit 1
fi
if [ ! -e "$reference" ]; then
    echo "Error: reference file $reference could not be found"
    exit 1
fi

output="$3"
if [ -z "$output" ]; then
    echo "Usage: $0 <input folder> <reference> <output folder>"
    exit 1
fi
if [ ! -d "$output" ]; then
    mkdir -p "$output"
fi

# Do we need to resample the reference first? Lets assume we do 1x1x1mm
rn=$(basename "$reference")
rn="${rn%.*}"
flirt -in "${reference}" -ref "${reference}" -applyisoxfm 1.0 -nosearch -out "${output}/reference_${rn}_1x1x1.nii.gz"
reference1x1x1="${output}/reference_${rn}_1x1x1.nii.gz"

# check all nii files and print out dimensions
for f in ${input}/*.nii*; do
    if [ $(basename ${reference}) == $(basename ${f}) ]; then
        # don't register the reference to itself
        continue
    fi
    fn=$(basename ${f})
    rn=$(basename ${reference})
    echo "File: $f register to $reference1x1x1"
    flirt -in ${f} -ref ${reference1x1x1} -out ${output}/${fn%.*}_to_${rn%.*}.nii.gz -dof 6
    # fslhd $f
done

ls -l "${output}/"*
