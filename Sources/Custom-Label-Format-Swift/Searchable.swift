//
//  Searchable.swift
//  
//
//  Created by Justin White on 17/09/21.
//

import Foundation

public protocol Searchable: CaseIterable {
    
    associatedtype SearchType: CaseIterable,
                               RawRepresentable where SearchType.RawValue == String
    
    var associatedIndex: Int { get }
    
    func associatedIndexWithOffset(offset: Int) -> Int
    
    static var defaultIndex: Int { get }
    
    static var defaultValue: SearchType { get }
    
    static func valueFromIndex(index: Int, offset: Int) -> SearchType
    
    static func from(storedValue: String) -> SearchType
}

public extension Searchable {

    func associatedIndexWithOffset(offset: Int) -> Int {
        let index = associatedIndex + offset
        
        if index < 0 || index >= SearchType.allCases.count {
            return Self.defaultIndex
        }
        
        return index
    }
    
    static func valueFromIndex(index: Int) -> SearchType {
        return valueFromIndex(index: index, offset: 0)
    }
    
    static func from(storedValue: String) -> SearchType {
        return SearchType(rawValue: storedValue) ?? defaultValue
    }
}

public enum MediaCategory: String, Codable {
    
    case Action
    case Adventure
    case Comedy
    case Crime
    case Documentary
    case Drama
    case Fantasy
    case Horror
    case Mystery
    case Romance
    case SciFi
    case SliceOfLife = "Slice Of Life"
    case Other
    case Unknown
}

extension MediaCategory: Searchable {
    
    public var associatedIndex: Int {
        return MediaCategory.allCases.firstIndex(of: self) ?? 0
    }
    
    public static var defaultIndex: Int {
        return MediaCategory.defaultValue.associatedIndex
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

public enum MediaType: String, Codable {
    case TVShow = "TV Show"
    case Movie
    case AnimeMovie = "Anime Movie"
    case AnimeSeries = "Anime Series"
    case TalkShow = "Talk Show"
    case Unknown
}

extension MediaType: Searchable {
    public var associatedIndex: Int {
        return MediaType.allCases.firstIndex(of: self) ?? 0
    }
    
    public static var defaultIndex: Int {
        return MediaType.defaultValue.associatedIndex
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
