set -x 
if test -z "$1"; then
    echo "requires arg"
    exit 0
fi
rm msgs.${1}.*
tail -n $1 data/msgs_200k.27.csv > msgs.$1.csv

# extract noun phrases, in parallel
TOTAL_LINES=`cat msgs.$1.csv | wc -l`
let SPLIT_SIZE=$TOTAL_LINES/12
split -l $SPLIT_SIZE msgs.$1.csv SPLIT_
# process in parallel
find SPLIT_* | parallel -j+0 'cat {} | ./extract_body.rb | ./noun_phrases.py | sort > {}_NP'
#find SPLIT_* | xargs -n1 -P4 -I{} bash -c "cat {} | ./extract_body.rb | ./noun_phrases.py | sort > {}_NP"
# recombine
sort -m SPLIT_*_NP > msgs.$1.np
rm SPLIT_*

# term frequencies
cut -f2- msgs.$1.np | sort | uniq -c > msgs.$1.np.freq





