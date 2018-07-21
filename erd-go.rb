require 'formula'

HOMEBREW_ERD_GO_VERSION='1.4.0'
class ErdGo < Formula
  homepage 'https://github.com/kaishuu0123/erd-go'
  url "https://github.com/kaishuu0123/erd-go/archive/v#{HOMEBREW_ERD_GO_VERSION}.zip"
  version HOMEBREW_ERD_GO_VERSION
  head 'https://github.com/kaishuu0123/erd-go.git', :branch => 'master'

  depends_on 'go@1.9' => :build
  depends_on 'make' => :build

  def install
    ENV['GOPATH'] = buildpath
    system 'make'
    bin.install 'erd-go'
  end
end
