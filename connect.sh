dune exec bin/scanner.exe -- -x .con -c .outlocal2 \
     -s ./huggingface/unimath/batch2/data_30/ \
     -p "Create a list of connection pairs between term in the proof and words in the story.:"  --ollama -m "mistral" \
     -u "http://localhost:11434"
