
# stop on error
set -e

GRAMMAR=./grammars/ebnf.ebnf
GRAMMAR_C=$(cat $GRAMMAR)

DS=$(date -Iseconds)

HPROMPT_NAME="prompt_grammar3h.txt"
TPROMPT_NAME="prompt_grammar3t.txt"

echo "Consider this grammar guid our output. begin grammar: ${GRAMMAR_C}. end grammar. Use this grammar to Create a new EBNF grammar for our domain. Consider the following chunk. BEGIN SRC  " > $HPROMPT_NAME
echo " END SRC . Please rewrite SRC to in the GRAMMAR EBNF form." > $TPROMPT_NAME

for PROMPT_NAME in data/folder/grammar/sim*.txt;
do
    echo $PROMPT_NAME;
    echo "${GRAMMAR}"
    cat "${GRAMMAR}"
    dune exec bin/simple_grammar.exe -- \
	--llamacpp \
	-u "http://localhost:8080" \
	-s "data/folder/grammar/out/grammar_1_${DS}"   \
	-x ".txt" \
	-n 20 \
	-w 1000 \
	-g "${GRAMMAR}" \
	-p "${PROMPT_NAME}" \
	-t "${TPROMPT_NAME}" \
	-h "${HPROMPT_NAME}" 
done
