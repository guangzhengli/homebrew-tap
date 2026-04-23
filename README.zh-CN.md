# homebrew-tap

[English](README.md) | 中文

这个仓库是一个 Homebrew tap，用来通过 Cask 分发 macOS 应用包。以后如果需要通过 Homebrew 分发命令行工具，也可以在这里添加 Formula。

仓库地址：

- SSH: `git@github.com:guangzhengli/homebrew-tap.git`
- HTTPS: `https://github.com/guangzhengli/homebrew-tap`

参考：这个 tap 的目录结构和维护流程参考了 [`steipete/homebrew-tap`](https://github.com/steipete/homebrew-tap)。

## 我如何使用这个 Tap

这个仓库作为 Homebrew 分发层使用。应用本身应该先在自己的 GitHub 仓库里完成构建、签名、公证和 Release 发布。

常规流程是：

1. 在应用仓库里构建并公证 macOS app。
2. 创建 GitHub Release，例如 `v1.0.0`。
3. 上传 release asset，通常是包含 `Your App.app` 的 `.zip`。
4. 在这个 tap 仓库里新增或更新对应的 cask 文件。
5. 本地用 Homebrew 验证 cask。
6. 提交并推送这个 tap 仓库。

## 添加一个新的 macOS 应用

在 `Casks/` 目录下创建文件，例如 `Casks/your-app.rb`。

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

计算 release asset 的 SHA256：

```bash
curl -fL "https://github.com/<github-owner>/<app-repo>/releases/download/v1.0.0/<asset>.zip" -o /tmp/<asset>.zip
shasum -a 256 /tmp/<asset>.zip
```

把得到的 hash 填到 cask 的 `sha256`。

## 本地验证

在这个仓库目录里执行：

```bash
brew tap guangzhengli/tap .
brew audit --cask --new guangzhengli/tap/your-app
brew install --cask --verbose guangzhengli/tap/your-app
brew uninstall --cask your-app
```

如果本地已经存在同名 tap，并且指向其他目录：

```bash
brew untap guangzhengli/tap
brew tap guangzhengli/tap .
```

## 发布这个 Tap

首次初始化仓库时执行：

```bash
git init
git add README.md README.zh-CN.md .gitignore Casks Formula .github
git commit -m "Set up Homebrew tap"
git branch -M main
git remote add origin git@github.com:guangzhengli/homebrew-tap.git
git push -u origin main
```

如果 `origin` 已经存在：

```bash
git remote set-url origin git@github.com:guangzhengli/homebrew-tap.git
git push -u origin main
```

推送完成后，可以从远程 tap 安装：

```bash
brew tap guangzhengli/tap
brew install --cask guangzhengli/tap/your-app
```

## 更新已有 Cask

手动更新：

1. 发布新的应用版本，例如 `v1.0.1`。
2. 下载新的 release asset 并计算 SHA256。
3. 更新 `Casks/<cask>.rb` 里的 `version`、`sha256` 和 `url`。
4. 重新执行本地 audit 和安装测试。
5. 提交并推送 tap 更新。

GitHub Actions 更新：

1. 打开 `Update Cask` workflow。
2. 手动运行 workflow，填写 cask 名称、release tag、源码仓库和可选的 asset 文件名。
3. 检查 workflow 自动生成的提交。

这个 workflow 会下载 release asset、计算 SHA256、更新 `Casks/<cask>.rb`，然后把变更提交回这个仓库。
