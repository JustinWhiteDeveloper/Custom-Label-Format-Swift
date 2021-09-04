//
//  IdentityReaderTests.swift
//  
//
//  Created by Justin White on 4/09/21.
//

protocol IdentityReader {
    func readFile(source: String) -> [String:String]
}

class FileIdentityReader: IdentityReader {
    func readFile(source: String) -> [String : String] {
        return [:]
    }
}

import XCTest
@testable import Custom_Label_Format_Swift

final class IdentityReaderTests: XCTestCase {
    func testIdentityReader_ReadFromBundle() {
        //given
        let source = ""
        let reader: IdentityReader = FileIdentityReader()
        
        //when
        let value = reader.readFile(source: source)
        
        //then
        XCTAssertEqual(value, [:])
    }
}
