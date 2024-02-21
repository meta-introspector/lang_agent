GRAMMAR=./grammars/ebnf.ebnf
DS=$(date -Iseconds)
PROMPT_NAME=prompt_grammar2c.txt
PROMPT_C="$(cat $PROMPT_NAME)"
dune exec bin/simple.exe -- \
    --llamacpp \
    -u "http://localhost:8080" \
    -p "${PROMPT_C}" \
    -x ".txt" \
    -n 6
