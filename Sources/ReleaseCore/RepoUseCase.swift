//
//  ReposUseCase.swift
//
//
//  Created by zwc on 2024/9/17.
//

import Foundation
import GitHubRestAPIRepos
import OpenAPIURLSession
import Middleware
import Extensions

package struct ReposUseCase {

    /// The client used to interact with GitHub's REST API for issues.
    private let client: GitHubRestAPIRepos.Client

    /// The owner of the repository.
    let owner: String

    /// The repository name.
    let repo: String

    /// Initializes a new `CommentUseCase` instance.
    ///
    /// - Parameters:
    ///   - token: The GitHub API token to authenticate requests.
    ///   - owner: The owner of the repository.
    ///   - repo: The name of the repository.
    package init(token: String, owner: String, repo: String) throws {
        self.client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(token: token)]
        )
        self.owner = owner
        self.repo = repo
    }

    package func createRelease(type: BumpVersionType, gitRef: String) async throws {
        let tag = try await client.repos_sol_list_hyphen_releases(
            path: .init(owner: owner, repo: repo)
        ).ok.body.json.first?.tag_name ?? "0.0.0"

        var version = try Version(tag)
        version.bump(type: type)

        _ = try await client.repos_sol_create_hyphen_release(
            path: .init(owner: owner, repo: repo),
            body: .json(
                .init(
                    tag_name: version.string,
                    target_commitish: gitRef,
                    generate_release_notes: true
                )
            )
        ).created
    }
}
