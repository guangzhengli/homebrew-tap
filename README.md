# homebrew-tap

这是 `guangzhengli` 的 Homebrew Tap，用于分发 macOS 应用包（Cask），也可以按需分发命令行工具（Formula）。

远程仓库：

- SSH: `git@github.com:guangzhengli/homebrew-tap.git`
- HTTPS: `https://github.com/guangzhengli/homebrew-tap`

本仓库的 Homebrew tap 结构参考了 [`steipete/homebrew-tap`](https://github.com/steipete/homebrew-tap)。当前仓库只保留通用的 tap 组织方式和发布流程说明，没有保留参考仓库中的应用、包名、作者配置或项目专有内容。

## 用户如何安装

```bash
brew tap guangzhengli/tap
brew install --cask guangzhengli/tap/<cask-name>
```

如果以后添加了 CLI 工具，可以用 Formula 安装：

```bash
brew install guangzhengli/tap/<formula-name>
```

更新和卸载：

```bash
brew update
brew upgrade --cask <cask-name>
brew uninstall --cask <cask-name>
```

## 如何发布一个 macOS 应用

1. 在你的应用仓库创建 GitHub Release，例如 `v1.0.0`。
2. 上传 `.zip` 或 `.dmg` 作为 release asset。推荐 `.zip` 里直接包含 `Your App.app`。
3. 计算下载包的 SHA256：

```bash
curl -fL "https://github.com/guangzhengli/<app-repo>/releases/download/v1.0.0/<asset>.zip" -o /tmp/<asset>.zip
shasum -a 256 /tmp/<asset>.zip
```

4. 在 `Casks/` 下创建 cask 文件，例如 `Casks/your-app.rb`：

```ruby
cask "your-app" do
  version "1.0.0"
  sha256 "<sha256>"

  url "https://github.com/guangzhengli/<app-repo>/releases/download/v#{version}/YourApp-#{version}.zip",
      verified: "github.com/guangzhengli/<app-repo>/"
  name "Your App"
  desc "Short description of your app"
  homepage "https://github.com/guangzhengli/<app-repo>"

  depends_on macos: ">= :ventura"

  app "Your App.app"

  zap trash: [
    "~/Library/Application Support/Your App",
    "~/Library/Caches/com.example.your-app",
    "~/Library/Preferences/com.example.your-app.plist",
  ]
end
```

5. 本地验证：

```bash
brew tap guangzhengli/tap .
brew audit --cask --new guangzhengli/tap/your-app
brew install --cask --verbose guangzhengli/tap/your-app
brew uninstall --cask your-app
```

6. 提交并推送：

```bash
git add README.md .gitignore Casks Formula .github
git commit -m "Set up Homebrew tap"
git branch -M main
git remote add origin git@github.com:guangzhengli/homebrew-tap.git
git push -u origin main
```

如果本地已经有 `origin`，改用：

```bash
git remote set-url origin git@github.com:guangzhengli/homebrew-tap.git
```

## 如何更新已有 Cask

手动更新时，改 `Casks/<cask-name>.rb` 里的 `version`、`sha256` 和 `url`，然后重新运行 audit/install 验证。

也可以在 GitHub Actions 里手动运行 `Update Cask` workflow，填写：

- `cask`: cask 文件名，不带 `.rb`，例如 `your-app`
- `tag`: release tag，例如 `v1.0.1`
- `repository`: 应用源码仓库，例如 `guangzhengli/your-app`
- `asset_name`: release asset 文件名；留空时默认使用 `<cask>-<version>.zip`

workflow 会下载 release asset、计算 SHA256、更新 `Casks/<cask>.rb` 并提交回本仓库。
