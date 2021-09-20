//
//  CustomFormatReaderTests.swift
//
//  Created by Justin White on 5/09/21.
//

import XCTest
@testable import Custom_Label_Format_Swift

class CustomFormatReaderTests: XCTestCase {

    func testFormatReader_ReadFromBundle() {
        //given
        let path = Bundle.module.path(forResource: "test1", ofType: "clabel")!
        let reader: CustomFormatReader = FolderCustomFormatReader()
        
        //when
        let value = reader.readFile(source: path)
        
        //then
        XCTAssertEqual(value.version, 3)
        XCTAssertEqual(value.items.count, 1)
        XCTAssertNotNil(value.items["a"])
        XCTAssertEqual(value.items["a"]?.isMarked, true)
        XCTAssertEqual(value.items["a"]?.subItemCount,1)
    }
    
    func testFormatReader_ReadSourceFromBundle() {
        //given
        let path = Bundle.module.bundlePath
        let reader: CustomFormatReader = FolderCustomFormatReader()
        
        //when
        let value = reader.readFolder(source: path + "/contents" )
        
        //then
        XCTAssertEqual(value.version, 3)
        XCTAssertEqual(value.items.count, 1)
        XCTAssertEqual(value.items.first?.value.folderName, "Resources")
        XCTAssertEqual(value.items.first?.value.subItemCount, 2)
    }
}
