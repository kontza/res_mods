#!/usr/bin/env python3
from pygments import lex
from pygments.lexers.c_like import CLexer
from pygments.token import Token as ParseToken
import json

def minify_jsonc(replace_query, lexer):
    generator = lex(replace_query, lexer)
    line = []
    lines = []
    for token in generator:
        token_type = token[0]
        token_text = token[1]
        if token_type in ParseToken.Comment:
            continue
        if token_text.strip():
            line.append(token_text)
        if token_text == '\n':
            joined = ''.join(line)
            if joined.strip():
                lines.append(joined)
            line = []
    if line:
        line.append('\n')
        lines.append(''.join(line))
    strip_query = "\n".join(lines)
    return strip_query.replace('${', '{')

if __name__ == "__main__":
    with open('xvm/default/@xvm.xc', 'r') as fin:
        data = ""
        for line in fin:
            data += line
        stripped = minify_jsonc(data, CLexer())
        dict = json.loads(stripped)
        print(f"{dict['definition']['modMinVersion']}/{dict['definition']['gameVersion']}")