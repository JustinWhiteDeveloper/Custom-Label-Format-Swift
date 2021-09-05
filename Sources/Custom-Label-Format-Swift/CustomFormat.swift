//
//  CustomFormat.swift
//  
//
//  Created by Justin White on 5/09/21.
//

import Foundation

public enum MediaType: String, Encodable {
    case Comedy
}

public enum BasicCategory: String, Encodable {
    case TVShow
    case Movie
}

public struct CustomFormatItem: Encodable {
    
    public var mediaType: MediaType?
    
    public var categories: [BasicCategory] = []
}

public struct CustomFormat: Encodable, CustomStringConvertible {
    
    public var items: [String: CustomFormatItem] = [:]
    
    public var description: String {
        return "{}"
    }
}

public protocol CustomFormatWriter {
    func writeFile(destination: String, value: CustomFormat)
}

public class FolderCustomFormatWriter: CustomFormatWriter {
    public func writeFile(destination: String, value: CustomFormat) {
        let encodedValue = value.description
        
        do {
            try encodedValue.write(toFile: destination, atomically: true, encoding: .utf8)
        }
        catch {
            print(error)
        }
    }
}

public protocol CustomFormatReader {
    func readFile(source: String) -> CustomFormat
}

public class FolderCustomFormatReader: CustomFormatReader {
    public func readFile(source: String) -> CustomFormat {
        return CustomFormat()
    }
}
