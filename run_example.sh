    dune exec bin/scanner.exe -- -x .spec  \
    -s  /home/mdupont/experiments/lang_agent/huggingface/metacoq/batch1/folder69/ \
    -p "Take this proof, treat as spec or a workflow for orchestration of many llm agents. Show that each variable in the proof maps into the workflow. Show that the workflow matches the steps of the proof. execute workflow to generate a sample data, generate a grammar to constrain the output, generate a function to test the output and prove its correct and then feed back into the original proof. .:"  \
    -u "http://localhost:11434" \
    --openai -m "mixtral" -u "https://dev-hub.agentartificial.com"

    
