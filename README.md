# Latent Semantic Indexing Example

This repo contains the R code to replicate the [Latent Semantic Indexing](https://en.wikipedia.org/wiki/Latent_semantic_analysis) example 
from Berry, Dumias  and O'Brien article "[Using Linear Algebra for Intelligent Information Retrieval](http://lsirwww.epfl.ch/courses/dis/2003ws/papers/ut-cs-94-270.pdf)."

The data in machine readable form is in [books.txt](books.txt). 
The code itself is in [analysis.R](analysis.R).

## Data 
The original books are: 
![Book Titles](images/book_titles_original.png?raw=true "Book titles").

## Document Term Matrix (DTM) 
The authors construct a document term matrix 
### Original 
![DTM](images/dtm_original.png?raw=true "DTM").

### Reproduction 
I reproduce using the [tm](https://cran.r-project.org/web/packages/tm/vignettes/tm.pdf) package for R and some light hand-editing to account for parser differences: 
![DTM](images/dtm_mine.png?raw=true "DTM")

## SVD 
I then perform a SVD of the DTM. 

### Original  
![Query example](images/query_example_original.png?raw=true "Query example (original)").

## Reproduction
And here are some the component singular values and the u matrix: 
![Query example](images/query_example_mine.png?raw=true "Query example (min)").

## Plotting the location of documents and terms in 2 dimensions (Figure 4) 

### Original
The original figure 4 shows the locations of the documents and terms: 
![Figure 4](images/figure_4_original.png?raw=true "Figure 3")

### Reproduction 
And here is my re-production: 
![Figure 4](figure_4.png?raw=true "Figure 3")
