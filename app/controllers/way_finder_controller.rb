class WayFinderController < ApplicationController
	require "#{RAILS_ROOT}/lib/portovias.rb"
	def find_way
	  ways = find_best_way
    response = ""
	  respond_to do |format|
  	  format.html do
       	ways.keys.each do |key|
       		response << "<h4>#{key}</h4>"
       		response << "#{ways[key][1]}: #{ways[key][0]}<p/>"
       	end
  	  end
  	  format.xml do
      	ways.keys.each do |key|
      		response << "#{key}\n"
      		response << "#{ways[key][1]}: #{ways[key][0]}\n\n"
      	end  	   
  	  end  
  	  render :text => response
	  end
	end
end
