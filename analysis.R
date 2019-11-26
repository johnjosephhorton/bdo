## This code replicates the example of Latent Semantic Indexing from 
## "Using Linear Algebra for Intelligent Information Retrieval" by  M.W.Berry, S.T. Dumais& G.W. O'Brien
## PDF of oridinal: http://lsirwww.epfl.ch/courses/dis/2003ws/papers/ut-cs-94-270.pdf

library(tm)
library(SnowballC)
library(Matrix)
library(ggplot2) 
library(ggrepel)

# Read in the book titles 
text <- as.character(readLines("books.txt"))

## Clean up the text 
review_corpus <- Corpus(VectorSource(text))
review_corpus = tm_map(review_corpus, content_transformer(tolower))
review_corpus = tm_map(review_corpus, removeNumbers)
review_corpus = tm_map(review_corpus, removePunctuation)
review_corpus = tm_map(review_corpus, removeWords, c("the", "and", stopwords("english")))
review_corpus = tm_map(review_corpus, stemDocument)
review_corpus =  tm_map(review_corpus, stripWhitespace)

## Extract the document term matrix (DTM)
dtm <- DocumentTermMatrix(review_corpus, control = list())

## Get all the words in the DTM & the counts of their apperances 
words <- diag(crossprod(as.matrix(dtm)))

## Select those that appear more than once 
word.list.raw <- sort(names(words[words > 1]))

## Remove two words that I "pick up" that are not in the BDO DTM 
remove <- c("comput", "dynam")
word.list <- word.list.raw[!(word.list.raw  %in% remove)]
dtm.reduced <- as.matrix(dtm[, intersect(colnames(dtm), word.list)])

## BDO has term term rows and document columns, so we transpose 
X <- t(dtm.reduced[, sort(colnames(dtm.reduced))])
## "Differentation gets stemmed to "diferenti" in my version - fixing directly by setting to 0
X[4, 3] <- 0

##############################
## Compute the SVD of the DTM
##############################

s <- svd(X)

u <- s$u
v <- s$v
d <- s$d
D <- diag(d)

## Confirm the decomposition (need to round to get very small values to 0)
all(X == round(u %*% D %*% t(v), 4)) #  X = U D V'

## Confirm the first two singular values match (4:531 and 2.758)
k <- 2
d[1:k]

## Helper function for constructng a query vector 
QueryVector <- function(terms, word.list){
    q <- rep(0, length(word.list))
    for(term in terms){
        index <- which(term == word.list)
        q[index] <- 1
    }
    q
}

####################################
## The applications & theory query example
####################################

q <- QueryVector(c("applic", "theori"), rownames(X))
q %*% u[, 1:k] %*% diag(1/d[1:k])

#####################
## Reproduce Figure 4
#####################

## Get the term coordinates (use a diagonal matrix to get all the terms)
df.terms <- data.frame(diag(length(word.list)) %*% u[, 1:k])
colnames(df.terms) <- c("x", "y")
df.terms$label <- rownames(X)
df.terms$type <- "term"

## Get the book coordinates (use the DTM transposed)
df.docs <- data.frame(t(X) %*% u[, 1:k])
colnames(df.docs) <- c("x", "y")
df.docs$label <- paste0("B", colnames(X))
df.docs$type <- "docs"

df <- rbind(df.docs, df.terms)

g <- ggplot(data = df, aes(x = x, y = y)) + geom_point(aes(shape = type)) +
    geom_text_repel(aes(label = label)) +
    theme_bw() +
    geom_hline(yintercept = 0, colour = "grey") +
    theme(legend.position = "top")

print(g)

