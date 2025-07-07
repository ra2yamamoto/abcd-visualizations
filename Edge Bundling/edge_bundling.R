# Libraries
library(ggraph)
library(igraph)
library(RColorBrewer)

# setwd("...")
hierarchy <- read.csv("hierarchy_df.csv")
vertices = read.csv("vertex_df.csv")
connect = read.csv("connections_df.csv")

# ---- Explicit ordering for category groups ----
category_order <- c(
  "Residential Characteristics",
  "Ethnicity/Nationality",
  "Diet/Nutrition",
  "Physical Activity/Features",
  "Technology Use",
  "Religion",
  "Family Dynamics & Parenting",
  "Parent Social Functioning",
  "Social Relationship Quality",
  "School Dynamics",
  "Cognitive Task Outcomes",
  "Dynamic Cognitive Control Parameters",
  "Adverse Life Events",
  "Sleep Problems",
  "Medical/Somatic Problems",
  "Externalizing",
  "ADHD",
  "Anxiety",
  "Other Personality Features",
  "Child Mood Issues",
  "Child Delta",
  "Parent Delta",
  "Parent Mood Issues",
  "Parent Anxiety",
  "Parent Cognitive and Attention Issues",
  "Parent Personality",
  "Family Drug Use",
  "SES & Mobility"
)

# Convert group column to factor with explicit ordering
vertices$group <- factor(vertices$group, levels = category_order)

vertices <- vertices[order(vertices$group),]

vertices$id <- NA
myleaves <- which(is.na( match(vertices$name, hierarchy$from) ))
nleaves <- length(myleaves)
vertices$id[ myleaves ] <- seq(1:nleaves)
vertices$angle <- 90 -360 * vertices$id / nleaves

# calculate the alignment of labels: right or left
# If I am on the left part of the plot, my labels have currently an angle < -90
vertices$hjust <- ifelse( vertices$angle < -90, 1, 0)

# flip angle to make them readable
vertices$angle <- ifelse(vertices$angle < -90, vertices$angle+180, vertices$angle)

mygraph <- graph_from_data_frame(hierarchy, vertices = vertices)

from <- match(connect$from, vertices$name)
to <- match(connect$to, vertices$name)

vertices$type[vertices$type == ""] <- "Other"

# Basic plot setup
p <- ggraph(mygraph, layout = 'dendrogram', circular = TRUE) +
  scale_x_continuous(expand = c(0.2, 0)) +  # Add space around the plot
  scale_y_continuous(expand = c(0.2, 0)) +
  theme_void() # +  # Use a minimal theme for better visualization
  theme(plot.margin = unit(c(6, 6, 6, 6), "cm"))

# Add edges with a fixed color
for (i in seq_along(from)) {
  if (connect$value[i] > 0) {
    p <- p + geom_conn_bundle(
      data = get_con(from = from[i], to = to[i]),
      alpha = abs(connect$value[i]) * 0.25,
      width = 1,
      tension = 1,
      color = "blue"  # Fixed color for edges
    )
  } else {
    p <- p + geom_conn_bundle(
      data = get_con(from = from[i], to = to[i]),
      alpha = abs(connect$value[i]) * 0.25,
      width = 1,
      tension = 1,
      color = "red"  # Fixed color for edges
    )
  }
}

# Add nodes with colors determined by group
p <- p + 
  geom_node_text(aes(x = x*1.06, y=y*1.06, filter = leaf, label=name, angle = angle, hjust=hjust, color = group), size=1.7, alpha=1) +
  geom_node_range(
  aes(
    filter = leaf,
    x = x,
    xend = x * 1.05,
    y = y,
    yend = y * 1.05,
    colour = group  # Map `group` to node colors
  ),
  linewidth = 1
)

color_list <- list(
  "Residential Characteristics" = "#8c564b",  # Brown, representing physical spaces
  "Ethnicity/Nationality" = "#bcbd22",  # Olive, as a neutral cultural color
  "Diet/Nutrition" = "#17becf",  # Cyan, representing freshness and water
  "Physical Activity/Features" = "#2ca02c",  # Green, associated with movement and health
  "Technology Use" = "#7f7f7f",  # Gray, neutral and modern
  "Religion" = "#9467bd",  # Purple, often associated with spirituality
  "Parent Delta" = "#c5b0d5",  # Light purple, related to changes in personality/behavior
  "Parent Mood Issues" = "#1f77b4",  # Blue, linking to mood/depression
  "Parent Anxiety" = "#d62728",  # Red, aligning with anxiety
  "Parent Cognitive and Attention Issues" = "#ffbb78",  # Orange, linking to focus/attention
  "Parent Personality" = "#9467bd",  # Purple, aligning with broad personality traits
  "Family Dynamics & Parenting" = "#ff7f0e",  # Orange, warm and nurturing
  "Parent Social Functioning" = "#d62728",  # Dark red, linking to social/emotional interactions
  "Social Relationship Quality" = "#e377c2",  # Pink, linked to connection and relationships
  "School Dynamics" = "#1f77b4",  # Blue, representing structure and learning
  "Cognitive Task Outcomes" = "#7f7f7f",  # Gray, neutral for performance measures
  "Dynamic Cognitive Control Parameters" = "#20B2AA",  # Teal, representing adaptive control and flexibility
  "Adverse Life Events" = "#d62728",  # Dark red, representing hardship
  "Sleep Problems" = "#1a55FF",  # Dark blue, associated with night and sleep
  "Medical/Somatic Problems" = "#8c564b",  # Brown, grounded and bodily health
  "Externalizing" = "#ff9896",  # Light red, linked to behavioral outbursts
  "ADHD" = "#F0E442",  # Yellow, highlighting attention/impulsivity
  "Anxiety" = "#d62728",  # Red, linked to alertness and stress
  "Other Personality Features" = "#17becf",  # Cyan, a broad neutral choice
  "Child Mood Issues" = "#1f77b4",  # Blue, linked to Mood/Depression
  "Child Delta" = "#aec7e8",  # Light blue, conceptual variation of mood
  "Family Drug Use" = "#e377c2",  # Pink, associated with behavioral/social risk
  "SES & Mobility" = "#bcbd22" #,  # Olive, representing socioeconomic movement
  # "Low Mood" = "#4c72b0",
  # "Delta" = "#a6bddb",  # Light blue, maintaining consistency with mood-related changes  
  # "Family Psychopathology & Well-Being" = "#e377c2",  # Pink, linking to behavioral and emotional health  
  # "None" = "black"
)

# Add node color scale and legend
p <- p + scale_colour_manual(
  values = color_list # Assign colors for groups
)
sum(is.na(vertices$group))

# Display the plot
p <- p + theme(legend.position = "none") # comment to show legend

# print(p)
ggsave("plot_highres.png", plot = p, width = 9, height = 9, dpi = 600)