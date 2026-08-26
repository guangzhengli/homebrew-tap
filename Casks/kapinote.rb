cask "kapinote" do
  version "0.11.0"
  sha256 "3f99536a987ba67c6547853339ef1101670344f155a7433b4f44cca12e37430b"

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
