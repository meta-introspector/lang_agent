GRAMMAR=~/experiments/gbnf_parser/grammars/ebnf.ebnf
GRAMMAR_C=$(cat $GRAMMAR)

GRAMMAR2=~/experiments/gbnf_parser/lib/sentenceParser.mly
GRAMMAR2_C=$( cat $GRAMMAR2 )

DATA=$(cat notes.org)
DS=$(date -Iseconds)
PROMPT_NAME="prompt_grammar2_${DS}.txt"

echo "Consider the following grammar between BEGINSRC and ENDSRC. BEGINSRC ${GRAMMAR2_C} ENDSRC . Please rewrite it to be more beautiful. We are going to use the following TARGET: BEGINTARGET ${GRAMMAR_C} ENDTARGET as our target grammar format. Please rewrite SRC into TARGET. " > $PROMPT_NAME

dune exec bin/simple_grammar.exe -- \
    --llamacpp \
    -u "http://localhost:8080" \
    -s "grammar_1_${DS}"   \
    -g $GRAMMAR \
    -p $PROMPT_NAME \
    -x ".txt" \
    -n 6
