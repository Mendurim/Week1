require 'pry'
require 'imdb'

# search = Imdb::Search.new("Star Trek")
# specific = search.movies.find {|movie| movie.title.include?'Star Trek'}
# specific.rating

class Rater
	def initialize
		@titles = []
		@search = []
		@ratings = []
	end

	def read_file
		file = IO.read('movies.txt')
		@titles = file.split("\n")
	end

	def read_ratings
		@search = @titles.map do |title|
			search = Imdb::Search.new(title)
		end
		@ratings = @search.map do |search|
			search.movies.find {|movie| movie.title.include?(search.query)}
		end
	end
end

rater = Rater.new
rater.read_file
rater.read_ratings