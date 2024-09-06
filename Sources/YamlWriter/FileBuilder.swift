//
//  FileBuilder.swift
//
//
//  Created by zwc on 2024/9/7.
//

import Foundation

struct FileBuilder {
    let content: String
    let commandName: String
    let basePath: String?

    /// Initializes the `FileBuilder` with the content to be written and the command name.
    ///
    /// - Parameters:
    ///   - content: The content (YAML) to be written to the file.
    ///   - commandName: The name of the command, which will be used to create the subdirectory under `Actions/`.
    ///   - basePath: Optional path to the base directory, such as the repo's root. If `nil`, defaults to current directory.
    init(content: String, commandName: String, basePath: String? = nil) {
        self.content = content
        self.commandName = commandName
        self.basePath = basePath
    }

    /// Creates the directory structure and writes the content to the file.
    ///
    /// - Returns: The path to the generated file.
    func build() throws -> String {
        // Use the base path if provided, otherwise use the current directory
        let rootPath = basePath ?? FileManager.default.currentDirectoryPath

        // Define the path to the Actions directory
        let actionsPath = "\(rootPath)/Actions/\(commandName)"

        // Create the directory structure if it doesn't exist
        try FileManager.default.createDirectory(atPath: actionsPath, withIntermediateDirectories: true)

        // Define the file path to action.yml
        let filePath = "\(actionsPath)/action.yml"

        // Write the YAML content to the file
        try content.write(toFile: filePath, atomically: true, encoding: .utf8)

        // Return the file path
        return filePath
    }
}