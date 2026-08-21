cask "kapinote" do
  version "0.9.15"
  sha256 "4ced75c24baf2510a2e230cd2ad40d928fc7a2876a8dae3fe61dd4e02da73102"

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
