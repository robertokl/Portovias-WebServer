class WayFinderController < ApplicationController
	require "#{RAILS_ROOT}/lib/portovias.rb"
	def find_way
		render :text => RAILS_ROOT
	end
end
