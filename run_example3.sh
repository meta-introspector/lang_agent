while true;
do 
dune exec bin/scanner.exe -- -c .txt -x .spec  \
    -s  ~/2024/02/12/meta-coq-common/common/batch1/folder67/ \
    -p "Take this proof, treat as spec or a workflow for orchestration of many llm agents. Show that each variable in the proof maps into the workflow. Show that the workflow matches the steps of the proof. execute workflow to generate a sample data, generate a grammar to constrain the output, generate a function to test the output and prove its correct and then feed back into the original proof. .:"  \
    --ollama -m "mixtral" -u "https://mixtral-agentartificial.ngrok.app"

    
done;
