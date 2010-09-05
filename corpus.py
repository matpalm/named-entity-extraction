#!/usr/bin/env python
from nltk.corpus import PlaintextCorpusReader
from nltk import pos_tag, word_tokenize, RegexpParser

wordlists = PlaintextCorpusReader('data', 'test.corpus')

grammar = "NP: {<JJ>*<NN|NNP>+}" # 0 or more adjectives followed by 1 or more nouns (or noun phrases)
chunk_parser = RegexpParser(grammar)

first_sentence = wordlists.paras()[0][0]
tagged_sentence = pos_tag(first_sentence)
print "pos tags", tagged_sentence


print chunk_parser.parse(tagged_sentence)



