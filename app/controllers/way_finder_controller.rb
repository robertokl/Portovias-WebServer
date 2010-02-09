class WayFinderController < ApplicationController
	def find_way
		render :text => find_best_way
	end
end
