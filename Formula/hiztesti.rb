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
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-darwin-arm64.tgz"
      sha256 "c672398c522d88c98b2e117e1ff8ee6f76cb7b3722dc5153609b9e76aa0abacf"
    end
    on_intel do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-darwin-x86_64.tgz"
      sha256 "9320b75b87f50c536c9c9255c4e403fe98cca5b9e0e7c0ed2dea47cb47cd80f6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-linux-aarch64.tgz"
      sha256 "8c15f88c9fc450b04df840042149ea920f26e3905a7a30f27f9df028f459afeb"
    end
    on_intel do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-linux-x86_64.tgz"
      sha256 "b782d8cc1aa41ee9968ad7a019b022ddafa2920b002bd0dd6a019cfc2ffef2ee"
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
