#!/bin/bash
file_name=trace_log
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
new_fileName=huggingface/batch2/$file_name.$1.$current_time."org"
echo building $new_fileName

./_build/default/bin/worker.exe prompt.txt separator.txt task.txt > $new_fileName &

