//
//  CustomFormat.swift
//  
//
//  Created by Justin White on 5/09/21.
//

import Foundation

public struct CustomFormatItem: Codable {
    
    public var identifier: String?
    
    public var name: String?
        
    public var folderName: String?
    
    public var mediaType: MediaType?
    
    public var isMarked: Bool = false
    
    public var categories: [MediaCategory] = []
            
    public var subItemCount: Int = 0
    
    public var imageUrl: String?
    
    public init() { }
    
    public var displayName: String {
        return name ?? folderName ?? "*"
    }
    
    public var isLabelled: Bool {
        let setMediaType = mediaType != nil && mediaType != MediaType.Unknown
        let setCategoryType = categories.count > 0

        return setMediaType && setCategoryType
    }
}

public struct CustomFormat: Codable {

    public var folderName: String?
    
    public var items: [String: CustomFormatItem] = [:]
        
    public var version: Int = 3
    
    public init() {}
    
    public func getLabelledIndicies() -> [String] {
        return items.filter { item in
            item.value.isLabelled
        }.map({$0.key})
    }

    public static func +(lhs: CustomFormat, rhs: CustomFormat) -> CustomFormat {
        var newItem = lhs
        rhs.items.forEach { (key, value) in newItem.items[key] = value }
        
        let lhsFolder = lhs.folderName ?? ""
        let rhsFolder = rhs.folderName ?? ""
        
        if !lhsFolder.isEmpty || !rhsFolder.isEmpty {
            newItem.folderName = "\(lhsFolder),\(rhsFolder)"
        }
        
        return newItem
    }
    
    public func sortedItems() -> [Dictionary<String, CustomFormatItem>.Element] {
        //Note: Use folder name instead of display name can change which would affect the index
        let items = items.sorted(by: {($0.value.folderName ?? "") < ($1.value.folderName ?? "")})
        return items
    }
    
    public func itemsSortedByValue(valueMap: [String: Double]) -> [CustomFormatItem] {
        return items.map({$0.value}).sorted(by: { item1, item2 in
            let points1 = valueMap[item1.folderName ?? item1.displayName] ?? 0.0
            let points2 = valueMap[item2.folderName ?? item2.displayName] ?? 0.0
            return points1 > points2
        })
    }
}

extension CustomFormat: CustomStringConvertible {
    public var description: String {
        
        let defaultValue = "{}"
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(self)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            return json ?? defaultValue
        }
        catch {
            print(error)
            return defaultValue
        }
    }
}

