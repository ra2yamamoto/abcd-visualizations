# Libraries
library(ggraph)
library(igraph)
library(RColorBrewer)
library(dplyr)

# setwd("...")
hierarchy <- read.csv("hierarchy_df.csv")
vertices <- read.csv("vertex_df.csv")
connect <- read.csv("connections_df.csv")

vertices <- vertices[-c(1:11), ]

vertices <- vertices[vertices$name != "perfectionist_p", ]
vertices <- vertices[vertices$name != "sugary_beverage_freq", ]

connect <- connect[connect$from %in% vertices$name & connect$to %in% vertices$name, ]

unique(vertices$group)

# Calculate vertex degrees and reorder vertices
temp_graph <- graph_from_data_frame(connect, vertices = vertices, directed = FALSE)
vertex_degrees <- degree(temp_graph)
vertices$degree <- vertex_degrees[vertices$name]
vertices <- vertices %>% arrange(desc(degree))

# Calculate label positions and angles based on degree order
vertices$id <- seq_len(nrow(vertices))
nleaves <- nrow(vertices)
vertices$angle <- 90 
vertices$hjust <- 1 

# Create the graph with the reordered vertices
mygraph <- graph_from_data_frame(connect, vertices = vertices, directed = FALSE)

# Define colors
color_list <- list(
  "Family Dynamics & Parenting"                = "#ff7f0e",  # Orange (existing)
  "Anxiety"                             = "#d62728",  # Dark red (existing)
  "Impulsivity and Behavior Regulation" = "#E6B800",  # Dark gold (parent ADHD-related)
  "Child ADHD"                                 = "#F0E442",  # Bright yellow (existing)
  "Other Psychopathology "              = "#9c88ff",  # Lavender (distinct for "other")
  "Somatic Problems"                    = "brown", 
  "Residential Characteristics"                = "#8c564b",  # Brown (existing)
  "Cognitive and Attention Issues"      = "#FFD700",  # Gold (aligned with Child ADHD)
  "Delta Psychopathology"               = "#c5b0d5",  # Light purple (existing Parent Delta)
  "Child Mood"                                 = "#1f77b4",   # Blue (matches Child Mood Issues)
  "Child Other Personality Features" = "purple",  # Cyan, a broad neutral choice CHANGE
  "Child Diet/Nutrition" = "#17becf",  # Cyan, representing freshness and water CHANGE
  "Externalising" = "green",
  "Personality" = "#9467bd"  # Purple, aligning with broad personality traits
)

unique(vertices$group)

# Create the plot
p2 <- ggraph(mygraph, layout = "linear") + 
  scale_x_continuous(expand = c(0.2, 0)) +  # Add space around the plot
  scale_y_continuous(expand = c(2, 0)) +
  theme_void() +
  theme(
    plot.margin = unit(c(0, 0, 0, 0), "cm")
  ) +
  geom_edge_arc(
    aes(alpha = value * 0.05),
    edge_colour = "blue",
    edge_alpha = 0.3,
    edge_width = 0.5
  ) +
  geom_node_point(aes(colour = group), size = 4, alpha = 0.7) +
  geom_node_text(
    aes(y = y - 1, label = name, color=group, angle = angle, hjust = hjust),
    size = 3,
    alpha = 1
  ) 
  
p2 <- p2 + scale_color_manual(values = color_list)

print(p2)

ggsave("plot_highres.png", plot = p2, width = 12, height = 8, dpi = 600)

