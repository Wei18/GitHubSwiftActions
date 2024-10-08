[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FWei18%2FGitHubSwiftActions%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Wei18/GitHubSwiftActions)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FWei18%2FGitHubSwiftActions%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Wei18/GitHubSwiftActions)

# GitHub Swift Actions (Beta)

## Overview

This repository contains GitHub Composite Actions built using Swift. 

## Ideas  
This is a series of combinations:  
- To create convenient use cases, a Swift package executable was created,  
  - utilizing the OAS dependency: [github-rest-api-swift-openapi](https://github.com/Wei18/github-rest-api-swift-openapi)  
- To create GitHub Composite Actions,  
  - the Yams dependency is used: [Yams](https://github.com/jpsim/Yams)  
- Then, GitHub Actions are utilized  
  - to build the Swift package executable via Mint: [Mint](https://github.com/yonaskolb/Mint)  
  - and to cache the Swift package executable via: [setup-mint](https://github.com/irgaly/setup-mint)

## Action: Release

### Description

The `Release` action creates on GitHub release using a Swift CLI tool. You can use it to bump major, minor, patch.

## Action: Comment

### Description

The `Comment` action comments on GitHub issues using a Swift CLI tool. You can use it to automatically craete or update comments.

### Inputs

The `Comment` action requires the following inputs:

- **`number`**: (required) The issue number to comment on.
- **`body`**: (required) The body of the comment.
- **`owner`**: (required) The owner of the repository.
- **`repo`**: (required) The name of the repository.
- **`token`**: (required) GitHub token with permissions to comment.
- **`anchor`**: (required) Anchor text for the comment.

### Example Usage

To use the `Comment` action in a GitHub Actions workflow, create a YAML file in the `.github/workflows` directory of your repository:
https://github.com/Wei18/GitHubSwiftActions/blob/5e993bca0d3f050c590790954440a5953c81aeee/.github/workflows/Welcome.yml#L1-L24

## Building the Action

To run the `Comment` action locally, use:

```sh
swift run --configuration release Comment
```

## Contributing

Feel free to open issues or submit pull requests if you have improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
