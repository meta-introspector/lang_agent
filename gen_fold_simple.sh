GRAMMAR=./grammars/ebnf.ebnf

DS=$(date -Iseconds)
PROMPT_NAME=lib/folder.ml
PROMPT_NAME2=data/dungeon_prompt.txt
HPROMPT_NAME="prompt_grammar3h.txt"
TPROMPT_NAME="prompt_grammar3t.txt"

echo "The goal is to create a flexible and customizable system for generating prompts and functional workflows for a language model that can be used to generate creative and imaginative descriptions of code in a high tech code based hacking game.
the game would involve exploring a dungeon of knowledge generated using a large language model and a proof engine. The player would navigate through the dungeon, encountering various objects and NPCs along the way, each with their own set of properties and behaviors defined by the terms used in the script.

the game would involve exploring a dungeon and encountering various types of monsters, treasures, and challenges. The player would use weapons, spells, and artifacts to defeat the monsters and complete quests, all while navigating a labyrinthine cave or other underground environment. The game might also include elements of drama, music, and art, as well as secrets and occult themes.

The code of the world is written using the languages and grammars generated.
each function or spell of object can be encoded into an emoji string which
is its quasi quine quotation that can be vectorized into a number of tensors.

These tensor can become code and code can become tensors.
we can visualize the tensors in the game using shaders
and mathpylib.
the game is like an augmented reality matrix game where we neo
write our own story.

In this task we want to craft the meta magical folder that will fold
streams of the matrix togehter into one.

Here is the code we wrote so far " > $PROMPT_NAME2
#head -500 $PROMPT_NAME > $PROMPT_NAME2
cat $PROMPT_NAME >> $PROMPT_NAME2
echo " ENDSRC . Please imagine the simulation its execution. Imagine running the code and all the output it would generate. Generate ocaml code to do the merge of large language model prompt workflows." >> $PROMPT_NAME2

mkdir -p data/folder
#      #     --openai -m "mixtral" -u "https://dev-hub.agentartificial.com" \
dune exec bin/simple.exe -- \
       --ollama -m "mixtral" -u "https://mixtral-agentartificial.ngrok.app" \
     -f $PROMPT_NAME2 \
    -s "data/folder/sim_folder_1_${DS}"   \
    -x ".txt" \
    -n 2000
