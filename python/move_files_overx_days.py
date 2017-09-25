# Description			: This will move all the files from the src directory that are over 190 days old to the destination directory.

import shutil
import sys
import time
import os

src = 'u:\\test'  # Set the source directory
dst = 'c:\\test'  # Set the destination directory

now = time.time()  # Get the current time
for f in os.listdir(src):  # Loop through all the files in the source directory
    if os.stat(f).st_mtime < now - 190 * 86400:  # Work out how old they are, if they are older than 190 days old
        if os.path.isfile(f):  # Check it's a file
            shutil.move(f, dst)  # Move the files
