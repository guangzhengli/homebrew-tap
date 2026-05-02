cask "kapinote" do
  version "0.4.1"
  sha256 "1c1643c6ffd4693bbdc02933e1e0890c59a8d131d45c5c07ada8a5dd5d2d3ee9"

  url "https://github.com/guangzhengli/kapinote-releases/releases/download/v#{version}/Kapinote_0.4.1_aarch64.dmg"
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
