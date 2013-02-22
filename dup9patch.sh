#!/bin/sh
#
# dup9patch.sh: Duplicate a 9-patch frame to many (same size) PNG images
#
# Usage : dup9patch.sh image9patch inputDirectory outputDirectory

image9patch="${1:-9patch.9.png}" # the input - already 9-patched - image
inImagesDir="${2:-in}" # the input images directory (all of the same size, and of the same size of image9patch)
outImagesDir="${3:-9patch}" # the output images directory (initially empty)

# some preliminary checks
if [ ! -r "$image9patch" ]; then
    echo "Can't read 9-patch image [$image9patch]!"
    exit 1
fi
if [ ! -d "$inImagesDir" ]; then
    echo "Directory of input images [$inImagesDir] doesn'r exist!"
    exit 2
fi
if [ ! -d "$outImagesDir" ]; then
    mkdir "$outImagesDir"
    if [ $? -ne 0 ]; then
        echo "Can't create directory for output images [$outImagesDir]!"
        exit 3
    fi
fi


# identify 9-patch image size
WxH="`identify \"$image9patch\" | cut -f 3 -d ' '`" # source 9i-patch image size (width x height)
W="`echo $WxH | cut -f 1 -d x`" # source 9-patch image width
H="`echo $WxH | cut -f 2 -d x`" # source 9-patch image height

# build 9-patch frame
frame="9patch-frame-$$.png"
mask="9patch-mask-$$.png"
# create black mask the size of original image
convert -size "$((${W}-1-1))x$((${H}-1-1))" xc:black "$mask"
# cut the mask shape out of the image
composite -compose dst-out "$mask" "$image9patch" -geometry "$((${W}-1-1))x$((${H}-1-1))+1+1" -matte "$frame"

# add 9-patch frame to input images and build output images
for image in "$inImagesDir"/*.png; do
    montage "$image" -texture "$frame" -geometry "$((${W}-1-1))x$((${H}-1-1))+1+1" "$outImagesDir/`basename \"$image\" .png`.9.png"
done

# cleanup and exit
rm -f "$frame" "$mask"
exit 0
