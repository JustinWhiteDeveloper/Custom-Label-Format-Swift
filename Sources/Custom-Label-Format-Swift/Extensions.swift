//
//  File.swift
//  
//
//  Created by Justin White on 20/09/21.
//

import Foundation

extension String {
    var pathExtension: String {
        (self as NSString).pathExtension
    }
    
    var lastPathComponent: String {
        (self as NSString).lastPathComponent
    }
    
    var integerHash : Int {
        return self.utf8.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }
}

enum Constants {
    static let resourcesFolder: String = "/contents/Resources"
}
