#!/usr/bin/env python
import sys, string, re, codecs, locale
from nltk import sent_tokenize, word_tokenize, pos_tag, RegexpParser
from nltk.tokenize import WordPunctTokenizer, PunktWordTokenizer, PunktSentenceTokenizer

grammar = "NP: {<JJ>*<NNP>+}" # 0 or more adjectives followed by 1 or more nouns (or noun phrases)
chunk_parser = RegexpParser(grammar)
sent_tokenizer = PunktSentenceTokenizer()

term_tokenizer = WordPunctTokenizer()
#term_tokenizer = PunktWordTokenizer()

sys.stdin = codecs.getreader(locale.getpreferredencoding())(sys.stdin)
sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.stdout)

for line in sys.stdin.readlines():
    post_id, text = string.split(line.rstrip(), "\t")
    #print "post_id", post_id, "text", text
    for sentence in sent_tokenizer.tokenize(text):
        tagged = pos_tag(term_tokenizer.tokenize(sentence))
        #print "post_id",post_id,"tagged",tagged
        if not len(tagged)==0:
            #print "tagged", tagged
            parse_tree = chunk_parser.parse(tagged)
            for subtree in parse_tree.subtrees():
                if subtree.node == 'NP':
                    phrase = subtree.leaves()
                    phrase = " ".join([ term for (term,type) in phrase ])
                    print "\t".join([post_id,phrase])
