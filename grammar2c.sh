GRAMMAR=./grammars/ebnf.ebnf
DS=$(date -Iseconds)
PROMPT_NAME=prompt_grammar2c.txt

dune exec bin/simple_grammar.exe -- \
    --llamacpp \
    -u "http://localhost:8080" \
    -s "data/grammar/test_1_${DS}"   \
    -g $GRAMMAR \
    -p $PROMPT_NAME \
    -x ".txt" \
    -n 6
