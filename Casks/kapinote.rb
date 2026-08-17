cask "kapinote" do
  version "0.9.11"
  sha256 "fb6a22ad693bfa02634fe8a240ed8f0e9775676588590e0eed6385725bf4836f"

  url "https://github.com/guangzhengli/kapinote-releases/releases/download/v#{version}/Kapinote_0.9.11_aarch64.dmg"
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
