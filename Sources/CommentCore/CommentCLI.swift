//
//  CommentCLI.swift
//
//
//  Created by zwc on 2024/9/6.
//

import Foundation
import ArgumentParser

/// A command-line interface for creating or updating a comment on a GitHub issue or pull request.
package struct CommentCLI: ParsableCommand {

    /// The GitHub repository owner.
    @Option(name: .shortAndLong, help: "The owner of the GitHub repository.")
    var owner: String = #"environment["OWNER"]"#

    /// The GitHub repository name.
    @Option(name: .shortAndLong, help: "The name of the GitHub repository.")
    var repo: String = #"environment["REPO"]"#

    /// The issue or pull request number.
    @Option(name: .shortAndLong, help: "The issue or pull request number.")
    var number: String = #"environment["NUMBER"]"#

    /// The unique anchor to identify the comment.
    @Option(name: .shortAndLong, help: "A unique anchor to identify the comment.")
    var anchor: String = #"environment["ANCHOR"]"#

    /// The body content of the comment.
    @Option(name: .shortAndLong, help: "The body content of the comment.")
    var body: String = #"environment["BODY"]"#

    /// The GitHub API token for authentication.
    @Option(name: .shortAndLong, help: "The GitHub API token to authenticate requests.")
    var token: String = #"environment["TOKEN"]"#

    package init() {}
    /// Runs the command, creating or updating the comment on the GitHub issue or pull request.
    package func run() throws {
        Task.synchronous {
            do {
                let owner = ProcessInfo.processInfo.environment["OWNER"] ?? owner
                let repo = ProcessInfo.processInfo.environment["REPO"] ?? repo
                let number = try Int(try: ProcessInfo.processInfo.environment["NUMBER"] ?? number)
                let anchor = ProcessInfo.processInfo.environment["ANCHOR"] ?? anchor
                let body = ProcessInfo.processInfo.environment["BODY"] ?? body
                let token = ProcessInfo.processInfo.environment["TOKEN"] ?? token
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
