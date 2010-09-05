#!/usr/bin/env python
import sys, string
from nltk import sent_tokenize, word_tokenize, pos_tag, RegexpParser

grammar = "NP: {<JJ>*<NNP>+}" # 0 or more adjectives followed by 1 or more nouns (or noun phrases)
chunk_parser = RegexpParser(grammar)

for line in sys.stdin.readlines():
    post_id, text = string.split(line.rstrip(), "\t")
    # print "post_id", post_id, "text", text
    for sentence in sent_tokenize(text):
        # print "sentence", sentence
        tagged = pos_tag(word_tokenize(sentence))
        parse_tree = chunk_parser.parse(tagged)
        for subtree in parse_tree.subtrees():
            if subtree.node == 'NP':
                phrase = subtree.leaves()
                terms = [ term for (term,type) in phrase ]
                print "NounPhrase", post_id, " ".join(terms)






