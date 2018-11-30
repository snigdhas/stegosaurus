#!/usr/bin/env python3

import argparse
import hashlib
import itertools
import json
import random
import string
import sys
import typing

from termcolor import colored

REDUNDANCY = 8
TERMINATOR = '_'
COLORS = ['maroon', 'purple', 'blue', 'pink', 'green']
SHAPES = ['circle', 'rectangle', 'triangle', 'pentagon', 'star']

Pattern = typing.List[typing.Tuple[str, str]]

patterns = list(itertools.product(itertools.product(SHAPES, COLORS), repeat=3))


def pattern_to_text(pattern: Pattern) -> str:
    return (' '.join(colored(shape, color) for shape, color in pattern) + ' ') * REDUNDANCY


def gen_character_mapping(key: Pattern) -> typing.Dict[str, Pattern]:
    key_hash = hashlib.sha256()
    key_hash.update(str(key).encode())
    random.seed(key_hash.digest())
    characters = string.ascii_lowercase + ' .?!' + TERMINATOR
    character_patterns = random.sample(patterns, len(characters))
    return dict(zip(characters, character_patterns))


def encode(user_input: str, raw=False):
    key = random.choice(patterns)
    mapping = gen_character_mapping(key)

    
    key_list = [[' '.join(x) for x in key]]
    terminator_list = [[' '.join(x) for x in mapping[TERMINATOR]]]
    mapping_list = [[' '.join(x) for x in mapping[char]] for char in user_input]
    # input_to_patterns = [key] + [mapping[char] for char in user_input] + [mapping[TERMINATOR]]
    input_to_patterns = key_list + mapping_list + terminator_list

    if raw:
        print(json.dumps(input_to_patterns))
        
        # with open('data.json', 'w') as outfile:
        #     json.dump(input_to_patterns, outfile)
    else:
        print('\n'.join(map(pattern_to_text, input_to_patterns)))


def decode(encoded_text: str):
    encoded_characters = [tuple(map(tuple, pattern)) for pattern in json.loads(encoded_text)]

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
    action_group.add_argument('-e', '--encode')
    action_group.add_argument('-d', '--decode')
    parser.add_argument('-r', '--raw', action='store_true', default=False)
    args = parser.parse_args()
    
    if args.encode:
        encode(args.encode, raw=args.raw)
    elif args.decode:
        decode(args.decode)
    else:
        raise ValueError

if __name__ == '__main__':
    main()
