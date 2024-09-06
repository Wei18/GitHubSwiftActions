# Work In Progress (Beta)

# GitHub Swift Actions

## Overview

This repository contains a GitHub Composite Action built using Swift. The primary action provided here is `CommentCLI`, which allows you to comment on GitHub issues from a CLI tool written in Swift.

## Action: CommentCLI

### Description

The `CommentCLI` action comments on GitHub issues using a Swift CLI tool. You can use it to automatically post comments when issues are opened or reopened.

### Inputs

The `CommentCLI` action requires the following inputs:

- **`number`**: (required) The issue number to comment on.
- **`body`**: (required) The body of the comment.
- **`owner`**: (required) The owner of the repository.
- **`repo`**: (required) The name of the repository.
- **`token`**: (required) GitHub token with permissions to comment.
- **`anchor`**: (required) Anchor text for the comment.

### Example Usage

To use the `CommentCLI` action in a GitHub Actions workflow, create a YAML file in the `.github/workflows` directory of your repository:

```yaml
name: Welcome

on:
  issues:
    types: [opened, reopened]

jobs:
  say-hello-to-reporter:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v4

    - name: Comment on issue
      uses: Wei18/GitHubSwiftActions/Actions/CommentCLI@main
      with:
        number: ${{ github.event.issue.number }}
        body: |
          Hello @${{ github.event.issue.user.login }},

          Thank you for opening this issue! We will review it and get back to you as soon as possible.

          If you have any additional details or questions, please feel free to update this issue.

          Best regards,
          The Team
        owner: ${{ github.repository_owner }}
        repo: ${{ github.repository }}
        token: ${{ secrets.GITHUB_TOKEN }}
        anchor: "welcome-comment"
```

## Action Structure

- **`action.yml`**: The action definition file.
- **`Sources/`**: Contains the Swift source code for the CLI tool.
- **`.github/workflows/`**: Contains GitHub Actions workflow files for testing and deployment.

## Building the Action

To build the `CommentCLI` action locally, use:

```sh
swift build --configuration release
```

## Contributing

Feel free to open issues or submit pull requests if you have improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
