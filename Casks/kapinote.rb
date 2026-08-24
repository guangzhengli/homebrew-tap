cask "kapinote" do
  version "0.10.1"
  sha256 "c2964d4af820983fe96a6d765f4343cd1f5bd4019def05721b5ea1a1229b5a2d"

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
