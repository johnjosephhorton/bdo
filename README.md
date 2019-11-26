# Latent Semantic Indexing Example

This repo contains the R code to replicate the [Latent Semantic Indexing](https://en.wikipedia.org/wiki/Latent_semantic_analysis) example 
from Berry, Dumias  and O'Brien article "[Using Linear Algebra for Intelligent Information Retrieval](http://lsirwww.epfl.ch/courses/dis/2003ws/papers/ut-cs-94-270.pdf)."

## Data 
The original books are: 
![Book Titles](images/book_titles_original.png?raw=true "Book titles").
The data in machine readable form is in [books.txt](books.txt). 

## Document Term Matrix 
The authors construct a document term matrix 
![DTM](images/dtm_original.png?raw=true "DTM").
which I reproduce using the tm package for R and some light hand-editing to account for parser differences: 
![DTM](images/dtm_mine.png?raw=true "DTM").


## The pay-off 

![Figure 4](figure_4.png?raw=true "Figure 3")
