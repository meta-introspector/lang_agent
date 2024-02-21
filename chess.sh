GRAMMAR=`cat ./grammars/chess.gbnf`
dune exec ./bin/simple_grammar.exe -- --llamacpp -s test4 -u "http://localhost:8080" -p "consider a consecutive series of types to describe the universe and universe of universes, what is your ordering?" -n 4 -g "${GRAMMAR}"
