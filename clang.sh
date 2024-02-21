GRAMMAR=`cat ./grammars/c.gbnf`
dune exec ./bin/simple_grammar.exe -- --llamacpp -s clang2 -u "http://localhost:8080" -p "consider a consecutive series of types to describe the universe and universe of universes, what is your ordering? please create .c language declarations. " -n 4 -g "${GRAMMAR}"
