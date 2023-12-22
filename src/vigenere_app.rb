# frozen_string_literal: true

require_relative './input'
require_relative './cipher_word'

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
