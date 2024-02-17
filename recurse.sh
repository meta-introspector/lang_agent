  dune exec ./bin/recurse.exe -- --openai -m "mixtral" \
       -u "https://dev-hub.agentartificial.com" \
       -s "recurse3"  \
       -x ".txt" \
       -p "consider a consecutive series of propositions to describe the universe and universe of universes. Consider your previous output and continue the thought if there, otherwise start a new thought chain." \
       -n 3
