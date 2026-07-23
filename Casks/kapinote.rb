cask "kapinote" do
  version "0.8.2"
  sha256 "45aa24c5e31477a204722e87d32a3a12ebf56452bb9417a742c684ba65abf259"

  url "https://github.com/guangzhengli/kapinote-releases/releases/download/v#{version}/Kapinote_0.8.2_aarch64.dmg"
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
