//
//  FolderContainer.swift
//  Morph
//
//  Created by Justin White on 21/08/21.
//

import Foundation

struct File {
    let name: String
    
    var subtitles: [String] = []
    
    var success: Bool = false
}

struct Folder {
    let name: String
    
    var fileCount: Int = 0
    
    var success: Bool = false
    
    var subFolders: [Folder] = []
}

protocol FolderContainer {
    func read(folder: String) -> Folder
    
    func read(bundle: Bundle) -> Folder
}

class LocalFolderContainer: FolderContainer {
    
    func read(bundle: Bundle) -> Folder {
        return read(folder: bundle.bundlePath + Constants.resourcesFolder)
    }
    
    func read(folder: String) -> Folder {
        var result = Folder(name: folder.lastPathComponent)

        do {
            let paths = try FileManager.default.contentsOfDirectory(atPath: folder)
            
            result.fileCount = paths.filter({$0.pathExtension.isEmpty == false}).count
            
            for path in paths where path.pathExtension.isEmpty && !path.starts(with: ".") {
                let innerResult = self.read(folder: folder + "/" + path)
                result.subFolders.append(innerResult)
            }
            
            result.success = true
            return result

        }
        catch {
            print (error)
        }
        
        return result
    }
}

