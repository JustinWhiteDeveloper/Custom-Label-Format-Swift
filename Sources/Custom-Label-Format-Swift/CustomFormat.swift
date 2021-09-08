//
//  CustomFormat.swift
//  
//
//  Created by Justin White on 5/09/21.
//

import Foundation

public protocol Searchable: CaseIterable {
    
    associatedtype SearchType: CaseIterable, RawRepresentable where SearchType.RawValue == String
    
    var associatedIndex: Int { get }

    
    static var defaultValue: SearchType { get }
    static func valueFromIndex(index: Int, offset: Int) -> SearchType
    static func from(storedValue: String) -> SearchType
}

public extension Searchable {

    static func valueFromIndex(index: Int) -> SearchType {
        return valueFromIndex(index: index, offset: 0)
    }
    
    static func from(storedValue: String) -> SearchType {
        return SearchType(rawValue: storedValue) ?? defaultValue
    }
}

public enum MediaCategory: String, Codable, Searchable {
    case Drama
    case Fantasy
    case Comedy
    case SliceOfLife = "Slice Of Life"
    case Action
    case Horror
    case Mystery
    case Romance
    case Unknown
    
    
    public var associatedIndex: Int {
        return MediaCategory.allCases.firstIndex(of: self) ?? 0
    }
    
    public static var defaultValue: MediaCategory {
        return .Unknown
    }

    public static func valueFromIndex(index: Int, offset: Int = 0) -> MediaCategory {
        let values = MediaCategory.allCases
        
        let adjustedIndex = index + offset
        
        if values.count <= adjustedIndex || adjustedIndex < 0 {
            return defaultValue
        }
        
        return values[adjustedIndex]
    }
}

public enum MediaType: String, Codable, Searchable {
    case TVShow = "TV Show"
    case Movie
    case Unknown

    
    public var associatedIndex: Int {
        return MediaType.allCases.firstIndex(of: self) ?? 0
    }
    
    public static var defaultValue: MediaType {
        return .Unknown
    }
    
    public static func valueFromIndex(index: Int, offset: Int = 0) -> MediaType {
        let values = MediaType.allCases
        
        let adjustedIndex = index + offset
        
        if values.count <= adjustedIndex || adjustedIndex < 0 {
            return defaultValue
        }
        
        return values[adjustedIndex]
    }
}

public struct CustomFormatItem: Codable {
    
    public init() {
        
    }
    
    public var identifier: String?
    
    public var mediaType: MediaType?
    
    public var categories: [MediaCategory] = []
    
    public var overrideName: String?
    
    public var imageUrl: String?
    
    func isLabelled() -> Bool {
        let setMediaType = mediaType != nil && mediaType != MediaType.Unknown
        let setCategoryType = categories.count > 0

        return setMediaType && setCategoryType
    }
}

public struct CustomFormat: Codable, CustomStringConvertible {
    
    public init() {
        
    }
    
    public var items: [String: CustomFormatItem] = [:]
    
    public var description: String {
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(self)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            return json ?? "{}"
        }
        catch {
            print(error)
            return "{}"
        }
    }
}


