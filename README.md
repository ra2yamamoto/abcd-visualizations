This repository contains code used to generate several figures included in the manuscript:

***“Hierarchical, Interactive, and Dynamic Predictive Capacity of Current Biological, Psychological, Social, and Environmental Measurements in Depression, Anxiety, ADHD, and Social Quality across the Lifespan”*** by *Clark Roberts, Raphael Yamamoto, Zhafira Fawnia, Percy Mistry, Issac N Treves, Alexandra Decker, Samantha N Sallie, Chris Chatham, Awais Aftab, Kim Lee, Madelynn Park, Vinod Menon, John Gabrieli* (2025, manuscript under review).

The scripts are provided to ensure transparency and reproducibility of the analyses. They are not intended as general-purpose software, but as documentation of how the published figures were created.

---

## Contents

The repository is organized by analysis type:

* **Cross-Lagged Panel Modeling (CLPN)**
  R scripts implementing cross-lagged panel network models of ABCD data, using LASSO regressions to estimate autoregressive and cross-lagged influences across assessment waves. Includes parent-only, child-only, and combined parent+child analyses.

* **Arc Diagrams of SHAP Interactions**
  Python and R scripts for generating linear arc diagrams of significant SHAP-derived interactions, visualizing pairwise relationships between variables in parent and child models.

* **Edge Bundling of Correlations**
  Python and R scripts for constructing hierarchical edge bundling plots of pairwise correlations between variables, highlighting the structure of positive and negative associations across domains.

---

## Dependencies

* **Python**:
  `pandas`, `numpy`, `shap` (for SHAP analyses), and standard modeling libraries.

* **R**:
  `igraph`, `ggraph`, `dplyr`, `glmnet`, `qgraph`, `bootnet`, `tidyr`, `readr`, `doParallel`.

---

## Outputs

Each script produces figure files (PNG) and supporting tables (CSV or RData). These include:

* Network plots and centrality trajectories from cross-lagged panel models.
* Arc diagrams of SHAP-derived interactions.
* Hierarchical edge bundling diagrams of pairwise correlations.
* Exported edge weights, centrality metrics, and bootstrap stability results.

---

## Contributions

- **Raphael Yamamoto** — primary code author: organized analysis pipeline and prepared visualizations.  
- **Clark Roberts** — secondary code author: conceptualization, methodological input, guidance on analytic design, analysis, and visualizations. 

## Correspondence

For questions about the code, please contact:

* **Clark Roberts** — \[email]
* **Raphael Yamamoto** — \[[ryamamoto@haverford.edu](mailto:ryamamoto@haverford.edu)]

## License
This code is released under the MIT License (see LICENSE for details).