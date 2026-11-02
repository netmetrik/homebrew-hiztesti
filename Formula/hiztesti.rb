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
  version "0.2.3"

  on_macos do
    on_arm do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-darwin-arm64.tgz"
      sha256 "7dd72c28abaa4a180136977dbe03eed5bf3a277297b987a8c596c417990ef3f3"
    end
    on_intel do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-darwin-x86_64.tgz"
      sha256 "3bd1b41f4b58cc170393e21232fd525d957f39c1ccc1111f0426a7576a8dcac1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-linux-aarch64.tgz"
      sha256 "1e501a089fc9d26e82e9d6f3267aaff6e85e07958bdf9867743e47034bc90283"
    end
    on_intel do
      url "https://github.com/netmetrik/hiztesti-cli/releases/download/v#{version}/hiztesti-linux-x86_64.tgz"
      sha256 "591323f8dd1afcf0edbfdd1969c4e4270cae744f25859085de1d09da1d7ac737"
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
