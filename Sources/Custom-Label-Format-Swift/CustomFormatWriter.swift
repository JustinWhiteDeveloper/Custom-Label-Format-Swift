//
//  CustomFormatWriter.swift
//  
//
//  Created by Justin White on 5/09/21.
//

import Foundation


public protocol CustomFormatWriter {
    func writeFile(destination: String, value: CustomFormat)
}

public class FolderCustomFormatWriter: CustomFormatWriter {
    
    public init() {
        
    }
    
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
