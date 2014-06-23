Getting-and-Cleaning-Data-Course-Project
========================================

Script for Creating Tidy Dataset from Human Activity Recognition Using Smartphones (HAR) Dataset


Dependencies
------------

The script was developed in RStudio Version 0.98.507 which bundles R 3.1.0, and should run
properly with any similar / compatible version of R.

The script requires the following packages:

  - data.tables
  - reshape2


Instructions for running the script
-----------------------------------

1. Copy the script into the top-level directory where the HAR data have been extracted
2. Run the "har.create.and.write.datasets()" function (optionally) supplying the name of the CSV file to be created


Output Produced
---------------

A "wide" version of the tidy averaged measurements data are produced by default.  However, the script
will produce a "molten" (narrow) version of the dataset if the call to the method "har.build.tidy.agg.molten"
in the function "har.create.and.write.datasets" is un-commented before running it.

See the CodeBook.md file for documentation of the dataset produced by this script.


