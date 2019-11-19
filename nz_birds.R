rm(list=ls())
setwd('/Users/jack/Box/Documents/tidy_tuesday/11_19_2019/')

install.packages('readr')
library(readr)
library(dplyr)
library(viridisLite)
install.packages('devtools')
library(devtools)
devtools::install_github("katiejolly/nationalparkcolors")
library(nationalparkcolors)
library(ggplot2)


# Data for reading special characters:
Sys.setlocale("LC_ALL", "German")
options(encoding = "UTF-8")

# Set color palette for plots:
my_palette <- park_palette('GeneralGrant')

# Read in data:
nz_bird <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-19/nz_bird.csv")


str(nz_bird)
nz_bird$bird_breed <- as.factor(nz_bird$bird_breed)
levels(nz_bird$bird_breed)
nz_bird <- na.omit(nz_bird)

votes1 <- nz_bird %>%
  filter(vote_rank == 'vote_1') %>%
  group_by(bird_breed) %>%
  summarise(total = n())
str(votes1)
votes1 <- arrange(votes1, desc(total))
top_votes_1 <- votes[1:8,]
str(top_votes)

cairo_pdf('birds.pdf', height = 4, width = 4)
votes_1_plot <- ggplot(top_votes_1, aes(x = bird_breed, y = total, fill = bird_breed))+
  geom_bar(stat = 'identity')+
  scale_fill_manual(values = my_palette)+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = 'black'),
        axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = 'none')+
  scale_y_continuous(expand = c(0,0))+
  ggtitle('Vote Rank 1')+
  xlab('Bird Breed')+
  ylab('Number of Votes')
votes_1_plot
dev.off()
