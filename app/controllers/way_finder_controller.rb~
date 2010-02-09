class WayFinderController < ApplicationController
	require "#{RAILS_ROOT}/lib/portovias.rb"
	def find_way
		html = ""
		ways = find_best_way
		ways.keys.each do |key|
			html << "<h4>#{key}</h4:"
			html << "<br>#{ways[key][1]}: #{ways[key][0]}<p/>"
		end
		render :text => html
	end
end
