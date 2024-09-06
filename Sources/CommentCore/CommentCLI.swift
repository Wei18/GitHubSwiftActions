//
//  CommentCLI.swift
//
//
//  Created by zwc on 2024/9/6.
//

import ArgumentParser

/// A command-line interface for creating or updating a comment on a GitHub issue or pull request.
package struct CommentCLI: ParsableCommand {

    /// The GitHub repository owner.
    @Option(name: .shortAndLong, help: "The owner of the GitHub repository.")
    var owner: String

    /// The GitHub repository name.
    @Option(name: .shortAndLong, help: "The name of the GitHub repository.")
    var repo: String

    /// The issue or pull request number.
    @Option(name: .shortAndLong, help: "The issue or pull request number.")
    var number: Int

    /// The unique anchor to identify the comment.
    @Option(name: .shortAndLong, help: "A unique anchor to identify the comment.")
    var anchor: String

    /// The body content of the comment.
    @Option(name: .shortAndLong, help: "The body content of the comment.")
    var body: String

    /// The GitHub API token for authentication.
    @Option(name: .shortAndLong, help: "The GitHub API token to authenticate requests.")
    var token: String

    package init() {}
    /// Runs the command, creating or updating the comment on the GitHub issue or pull request.
    package func run() throws {
        Task {
            do {
                let comment = try Comment(
                    token: token,
                    owner: owner,
                    repo: repo,
                    number: number,
                    anchor: anchor,
                    body: body
                )
                try await comment.run()
                print("Comment successfully created/updated!")
            } catch {
                print("Failed to create/update comment: \(error)")
            }
        }
    }
}
