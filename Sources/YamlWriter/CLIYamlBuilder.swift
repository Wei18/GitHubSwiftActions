//
//  CLIYamlBuilder.swift
//
//
//  Created by zwc on 2024/9/6.
//

import Foundation
import Yams
import ArgumentParser

/// A generic builder class for generating a GitHub Composite Action YAML file for any ParsableCommand.
struct CLIYamlBuilder {

    /// Generates the YAML content for the GitHub Composite Action based on a ParsableCommand.
    ///
    /// - Parameters:
    ///   - command: The ParsableCommand type to inspect.
    ///   - description: A short description of the action.
    /// - Returns: A string containing the generated YAML.
    func build<T: ParsableCommand>(command: T.Type, description: String) throws -> String {
        // Reflect on the command's properties
        let mirror = Mirror(reflecting: command.init())

        // Extract the properties and types to create input descriptions for the YAML
        var inputs: [String: Any] = [:]
        for child in mirror.children {
            guard let label = child.label?.replacingOccurrences(of: "_", with: "") else { continue }
            inputs[label] = [
                "description": "The \(label) for the command.",
                "required": true
            ]
        }

        let envDict = inputs.keys.reduce(into: [:]) { partialResult, value in
            partialResult[value.uppercased()] = "${{ inputs.\(value) }}"
        }

        let name = String(describing: command)

        // Define the structure of the composite action
        let action: [String: Any] = [
            "name": name,
            "description": description,
            "inputs": inputs,
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
                        "uses": "actions/cache@v4",
                        "with": [
                            "path": "../../.build",
                            "key": "${{ runner.os }}-spm-${{ hashFiles('/Package.resolved') }}",
                            "restore-keys": "${{ runner.os }}-spm-",
                        ]
                    ],
                    [
                        "name": "Run \(name)",
                        // FIXME: owner/repo
                        "run": "mint run Wei18/GitHubSwiftActions@main \(name)",
                        "env": envDict,
                        "shell": "bash",
                    ],
                ],
            ],
        ]

        // Convert the dictionary to a YAML string using Yams
        return try Yams.dump(object: action, width: -1, sortKeys: true)
    }
}


