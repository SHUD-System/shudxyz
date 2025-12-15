---
# Page title
title: SHUD modeling system

# Title for the menu link if you wish to use a shorter link title, otherwise remove this option.
linktitle: Overview

# Page summary for search engines.
summary: Overview of the SHUD modeling system.

# Date page published
date: 2021-02-01

# Academic page type (do not modify).
type: book

# Position of this page in the menu. Remove this option to sort alphabetically.
weight: 1
---

**The User Guide of SHUD model:**
[html<i class="fas fa-external-link-alt"></i>](/Book_EN)


# Overview

The Simulator for Hydrologic Unstructured Domain  (SHUD - pronounced “SHOULD”) is a multi-process, multi-scale hydrological model where major hydrological processes are fully coupled using the semi-discrete **Finite Volume Method** (FVM).

SHUD encapsulates the strategy for synthesizing multi-state distributed hydrological models using the integral representation of the underlying physical process equations and state variables. As a heritage of **Penn State Integrated Hydrologic Model (PIHM)**, the SHUD model is a continuation of 16 years of PIHM modeling in hydrology and related fields since the release of its first PIHM version (Qu, 2004).

The SHUD’s design is based on a concise representation of a watershed and river basin’s hydrodynamics, which allows for interactions among major physical processes operating simultaneously, but with the flexibility to add or drop states/processes/constitutive relations depending on the objectives of the numerical experiment for research purpose.

![](/media/shud.png)

The SHUD is a distributed hydrological model in which the domain is discretized using an unstructured triangular irregular network (e.g., *Delaunay triangles*) generated with constraints (geometric and parametric). A local prismatic control volume is formed by the vertical projection of the Delaunay triangles forming each layer of the model. Given a set of constraints (river network, watershed boundary, elevation, and hydraulic properties), an *“optimized mesh”* is generated. The *“optimized mesh”* indicates the hydrological processes with the unstructured mesh can be calculated efficiently, stably and rationally (Farthing & Ogden, 2017; Vanderstraeten and Keunings, 1995; Kumar, Bhatt and Duffy, 2009). River volume cells are also prismatic, with trapezoidal or rectangular cross-section, and maintain the topological relation with the Delaunay triangles. The local control volumes encapsulate all equations to be solved and are herein referred to as the model kernel.


## Acknowledge

We deeply acknowledge the continuous scientific and financial support to the  SHUD development activities by following institutions:

- Chinese Academy of Sciences   
- Northwest Institute of Eco-Environment and Resources, Chinese Academy of Sciences  
- Pennsylvania State University
- University of California Davis
- National Science Foundation  
- United States Environmental Protection Agency
- The Defense Advanced Research Projects Agency   
