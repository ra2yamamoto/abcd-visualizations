# Arc Diagram of SHAP-Derived Interactions

This repository contains the code used to generate arc diagrams illustrating significant pairwise interactions between variables, as identified using SHAP (SHapley Additive exPlanations) values.

Arc diagrams were generated for both a set of parent variables and a set of child variables. The code for each set is in in separate folders. 

---

## Files

* **`Generating_Graph_SHAP_Values_Parent.ipynb` / `Generating_Graph_SHAP_Values_Child.ipynb`**

  * Python Jupyter notebook used to load SHAP interaction values.
  * Outputs two CSV files:

    * `vertex_df.csv`: nodes (variables) with metadata such as grouping/category.
    * `connections_df.csv`: significant edges (variable–variable pairs) with interaction strengths.

* **`plotting_parent_shap.R` / `plotting_child_shap.R`**

  * R script that imports the above CSVs.
  * Uses `igraph` and `ggraph` to generate a linear arc diagram.
  * Nodes are colored according to conceptual groupings (e.g., Family Dynamics, Anxiety, Child ADHD).
  * Saves the resulting figure as a high-resolution PNG.

---

## Dependencies

* **Python**: `pandas` (or equivalent model library).
* **R**: `ggraph`, `igraph`, `dplyr`.

---

## Notes

* Color mappings and node groupings are defined explicitly in the R script for transparency.