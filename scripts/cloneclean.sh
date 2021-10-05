#!/bin/bash
#
# Title:      HandBrake
# Authors:    Holtzmann
# URL:        www.holtzflix.com.br
################################################################################

cloneclean() {
    # Outside Variables
    hdpath="/mnt"
    cleaner="600"

    # Remove empty directories
    find "/mnt/move" -mindepth 2 -type d -empty -delete
    #DO NOT decrease DEPTH on this, leave it at 3. Leave this alone!
    find "/mnt/Handbrake/" -mindepth 3 -type d \( ! -name syncthings ! -name .stfolder \) -empty -delete

    # Prevents category folders underneath the downloaders from being deleted, while removing empties from the import process.
    # This was done to address some apps having an issue if the category underneath the downloader is missing.
}

cloneclean