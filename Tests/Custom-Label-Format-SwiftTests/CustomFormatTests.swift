//
//  CustomFormatTests.swift
//
//
//  Created by Justin White on 5/09/21.
//

import XCTest
@testable import Custom_Label_Format_Swift

class CustomFormatTests: XCTestCase {

    func testCustomFormat_CustomValueEncoding() {
        //given
        var item = CustomFormat()
        var subItem = CustomFormatItem()
        subItem.categories = []
        subItem.identifier = "id"
        subItem.mediaType = .Movie
        
        let expectedValue = "{\"items\":{\"test\":{\"isMarked\":false,\"mediaType\":\"Movie\",\"categories\":[],\"identifier\":\"id\",\"subItemCount\":0}},\"version\":3}"
        
        //when
        item.items.updateValue(subItem, forKey: "test")

        //then
        XCTAssertEqual(item.description, expectedValue)
        XCTAssertEqual(item.getLabelledIndicies(), [])
        XCTAssertFalse(subItem.isMarked)
        XCTAssertFalse(subItem.isLabelled())
        XCTAssertEqual(subItem.displayName, "*")
    }
    
    func testCustomFormat_OptionalValues() {
        //given
        var item = CustomFormat()
        item.folderName = "folder"
        
        var subItem = CustomFormatItem()
        subItem.name = "test1"
        subItem.identifier = "abcd"
        subItem.folderName = "test2"
        
        let expectedValue = "{\"items\":{\"test\":{\"isMarked\":false,\"subItemCount\":0,\"folderName\":\"test2\",\"name\":\"test1\",\"identifier\":\"abcd\",\"categories\":[]}},\"version\":3,\"folderName\":\"folder\"}"
        
        //when
        item.items.updateValue(subItem, forKey: "test")

        //then
        XCTAssertEqual(item.description, expectedValue)
        XCTAssertEqual(item.items["test"]?.displayName, "test1")
    }
    
    func testCustomFormat_FolderNameIsDefaultDisplayName() {
        //given
        var item = CustomFormatItem()
        
        //when
        item.folderName = "test1"

        //then
        XCTAssertEqual(item.displayName, "test1")
    }
    
    func testCustomFormat_LabelledIndicies() {
        //given
        var item = CustomFormat()
        var subItem = CustomFormatItem()
        subItem.categories = [.Action]
        subItem.identifier = "id"
        subItem.mediaType = .Movie
        
        //when
        item.items.updateValue(subItem, forKey: "test")

        //then
        XCTAssertFalse(subItem.isMarked)
        XCTAssertTrue(subItem.isLabelled())
        XCTAssertEqual(item.getLabelledIndicies(), ["test"])
    }
    
    func testCustomFormat_MediaTypeAssociatedValues() {
        //given
        let index = MediaType.Movie.associatedIndex
        let value = MediaType.valueFromIndex(index: index)
        
        //when
        //then
        XCTAssertEqual(index, 1)
        XCTAssertEqual(value, .Movie)
        XCTAssertEqual(MediaType.defaultIndex, MediaType.Unknown.associatedIndex)
        XCTAssertEqual(MediaType.defaultValue, MediaType.Unknown)

    }
    
    func testCustomFormat_MediaCategoryAssociatedValues() {
        //given
        let index = MediaCategory.Comedy.associatedIndex
        let value = MediaCategory.valueFromIndex(index: index)
        
        //when
        //then
        XCTAssertEqual(index, 3)
        XCTAssertEqual(value, .Comedy)
        XCTAssertEqual(MediaCategory.defaultIndex, MediaCategory.Unknown.associatedIndex)
        XCTAssertEqual(MediaCategory.defaultValue, MediaCategory.Unknown)
    }
    
    func testCustomFormat_IsLabelled_ValuesProvided() {
        //given
        var item = CustomFormatItem()
        item.categories = [.Action]
        item.identifier = "id"
        item.mediaType = .Movie

        //when
        let isLabelled = item.isLabelled()

        //then
        XCTAssertTrue(isLabelled)
    }
    
    func testCustomFormat_IsLabelled_MissingCategory() {
        //given
        var item = CustomFormatItem()
        item.categories = []
        item.identifier = "id"
        item.mediaType = .Movie

        //when
        let isLabelled = item.isLabelled()

        //then
        XCTAssertFalse(isLabelled)
    }
    
    func testCustomFormat_IsLabelled_MissingType() {
        //given
        var item = CustomFormatItem()
        item.categories = []
        item.identifier = "id"

        //when
        let isLabelled = item.isLabelled()

        //then
        XCTAssertFalse(isLabelled)
    }
    
    func testCustomFormat_IsLabelled_Unknown() {
        //given
        var item = CustomFormatItem()
        item.categories = [.Unknown]
        item.identifier = "id"
        item.mediaType = .Unknown

        //when
        let isLabelled = item.isLabelled()

        //then
        XCTAssertFalse(isLabelled)
    }
    
    func testCustomFormat_IsLabelled_MarkedStillComplete() {
        //given
        var item = CustomFormatItem()
        item.categories = [.Action]
        item.identifier = "id"
        item.mediaType = .Movie
        item.isMarked = true
        
        //when
        let isLabelled = item.isLabelled()

        //then
        XCTAssertTrue(isLabelled)
    }
    
    func testCustomFormat_AddTogetherTwoItems() {
        //given
        var item1 = CustomFormatItem()
        item1.categories = [.Action]
        item1.identifier = "id"
        item1.mediaType = .Movie
        
        var customFormat1 = CustomFormat()
        customFormat1.folderName = "p"
        customFormat1.items = ["a": item1]
        
        var item2 = CustomFormatItem()
        item2.categories = [.Adventure]
        item2.identifier = "id2"
        item2.mediaType = .TVShow
        
        var customFormat2 = CustomFormat()
        customFormat2.folderName = "o"
        customFormat2.items = ["b": item2]
        
        
        //when
        let customFormat3 = customFormat1 + customFormat2

        //then
        XCTAssertEqual(customFormat3.folderName, "p,o")
        XCTAssertEqual(customFormat3.items.keys.sorted(), ["a", "b"])
        XCTAssertEqual(customFormat3.items["a"]?.categories, [.Action])
        XCTAssertEqual(customFormat3.items["b"]?.categories, [.Adventure])
    }
}
