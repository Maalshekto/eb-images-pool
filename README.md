# EB Images Pool

This project automates the process of creating, building, deploying, and destroying Docker images using GitHub Actions and AWS services. The repository manages multiple Docker images, each linked to a specific subdirectory.

## Features

1. **AWS ECR Repository Creation**: Automatically creates AWS ECR repositories for each subdirectory.
2. **Docker Image Build & Push**: Builds Docker images and pushes them to their respective ECR repositories.
3. **Resource Cleanup**: Cleans up AWS resources (ECR repositories, IAM roles) when no longer needed.

## Project Structure

Each subdirectory contains:
- A `Dockerfile`
- Additional configuration files required to build the image.

Example structure:

    ├── container-apps/
    │   ├── image-1/
    │   │   ├── Dockerfile
    │   │   └── ...
    │   ├── image-2/
    │   │   ├── Dockerfile
    │   │   └── ...
    ├── .github/
    │   └── workflows/
    │       ├── build-image.yml
    │       ├── deploy-gh.yml
    │       └── destroy.yml
    └── main.tf

 ``## Prerequisites

1. **AWS Account**: Configure AWS credentials for ECR and IAM.
2. **GitHub Secrets**:
 - `AWS_ACCESS_KEY_ID`
 - `AWS_SECRET_ACCESS_KEY`
 - `AWS_REGION`

## Usage

1. **Create ECR Repositories**: GitHub Actions create an ECR repository for each subdirectory.
2. **Build and Push Images**: Docker images are built and pushed to their ECR repositories.
3. **Deploy Infrastructure**: Terraform manages the creation of ECR repositories and IAM roles.
4. **Clean Up**: The final GitHub Action deletes the AWS resources created.

## GitHub Actions

1. **Build and Push**: Builds Docker images and pushes them to AWS ECR.
2. **Deploy Infrastructure**: Initializes Terraform, generates deployment plans, and applies them.
3. **Destroy Infrastructure**: Cleans up AWS ECR repositories and IAM roles based on the Terraform state.

## Getting Started

1. Fork this repository.
2. Configure AWS credentials in the repository’s secrets.
3. Add Dockerfiles in subdirectories.
4. Trigger the GitHub Actions.

## Terraform Configuration

The `main.tf` file is configured to:
- Set up AWS provider.
- Use S3 for storing Terraform state.
- Create ECR repositories and IAM roles as defined by the local directory structure.

## License

This project is licensed under the MIT License.
