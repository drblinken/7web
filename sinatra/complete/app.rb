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
require_relative "tag"
require_relative "tagging"

require "dm-serializer"
require "sinatra/respond_with"
require "slim"

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/bookmarks.db")
#DataMapper.finalize.auto_migrate!
DataMapper.finalize.auto_upgrade!

A_BOOKMARK = %r{/bookmarks/(\d+)}

before A_BOOKMARK do |id|
  @bookmark = Bookmark.get(id)
  unless @bookmark
    halt 404, "bookmark #{id} not found"
  end
end

with_tagList = {:methods => [:tagList]}

get A_BOOKMARK do
  respond_to do |f|
    f.html { slim :bookmark_form_edit}
    f.json { @bookmark.to_json with_tagList}
  end
 # respond_with :bookmark_form_edit, @bookmark
  #  @bookmark.to_json with_tagList

end

put A_BOOKMARK do
  input = params.slice "url", "title"
  if @bookmark.update(input)
  add_tags(@bookmark)
    respond_to do |f|
      f.html { redirect "/" }
      f.json { 204 }
    end

  else
    400 # Bad Request
  end
end


delete A_BOOKMARK do
  @bookmark.destroy
  respond_to do |f|
    f.html { redirect "/" }
    f.json { 200 }
  end
end

def get_all_bookmarks
  Bookmark.all(:order => :title)
end

get "/bookmarks" do
  @bookmarks = get_all_bookmarks
 # respond_with :bookmark_list, @bookmarks
  respond_to do |f|
    f.html { slim :bookmark_list }
    f.json { @bookmarks.to_json with_tagList }
  end
end

get "/bookmarks/*" do
  tags = params[:splat].first.split "/"
  @bookmarks = get_all_bookmarks
  tags.each do |tag|
    @bookmarks = @bookmarks.all({:taggings => {:tag => {:label => tag}}})
  end
  respond_to do |f|
    f.html { slim :bookmark_list }
    f.json { @bookmarks.to_json with_tagList }
  end
end


post "/bookmarks" do
  input = params.slice "url", "title"
  bookmark = Bookmark.new input
  add_tags(bookmark)

  unless bookmark.save
    400 # Bad Request
  else
    respond_to do |f|
      f.html { redirect "/" }
      f.json { [201, "/bookmarks/#{bookmark['id']}"] }
    end
  end
end

get "/" do
  @bookmarks = get_all_bookmarks
  slim :bookmark_list # renders views/bookmark_list.slim
end

get "/bookmark/new" do
  slim :bookmark_form_new
end

helpers do
  def add_tags(bookmark)
    labels = (params["tagsAsString"] || "").split(",").map(&:strip)
    # more code to come

    existing_labels = []
    bookmark.taggings.each do |tagging|
      if labels.include? tagging.tag.label
        existing_labels.push tagging.tag.label
      else
        tagging.destroy
      end
    end

    (labels - existing_labels).each do |label|
      tag = {:label => label}
      existing = Tag.first tag
      if !existing
        existing = Tag.create tag
      end
      Tagging.create :tag => existing, :bookmark => bookmark
    end
  end
end

class Hash
  def slice(*whitelist)
    whitelist.inject({}) {|result, key| result.merge(key => self[key])}
  end
end


