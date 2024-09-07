# GitHub Swift Actions (Beta)

## Overview

This repository contains GitHub Composite Actions built using Swift. 

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
https://github.com/Wei18/GitHubSwiftActions/blob/fb343bbc4a35efa451043286dd4d0784658fe8d2/.github/workflows/Welcome.yml#L1-L28

## Building the Action

To run the `Comment` action locally, use:

```sh
swift run --configuration release Comment
```

## Contributing

Feel free to open issues or submit pull requests if you have improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
