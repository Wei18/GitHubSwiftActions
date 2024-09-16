//
//  main.swift
//  
//
//  Created by zwc on 2024/9/6.
//

import Foundation
import ArgumentParser
import CommentCLI

/// A command-line interface for building a GitHub Composite Action YAML based on a ParsableCommand.
struct YamlWriterCLI: ParsableCommand {

    /// Generates the GitHub Composite Action YAML.
    func run() throws {
        try makeCommentCLIYaml()
    }

    private func makeCommentCLIYaml() throws {
        let command = Comment.self
        let yaml = try CLIYamlBuilder().build(
            command: command,
            description: "Runs the process of adding or updating a comment in a GitHub issue or pull request.")

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
