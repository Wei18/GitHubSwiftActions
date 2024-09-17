//
//  SwiftPackageConfig.swift
//
//
//  Created by zwc on 2024/9/17.
//

import Foundation

struct SwiftPackageConfig {
    static let current = SwiftPackageConfig()

    let version = "main"

    let repo = "Wei18/GitHubSwiftActions"

    var packageForMint: String { "\(repo)@\(version)" }

    private init() {}
}
