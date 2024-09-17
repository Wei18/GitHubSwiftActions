//
//  SetUpActionBuilder.swift
//
//
//  Created by zwc on 2024/9/17.
//

import Foundation
import Yams

struct SetUpActionBuilder {
    func build() throws -> String {
        let content = "\(SwiftPackageConfig.current.repo)@${{ github.action_ref }}"
        let action: [String: Any] = [
            "name": "SetUp",
            "runs": [
                "using": "composite",
                "steps": [
                    [
                        "name": "Setup Swift",
                        "uses": "swift-actions/setup-swift@v2",
                        "with": [
                            "swift-version": "5.10.0",
                        ],
                    ],
                    [
                        "name": "Create Mintfile",
                        "run": "echo \(content) > ${{ github.action_path }}/Mintfile",
                        "shell": "bash",
                    ],
                    [
                        "name": "Setup Mint",
                        "uses": "irgaly/setup-mint@v1",
                        "with": [
                            "mint-directory": "${{ github.action_path }}",
                            "mint-executable-directory": "~/.mint/bin",
                            "cache-prefix": "GitHubSwiftActions",
                        ],

                    ],
                ],
            ],
        ]
        return try Yams.dump(object: action, width: -1, sortKeys: true)
    }
}
