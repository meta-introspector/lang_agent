GRAMMAR=./grammars/ebnf.ebnf
GRAMMAR_C=$(cat $GRAMMAR)

DS=$(date -Iseconds)
PROMPT_NAME=grammars/ebnf.ebnf
PROMPT_NAME2=grammars/ebnf.ebnf.prompt
HPROMPT_NAME="prompt_grammar3h.txt"
TPROMPT_NAME="prompt_grammar3t.txt"

echo "We are bootstrapping a new system using EBNF grammars.
We want to make an ebnf grammar that is super detailed and self expressive.
Here is the code we wrote so far " > $PROMPT_NAME2
#head -500 $PROMPT_NAME > $PROMPT_NAME2
cat $PROMPT_NAME >> $PROMPT_NAME2
echo " ENDSRC . Lets rewrite this  EBNF to be more expressive and explicit in its naming but keep the syntax the same for compatibility with GBNF and llama.cpp. " >> $PROMPT_NAME2

mkdir -p data/folder

dune exec bin/simple.exe -- \
     --openai -m "mixtral" -u "https://dev-hub.agentartificial.com" \
     -f $PROMPT_NAME2 \
    -s "data/grammar/regen3_ebnf_${DS}"   \
    -x ".txt" \
    -n 2000
