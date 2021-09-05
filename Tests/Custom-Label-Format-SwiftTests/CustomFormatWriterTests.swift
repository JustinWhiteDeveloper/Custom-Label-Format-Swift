//
//  CustomFormatWriterTests.swift
//  
//
//  Created by Justin White on 5/09/21.
//

import XCTest
@testable import Custom_Label_Format_Swift

public protocol CustomFormatWriter {
    func writeFile(destination: String, value: CustomFormat)
}

public class FolderCustomFormatWriter: CustomFormatWriter {
    public func writeFile(destination: String, value: CustomFormat) {
    
    }
}

class CustomFormatWriterTests: XCTestCase {

}
