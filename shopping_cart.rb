class Shopping_cart

	attr_reader :list_items

	def initialize
		@list_items = {}
		@cost = 0
	end

	def add_item(item)
		if !@list_items[item.name.to_sym]
			@list_items[item.name.to_sym] = [1, item.price, item.discount]
		else
			@list_items[item.name.to_sym][0] += 1
		end
	end

	def cost
		@cost = @list_items.reduce(0) do |memo, (key, value)|
			memo += value[0]*value[1]
		end
	end

	def list_for_ticket
		list = ""
		@list_items.each do |key, value|
			list += "#{value[0]} x #{key}, $#{value[1]} each \n"
		end
		list
	end

	def show_ticket
		puts "Your list of items:"
		puts list_for_ticket
		puts "Total cost: $#{cost}"
	end

end

class Discounts
	def initialize
	end

	def for_apples
	end

	def for_oranges
	end

	def for_grapes
	end
end

class Item
	attr_reader :name, :price, :discount
	def initialize(name, price, discount = false)
		@name = name
		@price = price
		@discount = discount
	end
end

apple = Item.new("apple", 10, true)
banana = Item.new("banana", 40)
orange = Item.new("orange", 5, true)
grape = Item.new("grape", 15, true)
watermelon = Item.new("watermelon", 50)

mendurim = Shopping_cart.new
mendurim.add_item apple
mendurim.add_item banana
mendurim.add_item banana
mendurim.add_item watermelon



mendurim.show_ticket