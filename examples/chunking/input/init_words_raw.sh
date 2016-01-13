#!/usr/bin/env bash
# A script for loading data for DeepDive's Chunking example
set -eu
cd "$(dirname "$0")"

if [[ -n ${SUBSAMPLE_NUM_WORDS_TRAIN:-} && -n ${SUBSAMPLE_NUM_WORDS_TEST:-} ]]; then
    head -n ${SUBSAMPLE_NUM_WORDS_TRAIN} ./train_null_terminated.txt
    head -n ${SUBSAMPLE_NUM_WORDS_TEST}   ./test_null_terminated.txt
else
    cat ./train_null_terminated.txt ./test_null_terminated.txt
fi |
sed 's/ /	/g; s/null/\\N/g' |
DEEPDIVE_LOAD_FORMAT=tsv \
deepdive load "words_raw(word, pos, tag)" /dev/stdin
