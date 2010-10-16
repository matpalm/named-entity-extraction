#!/usr/bin/env python
import sys, string, re, codecs, locale
from nltk import sent_tokenize, word_tokenize, pos_tag, RegexpParser
from nltk.tokenize import WordPunctTokenizer, PunktWordTokenizer, PunktSentenceTokenizer

if len(sys.argv) != 2:
    raise Exception("usage: "+sys.argv[0]+" [WordPunctTokenizer|PunktWordTokenizer]")

#grammar = "NP: {<JJ>*<NNP>+}" # 0 or more adjectives followed by 1 or more noun phrases)
#grammar = "NP: {<NN|NNP>+}" # 1 or more nouns (or noun phrases)
grammar = "NP: {<NNP>+}" # 1 or more noun phrases

chunk_parser = RegexpParser(grammar)
sent_tokenizer = PunktSentenceTokenizer()

term_tokenizer = globals()[sys.argv[1]]()
#term_tokenizer = WordPunctTokenizer()
#term_tokenizer = PunktWordTokenizer()

sys.stdin = codecs.getreader(locale.getpreferredencoding())(sys.stdin)
sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.stdout)

def remove_trailing_period(token):
    return re.sub(r'\.$', '', token)

for line in sys.stdin.readlines():
    post_id, text = string.split(line.rstrip(), "\t")
    #print "post_id", post_id, "text", text
    for sentence in sent_tokenizer.tokenize(text):
        tokens = term_tokenizer.tokenize(sentence)
        tokens_without_trailing_periods = map(remove_trailing_period, tokens) # required for PunktWordTokenizer
        tagged = pos_tag(tokens_without_trailing_periods)
        #print "post_id",post_id,"sentence",sentence,"tagged",tagged
        if not len(tagged)==0:
            #print "tagged", tagged
            parse_tree = chunk_parser.parse(tagged)
            for subtree in parse_tree.subtrees():
                if subtree.node == 'NP':
                    phrase = subtree.leaves()
                    phrase = " ".join([ term for (term,type) in phrase ])
                    if len(phrase) > 1: # WordPunctTokenizer leaks in stuff like ',' and ' '
                        print "\t".join([post_id,phrase])
