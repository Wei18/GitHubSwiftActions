//
//  Int+Ext.swift
//  
//
//  Created by zwc on 2024/9/7.
//

import Foundation

package extension Int {
    init(string: String, line: Int = #line) throws {
        guard let int = Int(string) else {
            throw NSError(domain: "Required string of integer", code: line)
        }
        self = int
    }
}
