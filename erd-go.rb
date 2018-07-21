require 'formula'

HOMEBREW_ERD_GO_VERSION='1.4.0'
class ErdGo < Formula
  homepage 'https://github.com/kaishuu0123/erd-go'
  url "https://github.com/kaishuu0123/erd-go/releases/download/v#{HOMEBREW_ERD_GO_VERSION}/darwin_amd64_erd-go"
  version HOMEBREW_ERD_GO_VERSION
  head 'https://github.com/kaishuu0123/erd-go.git', :branch => 'master'

  if build.head?
    depends_on 'go' => :build
    depends_on 'glide' => :build
    depends_on 'peg' => :build
    depends_on 'go-bindata' => :build
    depends_on 'make' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath
      system 'make'
    else
      system 'mv', 'darwin_amd64_erd-go', 'erd-go'
    end
    bin.install 'erd-go'
  end
end
