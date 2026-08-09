cask "kapinote" do
  version "0.9.1"
  sha256 "90c51b0a5dbe5a4ec3eff365049f6f9ee0593663d2cec96758fbde4be7a30cc7"

  url "https://github.com/guangzhengli/kapinote-releases/releases/download/v#{version}/Kapinote_0.9.1_aarch64.dmg"
  name "Kapinote"
  desc "Desktop meetings app"
  homepage "https://github.com/guangzhengli/kapinote-releases"

  depends_on arch: :arm64

  app "Kapinote.app"

  zap trash: [
    "~/Library/Application Support/Kapinote",
    "~/Library/Caches/com.guangzhengli.kapinote",
    "~/Library/Preferences/com.guangzhengli.kapinote.plist",
  ]
end
