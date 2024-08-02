---
# Page title
title: rSHUD

# Title for the menu link if you wish to use a shorter link title, otherwise remove this option.
linktitle: 2. rSHUD

# Page summary for search engines.
summary: A R package to boost SHUD modeling

# Date page published
date: 2020-11-23

# Academic page type (do not modify).
type: book

# Position of this page in the menu. Remove this option to sort alphabetically.
weight: 20

---



Source code of rSHUD is available via [https://github.com/SHUD-System/rSHUD](https://github.com/SHUD-System/rSHUD)

This package can be used with the AutoSHUD project, that can build modeling domain automatically.

## Purpose of the package:
1. convert the geospatial data into SHUD format. The tool kit is able to process the raster and vector data, then building the unstructured triangular mesh domain for SHUD.
2. Write/read the SHUD input files.
3. Read the SHUD output files.
4. Generate the calibration parameter set.
5. Time-Series analysis on hydrologic data
6. 2D/3D plot.
7. GIS analysis. Convert the unstructure data into spatial data (Shapefile or Raster)
8. Download the USGS hydrological data, including discharge, ground water well, sediment, etc.


## Installation
```
install.packages("devtools")
devtools::install_github("SHUD-System/rSHUD")
```

## Note:
Current rSHUD requires different version of RTriangle package. you must install that via github (Dec 2019):
```
install.packages("devtools")
devtools::install_github("shulele/RTriangle", subdir="pkg")
```
