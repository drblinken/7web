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

  def bookmarks_size
    get "/bookmarks"
    bookmarks = JSON.parse(last_response.body)
    bookmarks.size
  end


  it "returns a list of bookmarks" do
    get "/bookmarks"
    expect(last_response).to be_ok
    bookmarks = JSON.parse(last_response.body)
    expect(bookmarks).to be_instance_of(Array)
  end

  it "creates a new bookmark" do
    last_size = bookmarks_size # (1)

    post "/bookmarks",
      {:url => "http://www.test.com", :title => "Test"}

    expect(last_response.status).to eq(201)
    expect(last_response.body).to match(/\/bookmarks\/\d+/) # (2)

    get "/bookmarks"
    bookmarks = JSON.parse(last_response.body)
    expect(bookmarks.size).to eq(last_size + 1) # (3)

  end

  it "updates a bookmark" do
    post "/bookmarks",
      {:url => "http://www.test.com", :title => "Test"}
    bookmark_uri = last_response.body
    id = bookmark_uri.split("/").last # (4)

    put "/bookmarks/#{id}", {:title => "Success"} # (5)
    expect(last_response.status).to eq(204)

    get "/bookmarks/#{id}"
    retrieved_bookmark = JSON.parse(last_response.body)
    expect(retrieved_bookmark["title"]).to eq("Success") # (6)
    # also, the url should not be touched!
    expect(retrieved_bookmark["url"]).to eq("http://www.test.com") # errata-page-8
    expect(retrieved_bookmark["creation_date"]).not_to be_nil
  end

  it "deletes a bookmark" do
    post "/bookmarks",
      {:url => "http://www.test.com", :title => "Test"}

    get "/bookmarks"
    bookmarks = JSON.parse(last_response.body)
    last_size = bookmarks.size

    delete "/bookmarks/#{bookmarks.last['id']}"
    expect(last_response.status).to eq(200)

    expect(bookmarks_size).to eq(last_size - 1)
  end

  context "exercise: creation_date" do
    it "automatically creates a creation_date" do

      post "/bookmarks",
        {:url => "http://www.github.com", :title => "Github"}

      expect(last_response.status).to eq(201)
      bookmark_uri = last_response.body

      get bookmark_uri
      bookmark = JSON.parse(last_response.body)
      expect(bookmark["creation_date"]).to eq(Date.today.to_s)

    end
    it "the creation_date can also be set from outside" do
      yesterday = Date.today.prev_day.to_s
      post "/bookmarks",
        {:url => "http://www.github.com", :title => "Github",
          :creation_date => yesterday}

      expect(last_response.status).to eq(201)
      bookmark_uri = last_response.body

      get bookmark_uri
      bookmark = JSON.parse(last_response.body)
      expect(bookmark["creation_date"]).to eq(yesterday)

    end

    module Enumerable
      def sorted_by?
        each_cons(2).all? { |a, b| ((yield a) <=> (yield b)) >= 0 }
      end
    end

    it "provides a handler that returns the booksmarks sorted by creation date" do
      last_size = bookmarks_size # (1)

      d = Hash.new
      d[:today] = Date.today
      d[:tomorrow] = Date.today.next_day
      d[:yesterday] = Date.today.prev_day
      d[:before_yesterday] = d[:yesterday].prev_day
      days = [:yesterday,:tomorrow,:before_yesterday,:today]
      days.each do |day|
        post "/bookmarks",
        {:url => "http://www.github.com", :title => "At #{day}",
          :creation_date => d[day].to_s}
      end

      get "/bookmarks_sorted"
      bookmarks = JSON.parse(last_response.body)
      expect(bookmarks.size).to eq(last_size + 4)

      expect(bookmarks.sorted_by?{ |b| Date.strptime(b["creation_date"])}).to be_truthy

    end

  end
end
