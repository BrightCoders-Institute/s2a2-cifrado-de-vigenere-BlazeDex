# frozen_string_literal: true

require 'minitest/autorun'
require '../src/cipher_word'

# Clase TestCipherWord. Se encarga de probar los métodos de CipherWord
class TestCipherWord < Minitest::Test
  def setup
    @cipher = CipherWord.new('HELLO', 'KEY')
  end

  def test_repeat_key
    assert_equal 'KEYKE', @cipher.repeat_key
  end

  def test_encrypt
    assert_equal 'QIJUS', @cipher.encrypt
  end

  def test_encrypt_char
    char_a_key_b = @cipher.send(:encrypt_char, 'A', 'B')
    char_b_key_c = @cipher.send(:encrypt_char, 'B', 'C')
    char_z_key_a = @cipher.send(:encrypt_char, 'Z', 'A')

    print_results(char_a_key_b, 'A', 'B', 'C')
    print_results(char_b_key_c, 'B', 'C', 'D')
    print_results(char_z_key_a, 'Z', 'A', 'A')

    assert_equal 'C'.ord, char_a_key_b
    assert_equal 'D'.ord, char_b_key_c
    assert_equal 'A'.ord, char_z_key_a
  end

  private

  def print_results(actual, char, key_char, expected)
    puts "char: #{char}, key_char: #{key_char}, expected: #{expected}, actual: #{actual.ord}"
  end
end
