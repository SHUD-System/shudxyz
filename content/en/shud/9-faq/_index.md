---
# Page title
title: FAQ

# Title for the menu link if you wish to use a shorter link title, otherwise remove this option.
linktitle: 5. FAQ

# Page summary for search engines.
summary: FAQ

# Date page published
date: 2020-02-23

# Academic page type (do not modify).
type: book

# Position of this page in the menu. Remove this option to sort alphabetically.
weight: 999
---

## The SHUD model
* **Why the model uses Unstructured grids instead of regular/orthogonal grids?**

  The unstructured grids benefit specific scientific or practical model purposes:

  - In general, the number of cells in unstructured grids is less than regular grids.
  - The unstructured grids are opting to represent the heterogeneity of terrestrial properties, including elevation, slope, soil, and land use, rather than regular grids. The particular points and edges in the terrestrial map can be assigned during mesh generation, but it is hard to be adapted in regular grids.
  - Unstructured grids are so flexible that the size of cells can be adjusted based on modeling purposes. For example, when the modeler needs more details on a certain area of a large watershed, he/she can give fine resolution in the research area, but the coarser resolution of the rest of the watershed while keeping the interaction between fine and coarse resolution areas.
  - Unstructured grids are more natural and more suitable to represent the complex boundary (such as watershed boundary) than the regular grids. When the modeling domain is of the irregular and complex boundary, regular grids have to use high resolution everywhere to represent the boundary that increases computing burden.

  Reference: [https://en.wikipedia.org/wiki/Grid_classification](https://en.wikipedia.org/wiki/Grid_classification)

* **What is the difference between SHUD and PIHM model?**

   As a descendant of PIHM, SHUD inherits the fundamental idea of conceptual structure and solving hydrological variables in CVODE.  The code has been completely rewritten in a new programming language, with a new discretization and corresponding improvements to the underlying algorithms,  adapting new mathematical schemes and a new user-friendly input/output data format. Although SHUD is forked from PIHM's track, SHUD still inherits the use of CVODE for solving the ODE system but modernizes and extends PIHM's technical and scientific capabilities.

   The major differences are the following:

   - SHUD is written in C++, an object-oriented programming language with functionality to avoid risky memory leaks from C. Every function in the code has been rewritten, so the functions, algorithm or data structure between SHUD and PIHM are incompatible.
   - SHUD implements a redesign of the calculation of water exchange between hillslope and river.  The PIHM defines the river channel as adjacent to bank cells -- namely, the river channel shares the edges with bank cells.  This design leads to sink problems in cells that share one node with a starting river channel.
   - The mathematical equations used in infiltration, recharge, overland flow and river discharge are different among the two models. This change is so essential that the model results would be different with the same parameter set.
   - SHUD adds mass-balance control within the calculation of each layer of cells and river channels, critical for long-term or micro-scale hydrologic modeling.
   - Either inner data structure or external input/output formats are different. The inner data structure indicates the organization of data, parameters and operations within the program, as well as the strategy to connect the various procedures in the program. The format of input files for SHUD model is upgraded to a series of straightforward and user-friendly formats. The output of SHUD model supports both ASCII and Binary format. Particularly, the binary format is efficient in writing and post-processing.

    We now briefly summarize the technical model improvements and technical capabilities of the model, compared to PIHM. This elaboration of the relevant technical features aims to assist future developers and advanced users with model coupling.
   Compared with PIHM, SHUD ...

   - supports the latest implicit Sundial/CVODE solver up to version 5.0.0 (the most recent version at the time of writing),
   - supports OpenMP parallel computation,
   - redesigns the program with object-oriented programming (C++),
   - supports human-readable input/output files and filenames,
   - exposes unified functions to handle the time-series data, including forcing, leaf area index, roughness length, boundary conditions and melt factor,
   - exports model initial condition at specific intervals that can be used for warm starts of continued simulation,
   - automatically checks the range of physical parameters and forcing data,
   - adds a debug mode that monitors potential errors in parameters and memory operations.
* **What kind of data is needed for SHUD model simulation?**

   * Spatial Data: Elevation, watershed boundary, river network, soil map, geology map, landuse and coverage of forcing data.
   * Attributes table: Soil/geology properties, the geometry of rivers, land use parameters
   * Time-series: Forcing data (precipitation, temperature, relative humidity, wind speed, shortwave radiation), Leaf Area Index (LAI), roughness length, melting factor.

   The rSHUD can provide some of the data with default values. The detail can be found in the User Manual [https://www.shud.xyz/Book_CN/](https://www.shud.xyz/Book_CN/).
* **What the suitability and suitable region of the SHUD model in the world?**

   The SHUD model is very adaptive; it can be used widely for research and practical purposes.

   The smallest modeling experiment is numerical modeling of Vauclin Experiment that is in a $ 2m * 3m * 0.05 m $ ($ H \times L \times W $), the top area is only $ 0.1 m^2​$.

   The largest watershed modeling is 40-year groundwater and water availability research in Sacramento Watershed (700,000 $km^2$).  The model takes about one hour to simulate a year when the mean area of cells is ~$7 km^2​$.

   Some of the applications can be found via [https://www.shud.xyz/applications/](https://www.shud.xyz/applications/).


## SHUD program and installation
* **Where to access the source code of SHUD model?**

    The source code of SHUD is available on GitHub: [https://github.com/SHUD-System/SHUD](https://github.com/SHUD-System/SHUD).

* **What OS platform is required for SHUD model?**

    Since the source code of SHUD is written in standardized C++ Language, the program can be deployed on any platform as long as the user has a C++ compiler.  The compiling process requires the support of SUNDIANLS/CVODE libraries, so the user should install SUNDIALS/CVODE before compiling SHUD. The tutorial on installing SUNDIALS/CVODE can be found here: [https://www.shulele.net/en/post/20191119_sundials/](https://www.shulele.net/en/post/20191119_sundials/).

* **How to install SUNDIALS/CVODE?**

    SUNDIALS (https://computing.llnl.gov/projects/sundials) is a very powerful mathematical library that is helpful in solving engineering and scientific problems efficiently. CVODE is one of the suites, aiming to solve the Ordinary Differential Equation, in C language. SHUD requires the support of CVODE, so the user should install CVODE at least.

    Users can install CVODE with the help of the tutorial: [https://www.shulele.net/en/post/20191119_sundials/](https://www.shulele.net/en/post/20191119_sundials/).

    Besides this GUI installation, the user also can use the script `configure` in source code to install CVODE.

* **The performance of the SHUD model?**

    Normally, the performance of the model highly depends on resolution, lengths of river reaches, parameters set, terrestrial properties. For example, an 1100 cells watershed with area 192 $km^2$ takes about 5 hours to simulate 17 years. The simulation becomes slower under heavy rainfall events occurs than dry conditions.

* **How to utilized the parallelization of SHUD model?**

    Firstly, you have to install OpenMP library on your OS. Please confirm the `-fopen` flag works on your platform.

    Secondly, it is necessary to compile and install CVODE with OpenMP supports, use tutorials ([https://www.shulele.net/en/post/20191119_sundials/](https://www.shulele.net/en/post/20191119_sundials/)) as a reference.

* **The optimal size of triangular cells, or number of triangles for a simulation.**

    It highly depends on the modeler's purpose or scientific problems. The resolution can be $cm^2$ to $km^2$ based on data resolution, research problem, computational resources and performance requirement.

## rSHUD

* **How to install the rSHUD?**

   In R, you should install `devtools`, then install `rSHUD` via GitHub.

   ```
   install.packages("devtools")
   devtools::install_github("SHUD-System/rSHUD")
   ```

   Besides of the rSHUD, the user should install `RTriagle` via GitHub, instead of the version on CRAN.

   ```
   install.packages("devtools")
   devtools::install_github("shulele/RTriangle", subdir="pkg")
   ```

* **Is rSHUD available on R CRAN?**

   Not yet. CRAN requires a lot of details explanations of algorithms and functions; it takes lots of energy. I will submit the rSHUD to CRAN in the future.

* **Source code of rSHUD**

   Source code of rSHUD is available via [https://github.com/SHUD-System/rSHUD](https://github.com/SHUD-System/rSHUD)
