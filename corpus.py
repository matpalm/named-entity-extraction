#!/usr/bin/env python
from nltk.corpus import PlaintextCorpusReader
from nltk import pos_tag, word_tokenize, RegexpParser

wordlists = PlaintextCorpusReader('data', 'test.corpus')

grammar = "NP: {<JJ>*<NNP>+}" # 0 or more adjectives followed by 1 or more nouns (or noun phrases)
chunk_parser = RegexpParser(grammar)

for paragraph in wordlists.paras():
    post_id = paragraph.pop(0).pop(0)
    for sentence in paragraph:
        print "sentence:", sentence
        tagged = pos_tag(sentence)
        parse_tree = chunk_parser.parse(tagged)
        for subtree in parse_tree.subtrees():
            if subtree.node == 'NP':
                print "NounPhrase", post_id, subtree
        print




