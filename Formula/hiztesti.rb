# Homebrew formülü — ŞABLON.
#
# Yayınlamak için ayrı bir depo gerekir: github.com/<org>/homebrew-hiztesti
# Kullanıcı tarafı:  brew tap <org>/hiztesti && brew install hiztesti
#
# Ookla'nın deposu da tam olarak böyle çalışıyor (teamookla/homebrew-speedtest —
# 21 deponun içinde YALNIZ formül var, CLI kaynağı yok).
#
# SÜRÜM ÇIKARKEN: version + url + sha256 üçü birden güncellenir. sha256'ları
# `make cli-release` çıktısındaki build/release/SHA256SUMS.hiztesti verir.
class Hiztesti < Formula
  desc "Internet speed and quality measurement from the command line"
  homepage "https://hiztesti.com"
  license :cannot_represent # tescilli; kaynak yayımlanmıyor
  version "0.1.16"

  on_macos do
    on_arm do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-darwin-arm64.tgz"
      sha256 "c5f87134caab00ac970673e85e276b5cfcc55046e1d7a699544b0039cb083d73"
    end
    on_intel do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-darwin-x86_64.tgz"
      sha256 "42dc95540f8b10dcac6a60f7970bad97f2f8852fbf152bfee84dccdc49276b58"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-linux-aarch64.tgz"
      sha256 "25d386cf858cd6c5325376d26e5cca55f9b3586a5fa8d96e2190220a14bafc56"
    end
    on_intel do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-linux-x86_64.tgz"
      sha256 "7627123d339501979a10743cb6f7e0b3af23d9352faf7f0a756ef0e146993441"
    end
  end

  def install
    bin.install "hiztesti"
  end

  test do
    # Ağa çıkmayan tek doğrulama: sürüm bayrağı. `brew test` sandbox'ta ve CI'da
    # koşar; gerçek ölçüm denemek testi ağ durumuna bağımlı kılardı.
    assert_match "hiztesti", shell_output("#{bin}/hiztesti --version")
  end
end
