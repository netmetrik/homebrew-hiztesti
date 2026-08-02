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
  version "0.1.9"

  on_macos do
    on_arm do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-darwin-arm64.tgz"
      sha256 "5090c9a024ae01cb3f138e5af81d02d13da0659ac365db6080986a45beda00d2"
    end
    on_intel do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-darwin-x86_64.tgz"
      sha256 "6e72ee98e732ff03bf4c6464c5eab1ebb18e3927bc9fb54d2092ed991d26831a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-linux-aarch64.tgz"
      sha256 "3be9e1cbf652643cbcf0f11fc08ba587797012fa1ab6afdea0d625a2b2fd4020"
    end
    on_intel do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-linux-x86_64.tgz"
      sha256 "045d5f50fcf2aacc532523384d1ffd48f8226f12e2a6cf0c6aa18c69c58109f7"
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
