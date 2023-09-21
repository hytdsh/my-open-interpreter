#!/usr/bin/env python

import sys
import tiktoken

text = ""
file_path = sys.argv[1]
with open(file_path, 'r') as file:
    text = file.read()

# 2023-09-21 same model is used for gpt-3.5-turbo and gpt-4
# cl100k_base for gpt-3.5-turbo
# cl100k_base for gpt-4
tiktoken_encoding = tiktoken.encoding_for_model("gpt-3.5-turbo")
encoded = tiktoken_encoding.encode(text)
token_count = len(encoded)

print(token_count)
