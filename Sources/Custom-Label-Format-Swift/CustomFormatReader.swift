//
//  CustomFormatReader.swift
//  
//
//  Created by Justin White on 5/09/21.
//

import Foundation

public protocol CustomFormatReader {
    func readFile(source: String) -> CustomFormat
}

public class FolderCustomFormatReader: CustomFormatReader {
    
    public init() {}
    
    public func readFile(source: String) -> CustomFormat {
        
        let defaultValue = CustomFormat()
        
        do {
            guard let data = FileManager.default.contents(atPath: source) else {
                return defaultValue
            }
            
            let format = try JSONDecoder().decode(CustomFormat.self, from: data)
            return format
        }
        catch {
            print(error)
            return defaultValue
        }
    }
}
