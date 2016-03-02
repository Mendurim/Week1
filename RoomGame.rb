require 'pry'
module Text
  def start
    puts "Go on"
  end
  def no_exit
    puts "No exit here!"
  end
  def dont_understand
    puts "Sorry, don't understand"
  end

  def win_text
    puts "YOU WIN!"
    puts "Bye!"
  end
end

class Controller
  include Text
  def initialize(player, rooms)
    @player = player
    @rooms = rooms
  end

  def begin
    start
    choice = nil
    until choice == :quit
      puts @player.pos
      print '> '
      entry = get_action
      choice = do_action(entry)
      puts @player.pos
    end
  end

  def get_action
    user_response = gets.chomp.downcase
  end

  def do_action(choice)
    case choice
    when 'n'
      can_leave?(choice) ? move(@player.pos, choice) : no_exit
    when 'w'
      can_leave?(choice) ? move(@player.pos, choice) : no_exit
    when 's'
      can_leave?(choice) ? move(@player.pos, choice) : no_exit
    when 'e'
      can_leave?(choice) ? move(@player.pos, choice) : no_exit
    when 'quit'
      :quit
    else
      dont_understand
    end
  end

  def can_leave?(choice)
    if @rooms[@player.pos - 1].exits.include?(choice)
      true
    else
      false
    end
  end

  def move(player_pos, choice)
    case player_pos
    when 1
      @player.pos = 2
    when 2
      choice == "n" ? @player.pos = 4 : @player.pos = 3
    when 3
      @player.pos = 2
    when 4
    choice == "s" ? @player.pos = 2 : win
    end
  end

  def win
    win_text
    :quit
  end
end

class Player
  attr_accessor :pos
  def initialize
    @pos = 1
  end
end

class Room
  attr_reader :exits
  def initialize(rmnum, exits, item=nil, entity=nil)
    @rmnum = rmnum
    @exits = exits
    @item = item
    @entity = entity
  end
end

class Entity
  def initialize(type)
    @type = type
  end
end

class Item
  def initialize(type)
    @type = type
  end
end


rooms = [
  Room.new(1, ['n']),
  Room.new(2, ['n', 'w'], nil, Entity.new('birds')),
  Room.new(3, ['e'], Item.new('food')),
  Room.new(4, ['w', 's'], nil, Entity.new('beast')),
]

story = Controller.new(Player.new, rooms)
story.begin