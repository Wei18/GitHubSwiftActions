//
//  Int+Ext.swift
//  
//
//  Created by zwc on 2024/9/7.
//

import Foundation

extension Int {
    init(try string: String) throws {
        guard let int = Int(string) else { throw NSError(domain: "Required string of integer", code: 1)}
        self = int
    }
}
