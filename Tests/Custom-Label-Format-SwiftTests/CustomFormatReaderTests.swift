//
//  CustomFormatReaderTests.swift
//
//  Created by Justin White on 5/09/21.
//

import XCTest
@testable import Custom_Label_Format_Swift

public protocol CustomFormatReader {
    func readFile(source: String) -> CustomFormat
}

public class FolderCustomFormatReader: CustomFormatReader {
    public func readFile(source: String) -> CustomFormat {
        return CustomFormat()
    }
}

class CustomFormatReaderTests: XCTestCase {

}
