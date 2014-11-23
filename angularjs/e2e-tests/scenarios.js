'use strict';
/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
describe("e2e-tests.js", function() {
  describe("Bookmark list", function() {
    
    var bookmarksCount;

    beforeEach(function() {
      browser.get("/");
      
      element.all(by.repeater("bookmark in bookmarks")).count().then(
        function(originalCount) {
          bookmarksCount = originalCount;
        });
    });
    it("should display a bookmark list", function() {
      var bookmarklist = element.all(by.repeater("bookmark in bookmarks"));
      expect(bookmarklist.count()).toBeGreaterThan(0);
    });

    it("should add a new bookmark", function() {
      var urlField = element(by.model('formBookmark.bookmark.url'));
      urlField.sendKeys('http://angular.github.io/protractor');
      var titleField = element(by.model('formBookmark.bookmark.title'));
      titleField.sendKeys('Protractor');
      var saveButton = element(by.id("savebutton"));
      saveButton.click(); 
      var bookmarklist = element.all(by.repeater("bookmark in bookmarks"));
      expect(bookmarklist.count()).toBe(bookmarksCount + 1); 
    });
  });
});
