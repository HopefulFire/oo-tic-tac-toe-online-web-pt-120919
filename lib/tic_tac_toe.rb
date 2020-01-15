require 'pry'

class TicTacToe
  
  WIN_COMBINATIONS =
  [
    #horizontal
    [0,1,2],
    [3,4,5],
    [6,7,8],
    #vertical
    [0,3,6],
    [1,4,7],
    [2,5,8],
    #diagonal
    [0,4,8],
    [2,4,6]
  ]
  
  def initialize
    @board = [' '] * 9
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(input)
    input.chomp.to_i - 1
  end
  
  def move(index, token = 'X')
    @board[index] = token
  end
  
  def position_taken?(position)
    taken = true
    if @board[position] == ' '
      taken = false
    end
    taken
  end
  
  def valid_move?(position)
    valid = false
    if position > -1 and position < 9 and not self.position_taken?(position)
      valid = true
    end
    valid
  end
  
  def turn
    puts 'Specify a position between 1-9:'
    index = self.input_to_index(gets)
    if self.valid_move?(index)
      self.move(index, self.current_player)
      self.display_board
    else
      self.turn
    end
  end
  
  def turn_count
    turns = 0
    @board.each do |piece|
      if piece != ' '
        turns += 1
      end
    end
    turns
  end
  
  def current_player
    player = 'O'
    if self.turn_count.even?
      player = 'X'
    end
    player
  end
  
  def get_player_positions(player)
    positions = []
    @board.each_with_index do |piece, position|
      if piece == player
        positions.push(position)
      end
    end
    positions
  end
  
  def player_won?(player)
    won = false
    positions = self.get_player_positions(player)
    WIN_COMBINATIONS.each do |win_combination|
      winning_combination = win_combination.all? do |win_number|
        positions.include?(win_number)
      end
      if winning_combination
        won = win_combination
      end
    end
    won
  end
  
  def won?
    won = false
    ['X','O'].each do |player|
      if self.player_won?(player) != false
        won = self.player_won?(player)
      end
    end
    won
  end
  
  def full?
    full = false
    if self.turn_count == 9
      full = true
    end
    full
  end
  
  def draw?
    draw = false
    if not self.won? and self.full?
      draw = true
    end
    draw
  end
  
  def over?
    over = false
    if self.draw? or self.won?
      over = true
    end
    over
  end
  
  def winner
    winner = nil
    ['X','O'].each do |player|
      if self.player_won?(player)
        winner = player
      end
    end
    winner
  end
  
  def play
    while !over?
      turn
    end
    if winner
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
