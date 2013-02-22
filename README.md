dup9patch
=========

Duplicate 9-patch image frame to other images (of the same size)

This script duplicates the 9-patch information from an 9-patch image to a directory of "normal" (not-9-patched) images.
Obviously the images must be all of the same kind (i.e.: size, scalable areas and fillable areas), otherwise
this utlility is unuseful.

The script takes three parameters:
 - the first parameter is the path of an image already (manually) 9-patched (default: "./9patch.9.png").
 - the second parameter is the path of a directory with un-patched images (default: "./in/").
 - the third parameter is the path of a directory where the patched images will be created (default: "./9patch/");
   if it doesen't exist it will be created.

Please feel free to suggest improvements or to report bugs or mistakes... :-)

Enjoy!

Marco Solari
<marcossolari at gmail dot com>
