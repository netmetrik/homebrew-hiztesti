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
  version "0.1.13"

  on_macos do
    on_arm do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-darwin-arm64.tgz"
      sha256 "aa5beee1f43c87a141728c2c19c892309bdb227fcf76e4596e8c108074ffb2bd"
    end
    on_intel do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-darwin-x86_64.tgz"
      sha256 "90e203314952fa4a14db3ae59d4b45cfe010b90c2c322d81666d26f384337fb5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-linux-aarch64.tgz"
      sha256 "91a61181d396a880653b30613f0e93d1c3ba4991ef7fb64109ed9bac0bcea802"
    end
    on_intel do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-linux-x86_64.tgz"
      sha256 "dae90ad2b6a04a7afa687423ecedc97c501bf6025f08a8f2ba8e826a7c1dfdc3"
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
