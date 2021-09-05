//
//  CustomFormat.swift
//  
//
//  Created by Justin White on 5/09/21.
//

import Foundation

public enum MediaType: String, Encodable, CaseIterable {
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

public enum MediaCategory: String, Encodable, CaseIterable {
    case TVShow = "TV Show"
    case Movie
}

public struct CustomFormatItem: Encodable {
    public var identifier: String?
    
    public var mediaType: MediaType?
    
    public var categories: [MediaCategory] = []
    
    public var overrideName: String?
    
    public var imageUrl: String?
}

public struct CustomFormat: Encodable, CustomStringConvertible {
    
    public var items: [String: CustomFormatItem] = [:]
    
    public var description: String {
        return "{}"
    }
}


