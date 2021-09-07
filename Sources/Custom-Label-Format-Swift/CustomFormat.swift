//
//  CustomFormat.swift
//  
//
//  Created by Justin White on 5/09/21.
//

import Foundation

public enum MediaCategory: String, Codable, CaseIterable {
    case Drama
    case Fantasy
    case Comedy
    case SliceOfLife = "Slice Of Life"
    case Action
    case Horror
    case Mystery
    case Romance
    case Thriller
    case Unknown

    public var associatedIndex: Int {
        MediaCategory.allCases.firstIndex(of: self) ?? 0
    }
    
    public static func valueFromIndex(index: Int) -> MediaCategory {
        let values = MediaCategory.allCases
        
        if values.count <= index || index < 0 {
            return .Unknown
        }
        
        return values[index]
    }
}

public enum MediaType: String, Codable, CaseIterable {
    case TVShow = "TV Show"
    case Movie
    case Unknown

    public var associatedIndex: Int {
        MediaType.allCases.firstIndex(of: self) ?? 0
    }
    
    public static func valueFromIndex(index: Int) -> MediaType {
        let values = MediaType.allCases
        
        if values.count <= index || index < 0 {
            return .Unknown
        }
        
        return values[index]
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


