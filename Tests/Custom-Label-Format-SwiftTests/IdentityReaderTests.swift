//
//  IdentityReaderTests.swift
//  
//
//  Created by Justin White on 4/09/21.
//

protocol IdentityReader {
    func readFile(source: String) -> [String:String]
    
    func identityMapFromString(input: String) -> [String : String]
}

class FileIdentityReader: IdentityReader {
    
    func readFile(source: String) -> [String : String] {
        return [:]
    }
    
    func identityMapFromString(input: String) -> [String : String] {
        do {
            guard let data = input.data(using: .utf8),
                  let value = try JSONSerialization
                        .jsonObject(with: data, options: []) as? [String: String] else {
                return [:]
            }
            
            return value
        }
        catch {
            print(error)
            return [:]
        }
    }
}


import XCTest
@testable import Custom_Label_Format_Swift

final class IdentityReaderTests: XCTestCase {
    
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
        let source = ""
        let reader: IdentityReader = FileIdentityReader()
        
        //when
        let value = reader.readFile(source: source)
        
        //then
        XCTAssertEqual(value, [:])
    }
}
