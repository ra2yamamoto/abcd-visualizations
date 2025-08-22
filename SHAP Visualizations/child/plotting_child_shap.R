# Libraries
library(ggraph)
library(igraph)
library(dplyr)

setwd("/Users/Raphael/Desktop/GabLab/ABCD/code for submission testing run/SHAP Visualizations/child")
vertices <- read.csv("vertex_df.csv")
connect <- read.csv("connections_df.csv")

# Keep only edges whose endpoints exist in the current vertex set
connect <- connect[connect$from %in% vertices$name & connect$to %in% vertices$name, ]

# Calculate vertex degrees and reorder vertices by decreasing number of connections
temp_graph <- graph_from_data_frame(connect, vertices = vertices, directed = FALSE)
vertex_degrees <- degree(temp_graph)
vertices$degree <- vertex_degrees[vertices$name]
vertices <- vertices %>% arrange(desc(degree))

# Create the graph with the reordered vertices
mygraph <- graph_from_data_frame(connect, vertices = vertices, directed = FALSE)

# Define colors
color_list <- list(
  "Residential Characteristics" = "#8c564b",  # Brown, representing physical spaces
  "Ethnicity/Nationality" = "#bcbd22",  # Olive, as a neutral cultural color
  "Diet/Nutrition" = "#17becf",  # Cyan, representing freshness and water
  "Physical Activity/Features" = "#2ca02c",  # Green, associated with movement and health
  "Technology Use" = "#7f7f7f",  # Gray, neutral and modern
  "Religion" = "#9467bd",  # Purple, often associated with spirituality
  "Family Dynamics & Parenting" = "#ff7f0e",  # Orange, warm and nurturing
  "Parent Social Functioning" = "#d62728",  # Dark red, linking to social/emotional interactions
  "Social Relationship Quality" = "orange", 
  "School Dynamics" = "#1f77b4",  # Blue, representing structure and learning
  "Adverse Life Events" = "#d62728",  # Dark red, representing hardship
  "Cognitive Task Outcomes" = "#7f7f7f",  # Gray, neutral for performance measures
  "Sleep Problems" = "#1a55FF",  # Dark blue, associated with night and sleep
  "Medical/Somatic Problems" = "#8c564b",  # Brown, grounded and bodily health
  "Externalizing" = "green", 
  "ADHD" = "#F0E442",  # Yellow, highlighting attention/impulsivity
  "Anxiety" = "#d62728",  # Red, linked to alertness and stress
  "Other Personality Features" = "purple",  # Cyan, a broad neutral choice
  "Child Mood Issues" = "#1f77b4",  # Blue, linked to Mood/Depression
  "Child Delta" = "#aec7e8",  # Light blue, conceptual variation of mood
  "Parent Delta" = "#c5b0d5",  # Light purple, related to changes in personality/behavior
  "Parent Mood Issues" = "#1f77b4",  # Blue, linking to mood/depression
  "Parent Anxiety" = "#d62728",  # Red, aligning with anxiety
  "Parent Cognitive and Attention Issues" = "#ffbb78",  # Orange, linking to focus/attention
  "Parent Personality" = "#9467bd",  # Purple, aligning with broad personality traits
  "Family Drug Use" = "#e377c2",  # Pink, associated with behavioral/social risk
  "SES & Mobility" = "#bcbd22", # Olive, representing socioeconomic movement
  # "Low Mood" = "#4c72b0",
  # "Delta" = "#a6bddb",  # Light blue, maintaining consistency with mood-related changes  
  "Family Psychopathology & Well-Being" = "#e377c2"  # Pink, linking to behavioral and emotional health  
  # "None" = "black" 
)

# Create the plot
p2 <- ggraph(mygraph, layout = "linear") + 
  scale_x_continuous(expand = c(0.2, 0)) +  # Add space around the plot
  scale_y_continuous(expand = c(2, 0)) +
  theme_void() +
  theme(
    plot.margin = unit(c(0, 0, 0, 0), "cm")
  ) +
  geom_edge_arc(
    edge_colour = "blue",
    edge_alpha = 0.3,
    edge_width = 0.5
  ) +
  geom_node_point(aes(colour = group), size = 4, alpha = 0.7) +
  geom_node_text(
    aes(y = y - 1, label = name, color=group),
    angle = 90, 
    hjust = 1,
    size = 3,
    alpha = 1,
    show.legend = FALSE
  ) 
  
p2 <- p2 + scale_color_manual(values = color_list)

# print(p2)

ggsave("plot_highres.png", plot = p2, width = 12, height = 8, dpi = 600)

