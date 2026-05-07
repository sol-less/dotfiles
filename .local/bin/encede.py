#!/usr/bin/env python3

letters = 'abcdefghijklmnopqrstuvwxyz'
num_letters = len(letters)

def encede_main(text, mode, key):
    result = ''
    if mode == 'd':
        key = -key

    for letter in text:
        letter = letter.lower()
        if letter != ' ':
            index = letters.find(letter)
            if index == -1:
                result += letter
            else:
                new_index = index + key
                if new_index >= num_letters:
                    new_index -= num_letters
                elif new_index < 0:
                    new_index += num_letters
                result += letters[new_index]
        else:
            result += ' '
       
    return result

print('Encode or Decode?')
user_input = input('e/d: ').lower()
print()

if user_input == 'e':
    print('EnCede: Encryption Mode')
    print()
    key = int(input('Enter the key: '))
    text = input('Text: ')
    ciphertext = encede_main(text, user_input, key)
    print(f'{ciphertext}')

elif user_input == 'd':
    print('EnCede: Decryption Mode')
    print()
    key = int(input('Enter the key: '))
    text = input('Text: ')
    plaintext = encede_main(text, user_input, key)
    print(f'{plaintext}')