//
//  FileManager-DocumentsDirectory.swift
//  HotProspects
//
//  Created by hunter downey on 1/8/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
