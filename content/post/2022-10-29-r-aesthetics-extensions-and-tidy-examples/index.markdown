---
title: R Aesthetics, Extensions, and Tidy Examples
author: Adam Sadowski
date: '2022-10-29'
slug: r-aesthetics-extensions-and-tidy-examples
categories: []
tags: []
subtitle: ''
summary: ''
authors: []
lastmod: '2022-10-29T22:08:43-04:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---





<!-- # Sections {.tabset .tabset-fade .tabset-pills} -->

# Aesthetics; why you want to abandon SAS {.tabset .tabset-fade}

## Skip using core R; use RStudio and use RMDs or R Notebooks {.tabset .tabset-fade .tabset-pills}

In RStudio, click topmost left File - New File - R Markdown (aka RMD) or R Notebook. Why this vs. R Script or SAS? For code chunks; compartmentalizes code and output.

### Shortcuts 

If on MAC subsitute Cmd for Cntrl:

- Cntrl-Alt-I to create a code chunk
- Cntrl-Left/Right Arrow to jump front/end of names
- Alt-Left/Right Arrow to jump to front/end of line
- Cntrl-Shift-3 for Help page within RStudio after typing `?command`, for example, `?library`
- Cntrl-Shift-1 for code view
- Cntrl-Shift-M for pipe `%>%` (more on this later)

### Libraries 

```r
# install.packages("package") or type library(package) and RStudio will ask up top do you want to install

library(tidyverse)
# tidyverse allows a tidier approach to coding; tidyverse.org has a book on getting started
library(broom)
# broom cleans up model output
library(ggplot2)
# ggplot2 (like tidyverse for graphs)
library(corrr)
library(xlsx)
library(geepack)
library(DT)
# DT for datatable: interactive table


```

### html/pdf/Word files using RMD 

The document you're looking at was made using RMD. Easy to share your work

## Base R vs. the predominant alternative approach of tidyverse 

https://b-rodrigues.github.io/modern_R/descriptive-statistics-and-data-manipulation.html

# Extensions: how far you can take R? {.tabset .tabset-fade .tabset-pills}
## Slides without PowerPoint GUI 

https://rmarkdown.rstudio.com/lesson-11.html

## Books without LaTeX GUI 
 
https://bookdown.org/

I am currently reading the R Shiny book.
 
## Interactive applications using "R Shiny" (software engineering) 

Simple and easy: https://hadley.shinyapps.io/basic-reactivity-cs/

Complex: https://shiny.rstudio.com/gallery/didacting-modeling.html

## Websites for free 

- Simple, minimal: https://adam.rbind.io/
- Simple, artsy: https://btb.netlify.app/
- Complex: https://alison.rbind.io/

## Plots that are flexible and much easier to code than SAS or base R 

https://www.r-graph-gallery.com/ggplot2-package.html

## Reading and writing large files fast using feather files vs. csv files 

https://blog.rstudio.com/2018/04/19/arrow-and-beyond/

## R can use Python code 

https://blog.rstudio.com/2018/03/26/reticulate-r-interface-to-python/#

## And more coming.. 

Functional programming is becoming more popular. purrr is a popular package for this (not for beginners):

https://purrr.tidyverse.org/

New packages are under development constantly. E.g. reprex 1.0 was announced 2 weeks ago. This is for creating reproducible examples (hence "reprex") that can be asked on StackOverflow e.g.

https://www.tidyverse.org/blog/2021/02/reprex-1-0-0/



# Examples {.tabset .tabset-fade .tabset-pills}

In J1 we will see that when googling, we should watch out for 

- 1) which approach is used and 
- 2) the date of the answer in relation to developments made over time in the approach

*Note: there may exist more elegant Base R solutions, but the take-home point is that they are not "tidy" and consequently not as easy to learn and remember!*

## Example 1 

```r
# dataframe example
df <- data.frame("names" = c("y1", "y2"), 
                 "x1" = 1:2, 
                 "x2" = 4:5)
df
```


**Q1) How to swap (transpose?) column and row data in the above data frame, i.e., change column headers to y1 and y2 and row headers to x1 and x2.**

```r
# base R
# pro approach problems

# google "r How to swap column and row data"
# first result gives this (top rated answer dated 2015): 
```
https://stackoverflow.com/questions/33643181/how-do-i-flip-rows-and-columns-in-r/33643244

```r
df2 <- data.frame(t(df[-1]))
colnames(df2) <- df[, 1]

# many problems: 
# depends on names coming from 1st column
# complexity ramps up if code is altered to allow you to specify the column "name" holding the names instead of 1 for first column
# not apparent what's going on; e.g. 3 things happening in one line, each with own set of brackets you need to keep track of
# a lot of shortcuts that you might not think to use until you know what to avoid: see next example of how I approached this
```

```r
# base R
# naive approach
tdf <- t(df)
df.tdf <- as.data.frame(tdf)
colnames(df.tdf) <- df.tdf[1, ]
df.tdf[, 3] <- row.names(df.tdf)
df.tdf <- df.tdf[-1, ]
row.names(df.tdf) <- NULL
names(df.tdf)[names(df.tdf) == "V3"] <- "names"
col.order <- c("names", "y1", "y2")
df.tdf <- df.tdf[, col.order]


# dplyr

df %>% 
    pivot_longer(c(x1, x2)) %>%
    pivot_wider(names_from = names) %>% 
    rename(names = name)

```

