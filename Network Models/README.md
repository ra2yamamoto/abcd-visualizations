# Cross-Lagged Panel Modeling (CLPN)

This folder contains scripts implementing cross-lagged panel network models of ABCD data.
The analyses estimate longitudinal networks of symptom domains using LASSO-regularized regressions across multiple assessment waves.

All scripts follow a similar analytic pipeline, with the child version spanning four timepoints and the parent and parent and child spanning three.

---

## Scripts

* **`parent clpm.Rmd`**

  * Models parent symptom domains.
  * Uses three timepoints (baseline, 2-year, 4-year follow-up).
  * Outputs edge weights, centrality metrics, plots, and bootstrap stability results.

* **`parent and child clpm.Rmd`**

  * Models combined parent and child symptom domains.
  * Uses three timepoints (baseline, 2-year, 4-year follow-up).
  * Outputs edge weights, centrality metrics, plots, and bootstrap stability results.

* **`child clpm.Rmd`**

  * Models child symptom domains.
  * Uses the first four assessment waves (baseline, 1-year, 2-year, 3-year follow-ups).
  * Differs slightly in data loading (loads a file extracted in a different format), but the analytic steps are otherwise parallel.
  * Outputs edge weights, centrality metrics, plots, and bootstrap stability results.

---

## Analysis Pipeline

1. **Data Preparation**

   * Load ABCD symptom data.
   * Reshape to wide format for the selected timepoints.
   * Restrict to subjects with complete data.

2. **Model Fitting**

   * Fit cross-validated LASSO regressions for each transition between waves.
   * Extract autoregressive and cross-lagged effects.
   * Construct adjacency matrices.

3. **Network Analysis**

   * Build directed weighted networks.
   * Compute centrality metrics (In/Out-strength, Betweenness, Closeness).
   * Export edge weights and centrality results to CSV.

4. **Visualization**

   * Plot network structures for each transition.
   * Plot centrality trajectories across waves.
   * Save plots as high-resolution PNGs.

5. **Robustness / Bootstrapping**

   * Nonparametric bootstrap (n=1000).
   * Case-dropping bootstrap (n=2500).
   * Assess stability of edge weights and centrality.
   * Save bootstrap results to `boot_data/` and plots to `boot_photos/`.

---

## Dependencies

* **R packages**:

  * `glmnet` (LASSO regression)
  * `qgraph` (network estimation + visualization)
  * `bootnet` (bootstrap stability)
  * `dplyr`, `tidyr`, `readr` (data handling)
  * `doParallel` (parallelized cross-validation)

---

## Outputs

* **Network plots**
* **Centrality plots**
* **Edge weights** (`network_edge_values_*.csv`)
* **Centrality metrics** (`network_centrality_metrics_*.csv`)
* **Bootstrap results** (`boot_data/*.RData`, `boot_photos/*.png`)