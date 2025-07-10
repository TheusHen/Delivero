# Delivero Universal CI/CD

Delivero is a universal, repository-agnostic CI/CD workflow built for GitHub Actions. It allows you to define your project’s build, test, artifact, and notification steps in a simple `delivero.yaml` file. Delivero handles cloning your project, running builds/tests, uploading artifacts to MinIO-compatible storage, and sending notifications (e.g., WhatsApp via CallMeBot) — all triggered automatically every 15 minutes or on-demand.

## Features

- **Repo-Agnostic:** Works with any repo by specifying it in `delivero.yaml`
- **Scheduled CI/CD:** Checks for new commits every 15 minutes; only builds when there are updates
- **Pluggable Build/Test Steps:** Define shell commands for building and testing
- **Artifact Upload:** Store build artifacts in MinIO S3-compatible storage
- **Pre-Signed Links:** Get downloadable links to your artifacts
- **Notifications:** Receive WhatsApp alerts when builds complete
- **Simple YAML Configuration:** One file to rule them all

## Getting Started

### 1. Fork or Clone This Repository

This repository houses the workflow and the example configuration.

### 2. Copy `delivero.example.yaml` to Your Project

Rename it to `delivero.yaml` and customize the fields for your project (see below).

### 3. Setup GitHub Secrets

Add these secrets to your repository (or organization) settings:

- `MINIO_ENDPOINT`
- `MINIO_ACCESS_KEY`
- `MINIO_SECRET_KEY`
- `MINIO_BUCKET`
- `CALLMEBOT_APIKEY` (for WhatsApp notifications)

### 4. Example `delivero.yaml`

````yaml
name: Example Project

repo: https://github.com/your-user/your-repo.git
repo_dir: app

build:
  - echo "Starting build"
  - make build

test:
  - echo "Running tests"
  - make test

artifacts:
  - path: dist/app.apk
    name: app.apk
  - path: reports/coverage.html
    name: coverage.html

storage:
  provider: minio
  bucket: my-artifacts

notify:
  channels:
    - type: whatsapp
      phone: "+15555555555"
      provider: callmebot
````

### 5. Workflow File

The workflow (`.github/workflows/delivero.yml`) is already set up to:

- Clone the repo defined in your `delivero.yaml`
- Run build and test steps
- Upload artifacts to MinIO
- Generate pre-signed download links
- Notify via WhatsApp

You can run the workflow manually or let it run every 15 minutes.

## How It Works

1. Every 15 minutes, the workflow checks for new commits in your target repo.
2. If commits are found, it:
   - Clones the target repo and enters the specified directory.
   - Executes build and test commands.
   - Uploads artifacts to your MinIO bucket.
   - Generates pre-signed download links for the artifacts.
   - Sends a WhatsApp notification with the links.

## Customization

- **Add/Remove build or test steps:** Edit the `build` and `test` arrays in `delivero.yaml`.
- **Artifacts:** List any files you want to upload in the `artifacts` array.
- **Notifications:** Add new channels as needed (e.g., Slack, Discord).

## Troubleshooting

- Make sure all required secrets are set in your repository.
- Ensure MinIO is accessible and the credentials are correct.
- WhatsApp notifications require a valid CallMeBot API key and a registered phone number.

## License

### [MIT](LICENSE)

---

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on contributing to this project.