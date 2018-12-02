#!/usr/bin/env python3

import argparse
import hashlib
import itertools
import json
import random
import string
import sys


REDUNDANCY = 8
TERMINATOR = '_'
COLORS = ['maroon', 'purple', 'blue', 'pink', 'green']
SHAPES = ['circle', 'rectangle', 'triangle', 'pentagon', 'star']

patterns = list(itertools.product(itertools.product(SHAPES, COLORS), repeat=3))

def gen_character_mapping(key):
    random.seed(str(key))
    characters = string.ascii_lowercase + ' .?!' + TERMINATOR
    character_patterns = random.sample(patterns, len(characters))
    return dict(zip(characters, character_patterns))

def encode(user_input):
    key = random.choice(patterns)
    mapping = gen_character_mapping(key)

    key_list = [[' '.join(x) for x in key]]
    terminator_list = [[' '.join(x) for x in mapping[TERMINATOR]]]
    mapping_list = [[' '.join(x) for x in mapping[char]] for char in user_input]
    input_to_patterns = key_list + mapping_list + terminator_list

    print(json.dumps(input_to_patterns))
    
def decode(encoded_text):
    encoded_characters = []
    for pattern in json.loads(encoded_text):
        a = [tuple(x.split()) for x in pattern]
        encoded_characters.append((tuple(a)))
        
    key = encoded_characters[0]
    mapping = gen_character_mapping(key)
    if mapping[TERMINATOR] != encoded_characters[-1]:
        key = encoded_characters[-1]
        mapping = gen_character_mapping(key)
        if mapping[TERMINATOR] != encoded_characters[0]:
            raise ValueError('Unable to determine key')
        encoded_characters = encoded_characters[::-1]
    mapping = dict(map(reversed, mapping.items()))

    print(''.join(mapping[char] for char in encoded_characters[1:-1]))


def main():
    parser = argparse.ArgumentParser()
    action_group = parser.add_mutually_exclusive_group(required=True)
    action_group.add_argument('-d', '--decode')
    args = parser.parse_args()
    
    if args.decode:
        decode(args.decode)
    else:
        raise ValueError

if __name__ == '__main__':
    main()
