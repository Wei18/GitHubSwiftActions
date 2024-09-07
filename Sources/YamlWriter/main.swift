//
//  main.swift
//  
//
//  Created by zwc on 2024/9/6.
//

import ArgumentParser
import CommentCore

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

        // FIXME: basePath
        let actionPath = try FileBuilder(
            content: yaml,
            command: command,
            basePath: "/Users/zw/Documents/GitHub/GitHubSwiftActions"
        ).build()

        try FileBuilder(
            content: "Wei18/GitHubSwiftActions@main",
            command: command,
            basePath: "/Users/zw/Documents/GitHub/GitHubSwiftActions",
            file: "Mintfile"
        ).build()

        print(actionPath)
    }
}

YamlWriterCLI.main()
