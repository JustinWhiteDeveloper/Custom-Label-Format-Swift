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
        XCTAssertEqual(value.version, 2)
        XCTAssertEqual(value.items.count, 1)
        XCTAssertNotNil(value.items["a"])
        XCTAssertTrue(value.items["a"]?.isMarked ?? false)

    }
}
