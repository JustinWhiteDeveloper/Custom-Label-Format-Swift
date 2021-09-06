//
//  CustomFormatWriterTests.swift
//  
//
//  Created by Justin White on 5/09/21.
//

import XCTest
@testable import Custom_Label_Format_Swift

class CustomFormatWriterTests: XCTestCase {

    func testFormatWriter_WriteEmptyFormat() {
        //given
        let destination = "item1.json"
        let writer: CustomFormatWriter = FolderCustomFormatWriter()
        
        let item = CustomFormat()
        
        //when
        writer.writeFile(destination: destination, value: item)
        
        //then
        XCTAssertTrue(FileManager.default.fileExists(atPath: destination))
    }
    
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
    }
}
