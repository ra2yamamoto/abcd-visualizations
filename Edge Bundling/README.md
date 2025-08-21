# Edge Bundling Graph of Pairwise Correlations

This repository contains the code used to generate a hierarchical edge bundling plot of pairwise correlations between variables in the ABCD dataset.

---

## Files

* **`Generating_Edge_Bundling_Graph.ipynb`**

  * Python Jupyter notebook that computes pairwise correlations among variables.
  * Filters for correlations >=0.25.
  * Exports three dataframes to CSV:

    * `hierarchy_df.csv`: hierarchical structure specifying category groupings.
    * `vertex_df.csv`: nodes (variables) with metadata such as grouping.
    * `connections_df.csv`: edges (variable–variable correlations, with sign and strength).

* **`edge_bundling.R`**

  * R script that imports the CSVs produced by the notebook.
  * Uses `igraph` and `ggraph` to construct a circular hierarchical edge bundling diagram.
  * Positive correlations are drawn in blue, negative correlations in red, with transparency scaled by strength.
  * Nodes are arranged by predefined group order and colored by category.
  * Outputs the final plot as a high-resolution PNG (`plot_highres.png`).

---

## Dependencies

* **Python**: `pandas`, `numpy`.
* **R**: `ggraph`, `igraph`.

---

## Notes

* Group ordering, category colors, and labeling conventions are explicitly defined in the R script.
* Edge transparency and color encode the strength and direction of correlations.