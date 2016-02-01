class Pb < Formula
  desc "CLI Pastebin.com client"
  homepage "https://github.com/0xCD/pb"
  url "https://github.com/0xCD/pb/archive/1.0.0.tar.gz"
  sha256 "934d90618949a141086cac8422e9618896c369ada9b97dcddbe9a3d7c4ba9178"
  head "https://github.com/0xCD/pb"

  bottle :unneeded

  def install
    bin.install "pb"
  end

  test do
    system "#{bin}/pb"
  end
end
