#!/usr/bin/env python
import sys, string, re
from nltk import sent_tokenize, word_tokenize, pos_tag, RegexpParser
from nltk.tokenize import PunktWordTokenizer

grammar = "NP: {<JJ>*<NNP>+}" # 0 or more adjectives followed by 1 or more nouns (or noun phrases)
chunk_parser = RegexpParser(grammar)
tokenizer = PunktWordTokenizer()

def remove_trailing_period(str): return re.sub(r"\.$", '', str)

for line in sys.stdin.readlines():
    post_id, text = string.split(line.rstrip(), "\t")
    # print "post_id", post_id, "text", text
    for sentence in sent_tokenize(text):
        #print "post_id",post_id,"sentence",sentence
        sentence = remove_trailing_period(sentence)
        #print "dft tokenizer words  ", word_tokenize(sentence)
        #print "punkt tokenizer words", tokenizer.tokenize(sentence)
        #print "dft tokenizer tags   ", pos_tag(word_tokenize(sentence))
        #print "punkt tokenizer tags ", pos_tag(tokenizer.tokenize(sentence))
        tagged = pos_tag(tokenizer.tokenize(sentence))
        if not len(tagged)==0:
            #print "tagged", tagged
            parse_tree = chunk_parser.parse(tagged)
            for subtree in parse_tree.subtrees():
                if subtree.node == 'NP':
                    phrase = subtree.leaves()
                    terms = [ term for (term,type) in phrase ]
                    print "NounPhrase", post_id, " ".join(terms)






