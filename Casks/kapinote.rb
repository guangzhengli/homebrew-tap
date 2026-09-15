cask "kapinote" do
  version "0.12.0"
  sha256 "dcb4303ca448ac124d9b26a5e6a256984d7fc93a8a5f462b4f42de5bfe8d1c42"

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
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Kapinote.app"

  zap trash: [
    "~/Library/Application Support/Kapinote",
    "~/Library/Caches/com.guangzhengli.kapinote",
    "~/Library/Preferences/com.guangzhengli.kapinote.plist",
  ]
end
