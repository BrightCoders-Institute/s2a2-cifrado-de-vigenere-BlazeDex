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
