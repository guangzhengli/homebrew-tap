# homebrew-tap

English | [中文](README.zh-CN.md)

This repository is a Homebrew tap for publishing macOS app packages with Cask files. It can also host Formula files later if command-line tools need to be distributed through Homebrew.

Repository:

- SSH: `git@github.com:guangzhengli/homebrew-tap.git`
- HTTPS: `https://github.com/guangzhengli/homebrew-tap`

Reference: this tap layout and workflow use [`steipete/homebrew-tap`](https://github.com/steipete/homebrew-tap) as a reference example.

## How I Use This Tap

Use this repository as the Homebrew distribution layer for apps that already have GitHub Releases.

The normal workflow is:

1. Build and notarize the macOS app in the app repository.
2. Create a GitHub Release, for example `v1.0.0`.
3. Upload the app archive as a release asset, usually a `.zip` that contains `Your App.app`.
4. Add or update the matching cask file in this tap.
5. Test the cask locally with Homebrew.
6. Commit and push this tap repository.

## Add A New macOS App

Create a file under `Casks/`, for example `Casks/your-app.rb`.

```ruby
cask "your-app" do
  version "1.0.0"
  sha256 "<sha256>"

  url "https://github.com/<github-owner>/<app-repo>/releases/download/v#{version}/YourApp-#{version}.zip",
      verified: "github.com/<github-owner>/<app-repo>/"
  name "Your App"
  desc "Short description of the app"
  homepage "https://github.com/<github-owner>/<app-repo>"

  depends_on macos: ">= :ventura"

  app "Your App.app"

  zap trash: [
    "~/Library/Application Support/Your App",
    "~/Library/Caches/com.example.your-app",
    "~/Library/Preferences/com.example.your-app.plist",
  ]
end
```

Calculate the SHA256 for the release asset:

```bash
curl -fL "https://github.com/<github-owner>/<app-repo>/releases/download/v1.0.0/<asset>.zip" -o /tmp/<asset>.zip
shasum -a 256 /tmp/<asset>.zip
```

Use that hash as the `sha256` value in the cask.

## Test Locally

From this repository:

```bash
brew tap guangzhengli/tap .
brew audit --cask --new guangzhengli/tap/your-app
brew install --cask --verbose guangzhengli/tap/your-app
brew uninstall --cask your-app
```

If the tap already exists locally and points somewhere else:

```bash
brew untap guangzhengli/tap
brew tap guangzhengli/tap .
```

## Publish This Tap

For the initial repository setup:

```bash
git init
git add README.md README.zh-CN.md .gitignore Casks Formula .github
git commit -m "Set up Homebrew tap"
git branch -M main
git remote add origin git@github.com:guangzhengli/homebrew-tap.git
git push -u origin main
```

If `origin` already exists:

```bash
git remote set-url origin git@github.com:guangzhengli/homebrew-tap.git
git push -u origin main
```

After the repository is pushed, install from the remote tap with:

```bash
brew tap guangzhengli/tap
brew install --cask guangzhengli/tap/your-app
```

## Update An Existing Cask

Manual update:

1. Publish a new app release, for example `v1.0.1`.
2. Download the new release asset and calculate SHA256.
3. Update `version`, `sha256`, and `url` in `Casks/<cask>.rb`.
4. Run the local audit and install test again.
5. Commit and push the tap update.

GitHub Actions update:

1. Open the `Update Cask` workflow.
2. Run it manually with the cask name, release tag, source repository, and optional asset name.
3. Review the generated commit.

The workflow downloads the release asset, calculates SHA256, updates `Casks/<cask>.rb`, and commits the change back to this repository.
