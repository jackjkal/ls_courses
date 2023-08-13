require 'yaml'

MESSAGES = YAML.load_file('mortgage_messages.yml', symbolize_names: true)

def prompt(message)
  puts "=> #{message}"
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

prompt(MESSAGES[:welcome])

loop do
  loan_amount = ''
  annual_percentage_rate = ''
  loan_duration = ''

  loop do
    prompt(MESSAGES[:loan_amount])
    loan_amount = gets.chomp

    if number?(loan_amount)
      loan_amount = loan_amount.to_i
      break
    else
      prompt(MESSAGES[:valid_number])
    end
  end

  loop do
    prompt(MESSAGES[:apr])
    annual_percentage_rate = gets.chomp

    if integer?(annual_percentage_rate)
      annual_percentage_rate = annual_percentage_rate.to_i
      break
    else
      prompt(MESSAGES[:valid_integer])
    end
  end

  loop do
    prompt(MESSAGES[:loan_duration])
    loan_duration = gets.chomp

    if integer?(loan_duration)
      loan_duration = loan_duration.to_i
      break
    else
      prompt(MESSAGES[:valid_integer])
    end
  end

  prompt(MESSAGES[:repeat])
  answer = gets.chomp

  break unless answer.downcase.start_with?('y')
end
