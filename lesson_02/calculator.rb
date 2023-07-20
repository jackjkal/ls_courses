require 'yaml'

MESSAGES = YAML.load_file('calculator_messages.yml', symbolize_names: true)

def prompt(message)
  puts("=> #{message}")
end

def messages(message, lang = :en)
  MESSAGES[lang][message]
end

def valid_number?(num)
  num.to_i != 0
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

def number?(input)
  integer?(input) || float?(input)
end

def operation_to_message(op)
  word = case op
         when '1'
           'Adding'
         when '2'
           'Subtracting'
         when '3'
           'Multiplying'
         when '4'
           'Dividing'
         end

  word
end

prompt(messages(:welcome))

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt(messages(:valid_name))
  else
    break
  end
end

prompt("Hi #{name}!")

loop do # main loop
  number1 = ''
  loop do
    prompt(messages(:first_number))
    number1 = gets.chomp

    if valid_number?(number1)
      break
    else
      prompt(messages(:valid_number))
    end
  end

  number2 = ''
  loop do
    prompt(messages(:second_number))
    number2 = gets.chomp

    if valid_number?(number2)
      break
    else
      prompt(messages(:valid_number))
    end
  end

  operator_prompt = <<-MSG
  What operation would you like to perform?
  1) add
  2) subtract
  3) multiply
  4) divide
  MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages(:valid_operator))
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when '1'
             number1.to_i + number2.to_i
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_f
           end

  prompt("The result is #{result}")

  prompt(messages(:repeat))
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(messages(:goodbye))
