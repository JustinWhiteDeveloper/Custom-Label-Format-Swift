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
        subItem.imageUrl = "img"
        subItem.mediaType = .Movie
        subItem.overrideName = "name"
        
        let expectedValue = "{\"items\":{\"test\":{\"mediaType\":\"Movie\",\"overrideName\":\"name\",\"categories\":[],\"identifier\":\"id\",\"imageUrl\":\"img\"}}}"
        
        //when
        item.items.updateValue(subItem, forKey: "test")

        //then
        XCTAssertEqual(item.description, expectedValue)
        XCTAssertEqual(item.getLabelledIndicies(), [])
    }
    
    func testCustomFormat_LabelledIndicies() {
        //given
        var item = CustomFormat()
        var subItem = CustomFormatItem()
        subItem.categories = [.Action]
        subItem.identifier = "id"
        subItem.imageUrl = "img"
        subItem.mediaType = .Movie
        subItem.overrideName = "name"
        
        //when
        item.items.updateValue(subItem, forKey: "test")

        //then
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
    }
    
    func testCustomFormat_MediaCategoryAssociatedValues() {
        //given
        let index = MediaCategory.Comedy.associatedIndex
        let value = MediaCategory.valueFromIndex(index: index)
        
        //when
        //then
        XCTAssertEqual(index, 2)
        XCTAssertEqual(value, .Comedy)
    }
    
    func testCustomFormat_IsLabelled_ValuesProvided() {
        //given
        var item = CustomFormatItem()
        item.categories = [.Action]
        item.identifier = "id"
        item.imageUrl = "img"
        item.mediaType = .Movie
        item.overrideName = "name"

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
        item.imageUrl = "img"
        item.mediaType = .Movie
        item.overrideName = "name"

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
        item.imageUrl = "img"
        item.overrideName = "name"

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
        item.imageUrl = "img"
        item.overrideName = "name"
        item.mediaType = .Unknown

        //when
        let isLabelled = item.isLabelled()

        //then
        XCTAssertFalse(isLabelled)
    }
}