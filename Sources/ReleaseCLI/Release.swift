//
//  Release.swift
//
//
//  Created by zwc on 2024/9/17.
//

import Foundation
import ArgumentParser
import ReleaseCore
import Extensions

/// A command-line interface for creating or updating a comment on a GitHub issue or pull request.
package struct Release: ParsableCommand {

    /// The GitHub repository owner.
    @Option(name: .shortAndLong, help: "The owner of the GitHub repository.")
    var owner: String = #"environment["OWNER"]"#

    /// The GitHub repository name.
    @Option(name: .shortAndLong, help: "The name of the GitHub repository.")
    var repo: String = #"environment["REPO"]"#

    @Option(name: .shortAndLong, help: "The value of major | minor | patch (default)")
    var bumpType: String = #"environment["BUMP_TYPE"]"#

    @Option(name: .shortAndLong, help: "Specifies the commitish value that determines where the Git tag is created from. Can be any branch or commit SHA. Unused if the Git tag already exists. Default: the repository's default branch.")
    var gitRef: String = #"environment["GIT_REF"]"#

    /// The GitHub API token for authentication.
    @Option(name: .shortAndLong, help: "The GitHub API token to authenticate requests.")
    var token: String = #"environment["TOKEN"]"#

    package init() {}
    /// Runs the command, creating or updating the comment on the GitHub issue or pull request.
    package func run() throws {
        Task.synchronous {
            do {
                let owner = ProcessInfo.processInfo.environment["OWNER"] ?? owner
                print("inputs.owner: \(owner)")

                let repo = ProcessInfo.processInfo.environment["REPO"] ?? repo
                print("inputs.repo: \(repo)")

                let bumpType = BumpVersionType(rawValue: ProcessInfo.processInfo.environment["BUMP_TYPE"] ?? bumpType) ?? .patch
                print("inputs.bumpType: \(bumpType)")

                let gitRef = ProcessInfo.processInfo.environment["GIT_REF"] ?? gitRef
                print("inputs.gitRef: \(gitRef)")

                let token = ProcessInfo.processInfo.environment["TOKEN"] ?? token
                print("inputs.token: \(token)")

                let useCase = try ReposUseCase(
                    token: token,
                    owner: owner,
                    repo: repo
                )
                try await useCase.createRelease(
                    type: bumpType,
                    gitRef: gitRef)
                print("Release successfully created!")
            } catch {
                Self.exit(withError: error)
            }
        }
    }
}
