#!/usr/bin/env python3

from collections import defaultdict
import argparse
import hashlib
import itertools
import json
import random
import string
import sys
import pprint
import operator


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
    
def column(matrix, i):
    return [row[i] for row in matrix]

def decode(message):
    encodedMessage = []
    decodedMessage = defaultdict(int)
    for msg in message:
        new_message = []
        for i in range(8):
            new_message.append(tuple(map(lambda x: tuple(x.split(" ")), msg[i * 3 : i * 3 + 3])))
        encodedMessage.append(tuple(new_message))
    for i in range(8):
        msg = column(encodedMessage, i)
        decodedMessage[decode_message(msg)] += 1
    return max(decodedMessage, key=decodedMessage.get)
    
def decode_message(encoded_characters):
    key = encoded_characters[0]
    mapping = gen_character_mapping(key)
    if mapping[TERMINATOR] != encoded_characters[-1]:
        key = encoded_characters[-1]
        mapping = gen_character_mapping(key)
        if mapping[TERMINATOR] != encoded_characters[0]:
            return 'Could not decode message' 
        encoded_characters = encoded_characters[::-1]
    mapping = dict(map(reversed, mapping.items()))

    decodedString = ''.join(mapping[char] for char in encoded_characters[1:-1])
    # print(decodedString)
    return decodedString


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
