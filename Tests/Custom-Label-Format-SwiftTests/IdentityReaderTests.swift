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
    
    private let expectedFileType = "identity"
    
    func readFile(source: String) -> [String : String] {
        
        let pathExtension = (source as NSString).pathExtension
        
        if pathExtension != expectedFileType {
            return [:]
        }
        
        do {
            let data = try String(contentsOfFile: source)
            return identityMapFromString(input: data)
        }
        catch {
            print(error)
            return [:]
        }
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
