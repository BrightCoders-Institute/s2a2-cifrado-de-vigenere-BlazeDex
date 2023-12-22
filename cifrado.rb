# frozen_string_literal: true

# Clase Input, recibe la entrada de la palabra y la clave para posteriormente verificar si es válida.
class Input
  def self.get_valid_input(prompt, validation)
    loop do
      puts prompt
      input = gets.chomp.upcase
      return input if validation.call(input)

      puts 'Entrada no válida. Inténtelo de nuevo, por favor.'
    end
  end
end

# Clase CipherWord, toma una palabra para cifrarla en Vigenere.
class CipherWord
  attr_accessor :word, :key

  ALPHABET = %w[A B C D E
                F G H I J
                K L M N Ñ
                O P Q R S
                T U V W X
                Y Z].freeze

  def initialize(word, key)
    @word = word
    @key = key
  end

  def repeat_key
    rep_times = (@word.length / @key.length) + 1
    repeat = @key * rep_times
    repeat[0, @word.length]
  end

  def encrypt
    cipher_text = ''
    repeat_key.chars.each_with_index do |key_char, index|
      cipher_text += encrypt_char(word[index], key_char)
    end
    cipher_text
  end

  private

  def encrypt_char(char, key_char)
    if ALPHABET.include?(char)

      char_index = ALPHABET.index(char)
      key_index = ALPHABET.index(key_char)

      encrypted_char_index = (char_index + key_index) % ALPHABET.length
      ALPHABET[encrypted_char_index]
    else
      char
    end
  end
end

# Clase principal VigenereApp, toma las clases Input y CipherWord para poder ejecutarse en consola.
class VigenereApp
  def self.run
    word = Input.get_valid_input('Ingrese la palabra a cifrar: ', ->(input) { input.match?(/\A[A-Za-z]+\z/) })
    key = Input.get_valid_input('Ingrese la palabra clave: ', ->(input) { input.match?(/\A[A-Za-z]+\z/) })

    cipher = CipherWord.new(word, key)
    puts "Texto cifrado: #{cipher.encrypt}"
  end
end

VigenereApp.run
