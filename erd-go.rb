require 'formula'

HOMEBREW_ERD_GO_VERSION='1.4.0'
class ErdGo < Formula
  homepage 'https://github.com/kaishuu0123/erd-go'
  url "https://github.com/kaishuu0123/erd-go/releases/download/v#{HOMEBREW_ERD_GO_VERSION}/darwin_amd64_erd-go"
  version HOMEBREW_ERD_GO_VERSION
  head 'https://github.com/kaishuu0123/erd-go.git', :branch => 'master'

  if build.head?
    depends_on 'go' => :build
    depends_on 'make' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath
      system 'go', 'get', 'github.com/Masterminds/glide'
      system 'go', 'get', 'github.com/jteeuwen/go-bindata'
      system 'go', 'get', 'github.com/pointlander/peg'
      mkdir_p buildpath/'src/github.com/kaishuu0123'
      ln_s buildpath, buildpath/'src/github.com/kaishuu0123/erd-go'
      system 'make'
    else
      system 'mv', 'darwin_amd64_erd-go', 'erd-go'
    end
    bin.install 'erd-go'
  end
end
