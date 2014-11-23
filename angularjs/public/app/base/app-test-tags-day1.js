/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
describe("base/app-test.js", function() {
  beforeEach(function() {
    module("App_base");
  });

  // Add tests here

  describe("Bookmark with Tags resource", function() {
    var mockBookmarks = null;
    var bookMarksTaggedTwo = null;
    beforeEach(inject(function($httpBackend, Bookmark) { 
      mockBookmarks = [
        new Bookmark({id:1, tagList: ["One","Two"]}), new Bookmark({id:2,tagList: ["Two","Three"]}), new Bookmark({id:3,tagList: ["Three"]})
      ];
      bookMarksTaggedTwo = [mockBookmarks[0],mockBookmarks[1]]
      $httpBackend.expectGET("/bookmarks").respond(mockBookmarks);
      
    }));
    it("should retrieve bookmarks", inject(function($httpBackend, bookmarks) { 
      $httpBackend.flush();
      expect(bookmarks.length).toBe(mockBookmarks.length); 
    }));

    it("should retrieve bookmarks with one tag", inject(function($httpBackend, bookmarks,bookmarksWithTags) { 
      $httpBackend.flush();
      $httpBackend.expectGET("/bookmarks/Two").respond(bookMarksTaggedTwo); 
      var tagged = bookmarksWithTags("Two");
      $httpBackend.flush();
      expect(tagged.length).toBe(bookMarksTaggedTwo.length); 
    }));

    it("should retrieve bookmarks with two tags", inject(function($httpBackend, bookmarks,bookmarksWithTags) { 
      $httpBackend.flush();
      $httpBackend.expectGET("/bookmarks/One/Two").respond([mockBookmarks[0]]); 
      var tagged = bookmarksWithTags("One","Two");
      $httpBackend.flush();
      expect(tagged.length).toBe(1); 
    }));
    
  });
});
