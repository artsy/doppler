class PagesController < ApplicationController
  def show
    fail 'Invalid Id' unless params[:id] =~ /^\w*$/
    filename = Rails.root.join("public/content/#{params[:id]}.md")
    @content = Rails.cache.fetch "content/#{params[:id]}/#{File.mtime(filename)}" do
      File.read(filename)
    end
  end
end
