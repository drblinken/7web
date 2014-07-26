#---
# Excerpted from "Seven Web Frameworks in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
#---
require "sinatra"
require "data_mapper"
require_relative "bookmark"
require "dm-serializer"


DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/bookmarks.db")
# auto_migrate! would re-create the database every time.
DataMapper.finalize.auto_upgrade!

get "/bookmarks/:id" do
  id = params[:id]
  bookmark = Bookmark.get(id)
  content_type :json
  bookmark.to_json
end

put "/bookmarks/:id" do
  id = params[:id]
  bookmark = Bookmark.get(id)
  input = params.slice *bookmark_whitelist
  bookmark.update input
  204 # No Content
end

delete "/bookmarks/:id" do
  id = params[:id]
  bookmark = Bookmark.get(id)
  bookmark.destroy
  200 # OK
end
def get_all_bookmarks
  Bookmark.all(:order => :title)
end
def bookmark_whitelist
  ["url", "title", "creation_date"]
end
get "/bookmarks" do
  content_type :json
  get_all_bookmarks.to_json
end

post "/bookmarks" do
  input = params.slice *bookmark_whitelist
  input["creation_date"] ||= Date.today
  bookmark = Bookmark.create input
  # Created
  [201, "/bookmarks/#{bookmark['id']}"]
end

class Hash
  def slice(*whitelist)
    select{ |k,v| whitelist.include?(k) && !v.nil?}
  end
end
