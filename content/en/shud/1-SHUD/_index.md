---
# Page title
title: The Simulator for Hydrologic Unstructured Domains

# Title for the menu link if you wish to use a shorter link title, otherwise remove this option.
linktitle: 1. SHUD

# Page summary for search engines.
summary: Introduction of the SHUD Model

# Date page published
date: 2020-11-23

# Academic page type (do not modify).
type: book

# Position of this page in the menu. Remove this option to sort alphabetically.
weight: 1

---

![](/media/shud_show.png)

## Formulation and results of SHUD

- SHUD is a physically-based model, in which all equations used to emerge from the physics behind the hydrological processes within a catchment. The physical model can predict the water in an ungaged water system.  SHUD represents the spatial heterogeneity that influences the hydrology of the region. Consequently, it is practical to couple the SHUD model with models from biochemistry, reaction transport, geomorphology, limnology and other related research areas.
- SHUD is a fully-coupled hydrological model, where the conservative hydrological fluxes are calculated within the same time step. The state variables are the height of ponding water on the land surface, soil moisture, groundwater level, and river stage, while fluxes are infiltration, overland flow, groundwater recharge, lateral groundwater flow, river discharge, and exchange between river and cells.
- The global ODE system solved in SHUD integrates all local ODE systems over the domain and solves with a state-of-the-art parallel ODE solver known as CVODE (Hindmarsh et al., 2005) developed at the Lawrence Livermore National Laboratory.
- SHUD permits adaptable temporal and spatial resolution. The spatial resolution of the model varies from cen- timeters to kilometers based on modeling requirements computing resources. The internal time step of the iteration is adjustable; it can export the status of a catchment at time-intervals from a minutes to days. The flexible spatial and temporal resolution of the model is valuable for community model coupling.
- SHUD can estimate either a long-term hydrological yield or a single-event flood.
- SHUD is an open-source model --- anyone can access the source code and submit their modifications/improvements.

## Standing on the shoulders of giants

### Brief history of PIHM
The conceptual structure of the two-state integral-balance model for soil moisture and groundwater dynamics is devised by (Duffy, 1996), in which the partial volumes occupied by unsaturated and saturated moisture storage were integrated di- rectly upon local conservation equation. This two-state integral-balance structure simplified the hydrological dynamics while preserving the natural spatial and temporal scales contributing to runoff response. Brandes et al. (1998) use FEMWATER to realize the numeric calculation of inflow/outflow behavior within a hillslope-stream scheme. In 2004, Qu (2004) embedded the evapotranspiration and river network, and released Penn State Integrated Hydrologic Model (PIHM) v1.0, which is the most important milestone of the two-state integral-balance model. Since PIHM v1.0 (Qu, 2004), the PIHM is a generic hydrological model applicable to various watersheds or basins. After that, PIHM v2.0 (Kumar et al., 2009; Kumar and Duffy, 2009) enhance the land surface modeling. A GIS-tool, PIHMgis(Bhatt et al., 2014) and the Essential Terrestrial Variables Data Server (HydroTerre Leonard and Duffy (2013)) dramatically motivated the model deployment and applications with PIHM. Because of the sophisticated hydrological modeling and efficient spatial representative of PIHM, various model coupling project ini- tialized. For example, Flux-PIHM coupled the NOAH Land Surface Model into PIHM to calculate more details in energy balance and evapotranspiration (Shi et al., 2015, 2014). Zhang et al. (2016) coupled the landscaping evolution with PIHM (LE-PIHM). Bao (Bao, 2016; Bao et al., 2017) coupled the reaction transport module with PIHM (RT-PIHM, RT-Flux-PIHM). Flux-PIHM-BGC (Shi et al., 2018) coupled the biogeochemistry into Flux-PIHM. The Multi-Module PIHM (MM-PIHM) project (https://github.com/PSUmodeling/MM-PIHM) planned to build a uniform repository for all coupled modules. Still, more PIHM coupling projects are ongoing, such as sediments, lakes, crops, etc.. In addition, a finite volume-based integrated hydrologic modeling (FIHM) was developed (Kumar et al., 2009), which used second-order accuracy and solved 2D unsteady overland flow and 3D subsurface flow. Figure 1 shows the family tree of PIHM and SHUD. Every revision/branch received cross-pollination from others. Although PIHM and SHUD share the same fundamental conceptual two-state integral model, both the input/output are incompatible. Details of differences between them are summarised in the last section of this paper.

![Figure_tree](/Fig/Figure_tree.png)
Figure 1 The family tree of PIHM and SHUD. PIHM and SHUD share the same fundamental conceptual model, but use different realization. The PIHMgis and rSHUD are GIS-tools for pre- and post-processing.

###  Differences from PIHM

As a descendent of PIHM, SHUD inherits the fundamental idea of solving hydrological variables in CVODE. The code has been completely rewritten in a new programming language, with a new discretization and corresponding improvements to the underlying algorithms, adapting new mathematical schemes and a new user-friendly input/output data format. Although SHUD is forked from PIHM’s track, SHUD still inherits the use of CVODE for solving the ODE system, but modernizes and extends PIHM’s technical and scientific capabilities. The major differences are following:

1. SHUD is written in C++, an object-oriented programming language with functionality to avoid risky memory leaks from C. Every functions in the code has been rewritten, so the functions, algorithm or data structure between SHUD and PIHM are incompatible.
2. SHUD implements a re-design of the calculation of water exchange between hill slope and river. The PIHM defines the river channel as adjacent to bank cells – namely, the river channel shares the edges with bank cells. This design leads to sink problems in cells that share one node with a starting river channel.
3. The mathematical equations used in infiltration, recharge, overland flow and river discharge are different among the two models. This change is so essential that the model results would be different with the same parameter set.
4. SHUD adds mass-balance control within the calculation of each layer of cells and river channels, critical for long-term or micro-scale hydrologic modeling.

We now briefly summarize the technical model improvements and technical capabilities of the model, compared to PIHM. This elaboration of the relevant technical features aims to assist future developers and advanced users with model coupling. Compared with PIHM, SHUD ...

- supports the latest implicit Sundial/CVODE solver up to version 5.0.0 (the most recent version at time of writing),
- supports OpenMP parallel computation,
- redesigns the data structures and algorithm with object-oriented programming (C++),
- supports human-readable input/output files and filenames,
- exposes unified functions to handle the time-series data, including forcing, leaf area index, roughness length, boundary conditions and melt factor,
- exports model initial condition at specific intervals that can be used for warm starts of continued simulation,
- automatically checks the range of physical parameters and forcing data,
- adds a debug mode that monitors potential errors in parameters and memory operations.
