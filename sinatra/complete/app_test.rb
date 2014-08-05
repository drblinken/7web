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
  before (:each) do
    DataMapper.finalize.auto_migrate!
  end

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
  it "returns a list of JSON bookmarks including taglists" do
    get_json_bookmarks
    expect(last_response).to be_ok
    bookmarks = JSON.parse(last_response.body)
    expect(bookmarks).to be_instance_of(Array)
    bookmarks.each do |bookmark|
      expect(bookmark["tagList"]).not_to be_nil
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

  it "gets a single bookmark in JSON" do
    bookmark = Bookmark.create(title: "Created by Test", url: "http://drblinken.github.io")
    id = bookmark.id
    get "/bookmarks/#{id}", {}, {"HTTP_ACCEPT" => "application/json"}
    retrieved_bookmark = JSON.parse(last_response.body)
    expect(retrieved_bookmark["title"]).to eq("Created by Test")
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

  describe "Validation" do

    it "sends an error code for an invalid get request" do
      get "/bookmarks/0"
      expect(last_response.status).to eq(404)
    end

    it "sends an error code for an invalid put request" do
      put "/bookmarks/0", {:title => "Success"}
      expect(last_response.status).to eq(404)
    end

    it "sends an error code for an invalid delete request" do
      delete "/bookmarks/0"
      expect(last_response.status).to eq(404)
    end

    it "sends an error code for an invalid create request" do
      post "/bookmarks", {:url => "test", :title => "Test"}
      expect(last_response.status).to eq(400)
    end

    it "sends an error code for an invalid update request" do
      Bookmark.create(:url => "http://www.test.com", :title => "Test")
      get_json_bookmarks
      bookmarks = JSON.parse(last_response.body)
      id = bookmarks.first['id']

      put "/bookmarks/#{id}", {:url => "Invalid"}
      expect(last_response.status).to eq(400)
    end

  end

  describe "Tagging" do

    it "creates and updates a bookmark with tags" do
      post "/bookmarks",
        {:url => "http://www.test.com", :title => "Test",
         :tagsAsString => "One, Two"}, {"HTTP_ACCEPT" => "application/json"}
      expect(last_response.status).to eq(201)
      link = last_response.body
      expect(link).to match(/\/bookmarks\/\d+/)

      get link, {}, {"HTTP_ACCEPT" => "application/json"}
      bookmark = JSON.parse(last_response.body)
      expect(bookmark["tagList"].size).to eq(2)
      expect(bookmark["tagList"][0]).to eq("One")
      expect(bookmark["tagList"][1]).to eq("Two")

      put "/bookmarks/#{bookmark["id"]}", {:url => bookmark["url"],
        :title => bookmark["title"], :tagsAsString => " Four ,  Two "}, {"HTTP_ACCEPT" => "application/json"}
      expect(last_response.status).to eq(204)

      get link, {}, {"HTTP_ACCEPT" => "application/json"}
      bookmark = JSON.parse(last_response.body)
      expect(bookmark["tagList"].size).to eq(2)
      expect(bookmark["tagList"][0]).to eq("Four")
      expect(bookmark["tagList"][1]).to eq("Two")
    end

    it "filters bookmarks by tags" do
      post "/bookmarks",
        {:url => "http://www.test2.com", :title => "Test2",
         :tagsAsString => "Tag1,Tag2"}, {"HTTP_ACCEPT" => "application/json"}

      post "/bookmarks",
        {:url => "http://www.test4.com", :title => "Test4",
         :tagsAsString => "Tag4,Tag1"}, {"HTTP_ACCEPT" => "application/json"}

      get "/bookmarks/Tag1/Tag4", {}, {"HTTP_ACCEPT" => "application/json"}
      bookmarks = JSON.parse(last_response.body)
      expect(bookmarks.size).to eq(1)
      expect(bookmarks[0]["title"]).to eq("Test4")

      get "/bookmarks/Tag1", {}, {"HTTP_ACCEPT" => "application/json"}
      bookmarks = JSON.parse(last_response.body)
      expect(bookmarks.size).to eq(2)

      bookmarks.each do |bookmark|
        delete "/bookmarks/#{bookmark['id']}"
        expect(last_response.status).to eq(302)
      end
    end
    describe "is editable via html" do
      require 'capybara'
      require 'capybara/dsl'
      include Capybara::DSL
      before (:each) do
        Capybara.app = app
      end
      it "accepts tagLists from the form" do
        visit "/bookmark/new"
        fill_in 'URL', :with => 'http://drblinken.github.io'
        fill_in 'Title', :with => 'drblinken'
        fill_in 'Tags', :with => 'uno, dos, tres'
        click_on 'Save'
       # save_and_open_page
        expect(page).to have_content("uno, dos, tres")
      end
    end
  end

end
