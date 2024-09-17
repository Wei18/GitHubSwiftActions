//
//  Version.swift
//
//
//  Created by zwc on 2024/9/17.
//

import Foundation

package enum BumpVersionType: String {
    case major
    case minor
    case patch
}

struct Version {
    private(set) var major: Int
    private(set) var minor: Int
    private(set) var patch: Int

    var string: String { "\(major).\(minor).\(patch)" }

    init(_ string: String) throws {
        let components = string.components(separatedBy: ".")
        guard components.count == 3 else {
            throw NSError(domain: "Required count == 3", code: #line)
        }
        major = try Int(string: components[0])
        minor = try Int(string: components[1])
        patch = try Int(string: components[2])
    }

    mutating func bump(type: BumpVersionType) {
        switch type {
        case .patch:
            patch += 1
        case .minor:
            minor += 1
        case .major:
            major += 1
        }
    }
}
