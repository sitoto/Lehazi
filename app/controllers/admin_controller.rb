class AdminController < ApplicationController
  def index
    @total_infos = Info.count
  end

end