```r
# 
# see second google result (top rated answer dated 2017):
# describes the "tidy" approach, but the dplyr approach above is actually the most up-to-date tidy approach
# gather and spread still work but pivot_longer and pivot_wider are newly developed to be more clear
```

https://stackoverflow.com/questions/44400573/how-can-i-transpose-my-dataframe-so-that-the-rows-and-columns-switch-in-r


## Example 2 

```r
# dataframe example
df <- data.frame("names" = c("y1", "y2"), 
                 "x1" = 1:2, 
                 "x2" = 4:5)
df
```

**Q2) Take the largest number in each row and place it in a new column, x3.**

```r
# google
# dplyr maximum of each row
# first result 
# https://stackoverflow.com/questions/32978458/dplyr-mutate-rowwise-max-of-range-of-columns
# see use of
# %>% rowwise()
# or
# pmax

df %>%
  mutate(x3 = pmax(x1, x2))


```

## Example 3 

```r
mtcars
```

**Q) Commands to assess or describe distribution of variables (mean, median, standard deviation, standard error, IQR, etc)**

### Options {.tabset .tabset-fade}
#### Descriptive Stats 

```r
# one variable to summarize?

mtcars %>%
  group_by(am) %>%
  summarise(mean_mpg = mean(mpg),
            sd_mpg = sd(mpg),
            max_mpg = max(mpg),
            min_mpg = min(mpg))

# multiple variables to summarize?

mtcars %>%
  group_by(am) %>%
  summarise(across(is.numeric, 
                   list(mean = ~mean(.x),
                        sd = ~sd(.x), 
                        max = ~max(.x),
                        min = ~min(.x),
                        iqr = ~IQR(.x)),
                   .names = "{.col}.{.fn}"))
    

qs <- quantile(df$x1)
as.data.frame(qs)
```

```r
# note
# quantiles are values that divide an ordered set into K intervals
# quartiles are values that divide an ordered set into 4 intervals
# percentiles are simply quantiles where instead of referring to the Kth quantile (which is not usually informative), we refer to the percent of the set that falls under the quantile

# for example, these are uneven quantiles/percentiles

qs <- quantile(df$x1,  probs = c(0.1, 0.5, 1, 2, 5, 10, 50, NA)/100)

datatable(as.data.frame(qs))

```
#### Graphs {.tabset .tabset-fade .tabset-pills}


##### Base {.tabset .tabset-fade}

###### One variable 

```r
hist(mtcars$mpg)
```


###### One variable stratified 

```r
par(mfrow=c(1,2))
hist(mtcars$mpg[mtcars$am %in% 0])
with(mtcars, hist(mpg[am %in% 1]))
```

###### Every variable in a data frame 

Look at this mess!

```r
lapply(mtcars, hist)
```

##### ggplot {.tabset .tabset-fade}

Easy to expand into more advanced plots!

###### One variable 

```r
mtcars %>% 
  ggplot(aes(mpg)) +
  geom_histogram()
```

###### One variable stratified 
```r
mtcars %>% 
  ggplot(aes(mpg)) +
  geom_histogram() +
  facet_wrap(~am)
```

###### Every variable in a data frame 
```r
mtcars %>% 
  pivot_longer(everything()) %>%
  ggplot(aes(value)) +
  geom_histogram() +
  facet_wrap(~name, scales = "free")

```

###### Every variable in a data frame stratified 
```r
mtcars %>%
  pivot_longer(-am) %>%
  ggplot(aes(value)) +
  geom_histogram() +
  facet_wrap(~name + am, scales = "free")
```

###### Every variable in a data frame stratified v2 
```r
# easy to condense craziness

mtcars %>%
  pivot_longer(-am) %>%
  ggplot(aes(value)) +
  geom_histogram(aes(fill = factor(am)), position = "identity", alpha = 0.4) +
  facet_wrap(~name, scales = "free")

```

#### Correlations {.tabset .tabset-fade}


Great example of multiple packages made to address base R's limits:
- found this:
https://drsimonj.svbtle.com/exploring-correlations-in-r-with-corrr
- well-organized
- do some digging, find his twitter -> data science manager at facebook, corrr is tweeted dec. 2020, its being adopted by the tidyverse

- also found this:
http://www.sthda.com/english/wiki/correlation-matrix-a-quick-start-guide-to-analyze-format-and-visualize-a-correlation-matrix-using-r-software
mess
- no narrative, no apparent consistency between methods (note the first link has a title "...with corrr" suggesting a package named corrr), graphs are chaotic

But even the first link is not perfect; after being enamored by that fancy network plot in the first link, and trying to get it to only display correlations > x, I had to give up.. not everything works well!

##### Every possible correlation in a data set 
```r
mtcars %>% 
  correlate() %>% 
  shave() %>%
  rplot()
```

##### Every correlation > x 
```r
any_over_90 <- function(x) any(x > .9, na.rm = TRUE)

# dataset

mtcars %>% 
  correlate() %>% 
  select_if(any_over_90)


# graph; mutate with reorder causes column term to have factor levels in the order of mpg; makes the graph follow an increasing/decreasing order

mtcars %>% 
  correlate() %>%
  focus(mpg) %>%
 # mutate(term = reorder(term, mpg)) %>%
  ggplot(aes(term, mpg)) +
    geom_col() + coord_flip()

mtcars %>% 
  correlate() %>%
  focus(mpg) %>%
  mutate(term = reorder(term, mpg)) %>%
  ggplot(aes(term, mpg)) +
    geom_col() + coord_flip()

```

