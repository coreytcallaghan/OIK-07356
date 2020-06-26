library(dplyr)
library(purrr)
library(ggplot2)
library(scales)
library(readr)
library(lubridate)
library(ape)
library(Rphylip)
library(phangorn)
library(phylobase)
library(phylosignal)
library(phytools)
library(tibble)
library(ggtree)
library(MuMIn)

# read in raw data
dat <- readRDS("Data/data.RDS")

# source some functions
source("R/global_functions.R")

# calculate relative urbanness
specurban <- dat %>%
  # relative urbanness
  mutate(relative_urbanness=log(urban_score)-lists_in_range_urban_score)

ggplot(specurban, aes(x=relative_urbanness))+
  geom_histogram(color="black", fill="lightblue", bins=40)+
  xlab("Relative urbanness")+
  ylab("Number of species")+
  theme_bw()+
  theme(axis.text=element_text(color="black"))

mean(specurban$relative_urbanness)
sd(specurban$relative_urbanness)
median(specurban$relative_urbanness)

# Now perform a test for phylogenetic signal analysis
trees <- ape::read.nexus("Data/treeru.nex")

str(trees)
plot(trees$tree_2971)

con_tree <- consensus.edges(trees,consensus.tree=consensus(trees, p=0.5, check.labels=TRUE))
str(con_tree)


# now do a phylogenetic signal analysis
phylo_dat <- specurban %>%
  dplyr::select(TipLabel, relative_urbanness) %>%
  distinct()

phylo_dat.2 <- phylo_dat %>%
  dplyr::select(relative_urbanness)

row.names(phylo_dat.2) <- phylo_dat$TipLabel #name rows so that it matches the tree

p4d <- phylo4d(con_tree, phylo_dat.2) #create phylobase object

ps <- phyloSignal(p4d,reps = 9999) #run calculation, p values a bit unstable at 999 reps

stats <- ps$stat %>%
  rownames_to_column(var="term") %>%
  mutate(value="Statistic")

p_values <- ps$pvalue %>%
  rownames_to_column(var="term") %>%
  mutate(value="P value")

phylo_sig_results <- bind_rows(stats, p_values) %>%
  round_df(., digits=4) %>%
  dplyr::select(1, 4:5, 7) %>%
  knitr::kable()

phylo_sig_results

# make a figure of this for supplementary material
# plot the intra annual variability on a tree
plasma_pal <- c(viridis::plasma(n = 12, direction=1))

ggtree(p4d, layout='circular', aes(color=relative_urbanness), 
       ladderize = FALSE, size=1)+
  scale_color_gradientn(colors=plasma_pal, 
                        name = "Relative urbanness:  ")+
  geom_tiplab(aes(angle=angle), size=2.5, color="black")+
  theme(legend.position = "bottom")

ggsave("phylo_tree_of_relative_urbanness.png", width=10, height=10, units="in")

# Weak evidence of phylogenetic signal, and the p-values are not significant
# therefore we will perform regular GLM analyses
# First one model for overall specialization
summary(glm(relative_urbanness ~ Overall_specialization, data=specurban))

# Now a model includin all the specialization indices
summary(glm(relative_urbanness ~ Diet + Foraging_behaviour + Foraging_substrate + 
              Habitat + Nesting_site, data=specurban))

# checking multicolinearity for independent variables.
car::vif(lm(relative_urbanness ~ Diet + Foraging_behaviour + Foraging_substrate + 
          Habitat + Nesting_site, data=specurban))

# Make figure 2 for the paper
# which is 6 panels, one for each specialization index
overall <- ggplot(specurban, aes(x=relative_urbanness, y=Overall_specialization))+
  geom_point(color="blue", alpha=0.4)+
  geom_smooth(method="lm", color="red")+
  theme_classic()+
  theme(axis.text=element_text(color='black'))+
  xlab("Relative urbanness")+
  ylab("Overall specialization")+
  ggtitle("A")+
  theme(axis.text=element_text(size=7))+
  theme(axis.title=element_text(size=9))

overall

diet <- ggplot(specurban, aes(x=relative_urbanness, y=Diet))+
  geom_point(color="blue", alpha=0.4)+
  geom_smooth(method="lm", color="red")+
  theme_classic()+
  theme(axis.text=element_text(color='black'))+
  xlab("Relative urbanness")+
  ylab("Diet specialization")+
  ggtitle("B")+
  theme(axis.text=element_text(size=7))+
  theme(axis.title=element_text(size=9))

diet

for_behavior <- ggplot(specurban, aes(x=relative_urbanness, y=Foraging_behaviour))+
  geom_point(color="blue", alpha=0.4)+
  geom_smooth(method="lm", color="red")+
  theme_classic()+
  theme(axis.text=element_text(color='black'))+
  xlab("Relative urbanness")+
  ylab("Foraging behaviour specialization")+
  ggtitle("C")+
  theme(axis.text=element_text(size=7))+
  theme(axis.title=element_text(size=9))

for_behavior

for_substrate <- ggplot(specurban, aes(x=relative_urbanness, y=Foraging_substrate))+
  geom_point(color="blue", alpha=0.4)+
  geom_smooth(method="lm", color="red")+
  theme_classic()+
  theme(axis.text=element_text(color='black'))+
  xlab("Relative urbanness")+
  ylab("Foraging substrate specialization")+
  ggtitle("D")+
  theme(axis.text=element_text(size=7))+
  theme(axis.title=element_text(size=9))

for_substrate

habitat <- ggplot(specurban, aes(x=relative_urbanness, y=Habitat))+
  geom_point(color="blue", alpha=0.4)+
  geom_smooth(method="lm", color="red")+
  theme_classic()+
  theme(axis.text=element_text(color='black'))+
  xlab("Relative urbanness")+
  ylab("Habitat specialization")+
  ggtitle("E")+
  theme(axis.text=element_text(size=7))+
  theme(axis.title=element_text(size=9))

habitat

nest_site <- ggplot(specurban, aes(x=relative_urbanness, y=Nesting_site))+
  geom_point(color="blue", alpha=0.4)+
  geom_smooth(method="lm", color="red")+
  theme_classic()+
  theme(axis.text=element_text(color='black'))+
  xlab("Relative urbanness")+
  ylab("Nesting site specialization")+
  ggtitle("F")+
  theme(axis.text=element_text(size=7))+
  theme(axis.title=element_text(size=9))

nest_site

# put the plots together

library(patchwork)

overall + diet + for_behavior + for_substrate + habitat + nest_site + plot_layout(ncol=3)

ggsave("OIK-07356.R1/Figure_2.jpg", dpi=300, width=7, height=5, units="in")

# do a model averaging using dredge
# and make a table with the models
mod <- glm(relative_urbanness ~ Diet + Foraging_behaviour + Foraging_substrate + 
              Habitat + Nesting_site, data=specurban, na.action="na.fail")

all_mods <- dredge(mod)

round_df(all_mods, digits=4)

write_csv(round_df(all_mods, digits=4), "model_selection_table.csv")

# selects all models with deltaAic < 4
top.models <- get.models(all_mods, subset=delta<4) 

# how many top models
length(top.models)

# model averages parameters
averaged_models <- model.avg(top.models)

summary(averaged_models)


# make a table S1
table_s1 <- specurban %>%
  dplyr::select(SCIENTIFIC_NAME, order, Family, Diet, Foraging_behaviour, Foraging_substrate, 
                Habitat, Nesting_site, Overall_specialization, urban_score, urban_score_sample,
                lists_in_range_urban_score, relative_urbanness)


#write_csv(table_s1, "table_s1.csv")
