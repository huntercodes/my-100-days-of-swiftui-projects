//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by hunter downey on 12/27/21.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
