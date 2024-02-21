GRAMMAR=$( cat ./grammars/ebnf.ebnf)
echo  "consider a consecutive series of types to describe the universe and universe of universes, what is your ordering?"	> prompt.txt

dune exec ./bin/simple_grammar.exe -- --llamacpp -s test4 -u "http://localhost:8080"  -n 4 -g "$GRAMMAR" -p prompt.txt
