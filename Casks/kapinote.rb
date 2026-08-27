cask "kapinote" do
  version "0.11.1"
  sha256 "2de51d34dedd1ca8c24053a5e173f7c3ebe48232a0bffb0cc384b9c631394ea7"

  url "https://dl.kapinote.com/v#{version}/Kapinote_#{version}_aarch64.dmg"
  name "Kapinote"
  desc "Desktop meetings app"
  homepage "https://kapinote.com/"

  livecheck do
    url "https://dl.kapinote.com/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Kapinote.app"

  zap trash: [
    "~/Library/Application Support/Kapinote",
    "~/Library/Caches/com.guangzhengli.kapinote",
    "~/Library/Preferences/com.guangzhengli.kapinote.plist",
  ]
end
