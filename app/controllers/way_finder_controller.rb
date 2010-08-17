class WayFinderController < ApplicationController
  def find_way
    ways = Portovias.find_best_way unless params[:login]
    ways = Portovias.find_best_way(params[:login], params[:password]) if params[:login]
    response = ""
    respond_to do |format|
      format.html do
        response << build_response(ways)
      end
      format.xml do
        response <<  build_response(ways, "%s\n", "\n")
      end  
      render :text => response
    end 
  end
  
  private
  def build_response(ways, header = "<h4>%s</h4>", delimiter = "</br>")
    response = ""
    ways.keys.each do |key|
      response << "#{header % key}"
      response << "#{ways[key][0][1]}: #{ways[key][0][0]}min#{delimiter}"
      response << "#{ways[key][1][1]}: #{ways[key][1][0]}min#{delimiter}#{delimiter}"
    end
    return response
  end
end
