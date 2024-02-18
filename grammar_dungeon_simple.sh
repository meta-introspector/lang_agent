GRAMMAR=./grammars/ebnf.ebnf
GRAMMAR_C=$(cat $GRAMMAR)

DS=$(date -Iseconds)
PROMPT_NAME=bin/generate_dungeon.ml
PROMPT_NAME2=data/dungeon_prompt.txt
HPROMPT_NAME="prompt_grammar3h.txt"
TPROMPT_NAME="prompt_grammar3t.txt"

echo "We are working on creating a GBNF grammar for a dungeon. It follows a standard EBNF notation at the end of this message (see TARGET). We translating an dungeon into this EBNF in chunks. Consider the following chunk of the dungeon between BEGINSRC and ENDSRC for translation to EBNF. BEGINSRC  " > $PROMPT_NAME2
#head -500 $PROMPT_NAME > $PROMPT_NAME2
cat $PROMPT_NAME >> $PROMPT_NAME2
echo " ENDSRC . Please rewrite it to be more beautiful and in EBNF form. We are going to use the following TARGET: BEGINTARGET ${GRAMMAR_C} ENDTARGET as our target grammar format. Please rewrite SRC into TARGET. You are to only respond using the target custom GBNF grammar and put  descriptions or comments at the end of the rule with a #, see the grammar for rules. Please start with a comment using '#' to start comments on a new line. " >> $PROMPT_NAME2

dune exec bin/simple.exe -- \
     --openai -m "mixtral" -u "https://dev-hub.agentartificial.com" \
     -n 20 \
     -f $PROMPT_NAME2 \
    -s "data/dungeon/dungeon_1_${DS}"   \
    -x ".txt" \
    -n 20 
