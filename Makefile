tst:
	dune build 
	dune exec -- ./bin/argiope.exe http://mistral.ai

test2:
	      dune exec bin/scanner.exe --  -s ./huggingface/unimath/batch2/data_30/       -p "Consider the following valid and successful trace of a COQ proof in unimath and interpret it creatively looking for interesting visualizations and metaphors and analogies and describe possible scenes for a comic book.:"  -b openai -m "mistral" -u "https://dev-hub.agentartificial.com"
