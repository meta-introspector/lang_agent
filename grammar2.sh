GRAMMAR=./grammars/ebnf.ebnf
GRAMMAR_C=$(cat $GRAMMAR)

GRAMMAR2=./grammars/sentenceParser.mly
GRAMMAR2_C=$( cat $GRAMMAR2 )

DS=$(date -Iseconds)
PROMPT_NAME="prompt_grammar3.txt"

echo "Consider the following grammar between BEGINSRC and ENDSRC. BEGINSRC ${GRAMMAR2_C} ENDSRC . Please rewrite it to be more beautiful. We are going to use the following TARGET: BEGINTARGET ${GRAMMAR_C} ENDTARGET as our target grammar format. Please rewrite SRC into TARGET. " > $PROMPT_NAME

dune exec bin/simple_grammar.exe -- \
    --llamacpp \
    -u "http://localhost:8080" \
    -s "data/grammar/grammar_1_${DS}"   \
    -g $GRAMMAR \
    -p $PROMPT_NAME \
    -x ".txt" \
    -n 20
