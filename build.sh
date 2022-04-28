#!/bin/bash -eu
cd $SRC
cd image-png
cargo fuzz build -O
cp fuzz/target/x86_64-unknown-linux-gnu/release/decode $OUT/
cp fuzz/target/x86_64-unknown-linux-gnu/release/buf_independent $OUT/