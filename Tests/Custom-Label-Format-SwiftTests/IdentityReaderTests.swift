//
//  IdentityReaderTests.swift
//  
//
//  Created by Justin White on 4/09/21.
//

import XCTest
@testable import Custom_Label_Format_Swift

class IdentityReaderTests: XCTestCase {
    
    let bundleResourcesFolder: String = "/contents/Resources"
    
    func testIdentityReader_MapFromString_EmptyDictionary() {
        //given
        let input = "{}"
        let reader: IdentityReader = FileIdentityReader()
        
        //when
        let value = reader.identityMapFromString(input: input)
        
        //then
        XCTAssertEqual(value, [:])
    }
    
    func testIdentityReader_MapFromString_BasicOneKeyExample() {
        //given
        let input = "{\"FolderA\":\"Test\"}"
        let reader: IdentityReader = FileIdentityReader()
        
        //when
        let value = reader.identityMapFromString(input: input)
        
        //then
        XCTAssertEqual(value, ["FolderA":"Test"])
    }
    
    func testIdentityReader_MapFromString_BasicTwoKeyExample() {
        //given
        let input = "{\"FolderA\":\"Test\", \"FolderB\":\"Test2\"}"
        let reader: IdentityReader = FileIdentityReader()
        
        //when
        let value = reader.identityMapFromString(input: input)
        
        //then
        XCTAssertEqual(value, ["FolderA":"Test", "FolderB":"Test2"])
    }
    
    func testIdentityReader_MapFromString_BadSyntaxExample() {
        //given
        let input = "{\"FolderA\":}"
        let reader: IdentityReader = FileIdentityReader()
        
        //when
        let value = reader.identityMapFromString(input: input)
        
        //then
        XCTAssertEqual(value, [:])
    }
    
    func testIdentityReader_MapFromString_BadSyntaxExample2() {
        //given
        let input = "{"
        let reader: IdentityReader = FileIdentityReader()
        
        //when
        let value = reader.identityMapFromString(input: input)
        
        //then
        XCTAssertEqual(value, [:])
    }
    
    func testIdentityReader_ReadFromBundle() {
        //given
        let path = Bundle.module.path(forResource: "group1", ofType: "identity")!
        let reader: IdentityReader = FileIdentityReader()

        //when
        let value = reader.readFile(source: path)
        
        //then
        let expectedValue: [String: String] = ["15 Reasons - 15の理由":"-1134391404635171832",
                                               "1999":"6383265587"]
        XCTAssertEqual(value, expectedValue)
    }
}
