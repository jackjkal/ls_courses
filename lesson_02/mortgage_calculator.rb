require 'yaml'

MESSAGES = YAML.load_file('mortgage_messages.yml', symbolize_names: true)
MONTHS_IN_YEAR = 12.0
PERCENTAGE_CONVERSION = 100.0

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

    if !(loan_amount.empty?) && number?(loan_amount)
      loan_amount = loan_amount.to_i
      break
    else
      prompt(MESSAGES[:valid_number])
    end
  end

  loop do
    prompt(MESSAGES[:apr])
    annual_percentage_rate = gets.chomp

    if !(annual_percentage_rate.empty?) && integer?(annual_percentage_rate)
      annual_percentage_rate = annual_percentage_rate.to_i
      break
    else
      prompt(MESSAGES[:valid_integer])
    end
  end

  loop do
    prompt(MESSAGES[:loan_duration])
    loan_duration = gets.chomp

    if !(loan_duration.empty?) && integer?(loan_duration)
      loan_duration = loan_duration.to_i
      break
    else
      prompt(MESSAGES[:valid_integer])
    end
  end

  monthly_interest_rate =
    (annual_percentage_rate / MONTHS_IN_YEAR) / PERCENTAGE_CONVERSION
  monthly_payment = loan_amount *
                    (monthly_interest_rate /
                    (1 - ((1 + monthly_interest_rate)**(-loan_duration))))

  prompt("#{MESSAGES[:result]}#{monthly_payment.truncate(2)}")

  prompt(MESSAGES[:repeat])
  answer = gets.chomp

  break unless answer.downcase.start_with?('y')
end
