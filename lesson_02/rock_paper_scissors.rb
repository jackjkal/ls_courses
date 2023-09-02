VALID_CHOICES = {
  words: ['rock', 'paper', 'scissors', 'lizard', 'spock'],
  shorthand: {
    'r' => 0,
    'p' => 1,
    's' => 2,
    'l' => 3,
    'sp' => 4
  }
}

WIN_CONDITIONS = {
  'rock' => ['lizard', 'scissors'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'lizard' => ['paper', 'spock'],
  'spock' => ['rock', 'scissors']
}

SCORES = {
  player: 0,
  computer: 0
}

MAX_WIN_LIMIT = 3

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_choice?(choice)
  VALID_CHOICES[:words].include?(choice) ||
  VALID_CHOICES[:shorthand].include?(choice)
end

def word?(text)
  VALID_CHOICES[:words].include?(text)
end

def to_word(shorthand)
  index = VALID_CHOICES[:shorthand][shorthand]

  VALID_CHOICES[:words][index]
end

def win?(first, second)
  WIN_CONDITIONS[first].include?(second)
end

def game_over?
  SCORES[:player] == MAX_WIN_LIMIT || SCORES[:computer] == MAX_WIN_LIMIT
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def display_scores
  prompt("Player score: #{SCORES[:player]}")
  prompt("Computer score: #{SCORES[:computer]}")
end

def display_grand_winner
  if SCORES[:player] == 3
    prompt("You are the grand winner!")
  else
    prompt("Computer is the grand winner!")
  end
end

def increment_score(player, computer)
  if win?(player, computer)
    SCORES[:player] += 1
  elsif win?(computer, player)
    SCORES[:computer] += 1
  end
end

def reset_scores
  SCORES[:player] = SCORES[:computer] = 0
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES[:words].join(', ')}")

    shorthand_options = <<-MSG
    r  = rock
    p  = paper
    s  = scissors
    l  = lizard
    sp = spock
    MSG

    prompt("You can also use shorthand:")
    Kernel.puts(shorthand_options)

    choice = Kernel.gets().chomp().downcase()

    if valid_choice?(choice)
      unless word?(choice)
        choice = to_word(choice)
      end
      
      break
    else
      prompt("That's not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES[:words].sample

  Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")

  increment_score(choice, computer_choice)
  display_result(choice, computer_choice)
  display_scores()

  if game_over?()
    display_grand_winner()
    reset_scores()
  end

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Goodbye!")
