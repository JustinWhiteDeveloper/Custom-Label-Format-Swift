//
//  CustomFormat.swift
//  
//
//  Created by Justin White on 5/09/21.
//

import Foundation

public enum MediaCategory: String, Encodable, CaseIterable {
    case Drama
    case Fantasy
    case Comedy
    case SliceOfLife = "Slice Of Life"
    case Action
    case Horror
    case Mystery
    case Romance
    case Thriller
}

public enum MediaType: String, Encodable, CaseIterable {
    case TVShow = "TV Show"
    case Movie
}

public struct CustomFormatItem: Encodable {
    
    public init() {
        
    }
    
    public var identifier: String?
    
    public var mediaType: MediaType?
    
    public var categories: [MediaCategory] = []
    
    public var overrideName: String?
    
    public var imageUrl: String?
}

public struct CustomFormat: Encodable, CustomStringConvertible {
    
    public init() {
        
    }
    
    public var items: [String: CustomFormatItem] = [:]
    
    public var description: String {
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(items)
            let json = String(data: jsonData, encoding: String.Encoding.utf16)
            
            return json ?? "{}"
        }
        catch {
            print(error)
            return "{}"
        }
    }
}


