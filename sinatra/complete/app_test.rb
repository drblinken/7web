#---
# Excerpted from "Seven Web Frameworks in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
#---
require_relative "app"
require "rspec"
require "rack/test"
require "json"

describe "Bookmarking App" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def get_json_bookmarks
    get "/bookmarks", {}, {"HTTP_ACCEPT" => "application/json"}
  end

  def get_html_bookmarks
    get "/bookmarks", {}, {"HTTP_ACCEPT" => "text/html"}
  end

  it "returns a list of JSON bookmarks" do
    get_json_bookmarks
    expect(last_response).to be_ok
    bookmarks = JSON.parse(last_response.body)
    expect(bookmarks).to be_instance_of(Array)
    bookmarks.each do |bookmark|
      expect(bookmark["id"]).not_to be_zero
      expect(bookmark["url"].length).not_to be_zero
      expect(bookmark["title"].length).not_to be_zero
    end
  end

  it "returns a list of HTML bookmarks" do
    get_html_bookmarks
    expect(last_response).to be_ok
    expect(last_response.body.include?("List of Bookmarks")).to be_truthy
  end

  it "creates a new bookmark" do
    get_json_bookmarks
    bookmarks = JSON.parse(last_response.body)
    last_size = bookmarks.size

    post "/bookmarks",
      {:url => "http://www.test.com", :title => "Test"},
      {"HTTP_ACCEPT" => "application/json"}
    expect(last_response.status).to eq(201)
    expect(last_response.body).to match(/\/bookmarks\/\d+/)

    get_json_bookmarks
    bookmarks = JSON.parse(last_response.body)
    expect(bookmarks.size).to eq(last_size + 1)
  end

  it "updates a bookmark" do
    url = "http://www.test.com"
    post "/bookmarks",
      {:url => url, :title => "Test"},
      {"HTTP_ACCEPT" => "application/json"}
    bookmark_uri = last_response.body
    id = bookmark_uri.split("/").last
    
    put "/bookmarks/#{id}", {:url => url, :title => "Success"},
      {"HTTP_ACCEPT" => "text/html"}
    expect(last_response.status).to eq(302)

    get "/bookmarks/#{id}", {}, {"HTTP_ACCEPT" => "application/json"}
    retrieved_bookmark = JSON.parse(last_response.body)
    expect(retrieved_bookmark["title"]).to eq("Success")
  end

  it "deletes a bookmark" do
    post "/bookmarks",
      {:url => "http://www.test.com", :title => "Test"}
    get_json_bookmarks
    bookmarks = JSON.parse(last_response.body)
    last_size = bookmarks.size
    
    delete "/bookmarks/#{bookmarks.last['id']}"
    expect(last_response.status).to eq(302)

    get_json_bookmarks
    bookmarks = JSON.parse(last_response.body)
    expect(bookmarks.size).to eq(last_size - 1)
  end
end
