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

        // Define the structure of the composite action
        let name = String(describing: command).replacingOccurrences(of: "CLI", with: "")
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
                        "run": self.generateRunCommand(name),
                        "env": envDict,
                        "shell": "bash",
                    ]
                ]
            ]
        ]

        // Convert the dictionary to a YAML string using Yams
        return try Yams.dump(object: action, width: -1, sortKeys: true)
    }

    /// Generates a command string to navigate to the repository root, build a Swift project, and run a specified Swift executable.
    ///
    /// - Parameter name: The name of the Swift executable to run. This is typically the name of the target or the executable product defined in your Swift package.
    ///
    /// - Returns: A string representing the complete shell command to navigate to the repository root, build the Swift project in release configuration, and run the specified executable.
    ///
    /// The generated command includes:
    /// 1. Changing the directory to the root of the repository (relative to the GitHub Action path).
    /// 2. Building the Swift project using the `swift build` command with the `release` configuration.
    /// 3. Running the specified Swift executable using the `swift run` command.
    ///
    /// Example:
    /// ```
    /// let command = generateRunCommand("CommentCLI")
    /// print(command)
    /// // Output: cd "${{ github.action_path }}/../.."; swift build --configuration release; swift run CommentCLI
    /// ```
    private func generateRunCommand(_ name: String) -> String {
        let cd = #"cd "${{ github.action_path }}/../..";"#
        let run = #"swift run --configuration release --quiet \#(name);"#
        return #"\#(cd) \#(run)"#
    }

}


