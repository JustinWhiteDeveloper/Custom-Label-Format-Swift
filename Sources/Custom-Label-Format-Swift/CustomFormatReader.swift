//
//  CustomFormatReader.swift
//  
//
//  Created by Justin White on 5/09/21.
//

import Foundation

public protocol CustomFormatReader {
    func readFile(source: String) -> CustomFormat
    
    func readFolder(source: String) -> CustomFormat
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
    
    public func readFolder(source: String) -> CustomFormat {
        var value = CustomFormat()
        value.folderName = source.lastPathComponent

        let container = LocalFolderContainer()
        let folderResult = container.read(folder: source)

        for folder in folderResult.subFolders {

            let identifier = "\(folder.name.integerHash)"

            var item = CustomFormatItem()
            item.folderName = folder.name
            item.identifier = identifier
            item.subItemCount = folder.fileCount
            
            value.items[identifier] = item
        }
        
        return value
    }
}
