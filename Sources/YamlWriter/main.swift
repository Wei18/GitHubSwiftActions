//
//  main.swift
//  
//
//  Created by zwc on 2024/9/6.
//

import Foundation
import ArgumentParser
import CommentCLI
import ReleaseCLI

/// A command-line interface for building a GitHub Composite Action YAML based on a ParsableCommand.
struct YamlWriterCLI: ParsableCommand {

    /// Generates the GitHub Composite Action YAML.
    func run() throws {
        try makeCLIYaml(
            command: Comment.self,
            description: "Runs the process of adding or updating a comment in a GitHub issue or pull request.")

        try makeCLIYaml(
            command: Release.self,
            description: "Runs the process of creating GitHub Release with bump type and git ref")
    }

    private func makeCLIYaml(command: ParsableCommand.Type, description: String) throws {
        let yaml = try CLIYamlBuilder().build(
            command: command,
            description: description)
        
        let actionPath = try FileBuilder(
            content: yaml,
            command: command,
            basePath: packDirectory().appendingPathComponent("Actions")
        ).build()
        print(actionPath)
    }

    private func packDirectory(
        for file: StaticString = #file,
        anchorRepoPathComponent: String = "Sources"
    ) -> URL {
        let packDirectory: URL = {
            var newValue = URL(fileURLWithPath: file.description, isDirectory: false)
            while newValue.lastPathComponent != anchorRepoPathComponent {
                newValue = newValue.deletingLastPathComponent()
            }
            return newValue.deletingLastPathComponent()
        }()
        return packDirectory
    }
}

YamlWriterCLI.main()
