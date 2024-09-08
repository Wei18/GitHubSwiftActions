//
//  FileBuilder.swift
//
//
//  Created by zwc on 2024/9/7.
//

import Foundation
import ArgumentParser

struct FileBuilder {
    let content: String
    let commandName: String
    let basePath: URL
    let file: String

    /// Initializes the `FileBuilder` with the content to be written and the command name.
    ///
    /// - Parameters:
    ///   - content: The content (YAML) to be written to the file.
    ///   - command: The ParsableCommand type to inspect.
    ///   - basePath: The path to the base directory.
    ///   - file: Define the file path. (default: action.yml)
    init<T: ParsableCommand>(content: String, command: T.Type, basePath: URL, file: String = "action.yml") {
        self.content = content
        self.commandName = String(describing: command)
        self.basePath = basePath
        self.file = file
    }

    /// Creates the directory structure and writes the content to the file.
    ///
    /// - Returns: The path to the generated file.
    @discardableResult
    func build() throws -> String {
        // Define the path to the action directory
        let actionsPath = basePath
            .appendingPathComponent(commandName)
            .path

        // Create the directory structure if it doesn't exist
        try FileManager.default.createDirectory(atPath: actionsPath, withIntermediateDirectories: true)

        // Define the file path to action.yml
        let filePath = "\(actionsPath)/\(file)"

        // Write the YAML content to the file
        try content.write(toFile: filePath, atomically: true, encoding: .utf8)

        // Return the file path
        return filePath
    }
}
