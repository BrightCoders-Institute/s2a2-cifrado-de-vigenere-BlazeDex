# frozen_string_literal: true

require 'minitest/autorun'
require '../src/input'

# Clase TestInput. Se encarga de probar los métodos de la clase Input.
class TestInput < Minitest::Test
  def test_get_valid_input
    prompt = 'Ingrese algo:'
    validation = ->(input) { input == 'VALIDO' }
    input_mock = create_input_mock(%w[INVALIDO VALIDO])

    result = capture_io { Input.get_valid_input(prompt, validation) }

    assert_input_mock_called(input_mock)
    assert_equal "Ingrese algo:\nEntrada no válida. Inténtelo de nuevo, por favor.\nIngrese algo:\n", result
  end

  private

  def create_input_mock(inputs)
    input_mock = Minitest::Mock.new
    inputs.each { |input| input_mock.expect(:chomp, input) }
    Input.define_singleton_method(:gets) { input_mock.chomp }
    input_mock
  end

  def assert_input_mock_called(input_mock)
    input_mock.verify
  end

  def capture_io
    original_stdout = $stdout
    captured_output = StringIO.new
    $stdout = captured_output
    $stdin = StringIO.new
    yield
    captured_output.string
  ensure
    $stdout = original_stdout
    $stdin = STDIN
  end
end
