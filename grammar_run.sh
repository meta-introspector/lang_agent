GRAMMAR=./grammars/ebnf.ebnf
GRAMMAR_C=$(cat $GRAMMAR)

DS=$(date -Iseconds)

HPROMPT_NAME="prompt_grammar3h.txt"
TPROMPT_NAME="prompt_grammar3t.txt"

echo "Create an EBNF grammar. Consider the following chunk. BEGINSRC  " > $HPROMPT_NAME
echo " ENDSRC . Please rewrite it to in the EBNF form." > $TPROMPT_NAME

for PROMPT_NAME in data/folder/grammar/sim*.txt;
do echo $PROMPT_NAME; 
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
