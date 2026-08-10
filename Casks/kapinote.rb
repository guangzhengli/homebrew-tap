cask "kapinote" do
  version "0.9.3"
  sha256 "30d3ad02bff6b08e2b107b099041d1632b480759e6ea3f5cd737984e311a0dc2"

  url "https://github.com/guangzhengli/kapinote-releases/releases/download/v#{version}/Kapinote_0.9.3_aarch64.dmg"
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
