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
        
        let expectedValue = "{\"items\":{\"test\":{\"isMarked\":false,\"mediaType\":\"Movie\",\"categories\":[],\"identifier\":\"id\"}},\"version\":2}"
        
        //when
        item.items.updateValue(subItem, forKey: "test")

        //then
        XCTAssertEqual(item.description, expectedValue)
        XCTAssertEqual(item.getLabelledIndicies(), [])
        XCTAssertFalse(subItem.isMarked)
        XCTAssertFalse(subItem.isLabelled())
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
        XCTAssertEqual(index, 2)
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
    
    func testCustomFormat_IsLabelled_MarkedAsNotComplete() {
        //given
        var item = CustomFormatItem()
        item.categories = [.Action]
        item.identifier = "id"
        item.mediaType = .Movie
        item.isMarked = true
        
        //when
        let isLabelled = item.isLabelled()

        //then
        XCTAssertFalse(isLabelled)
    }
}
