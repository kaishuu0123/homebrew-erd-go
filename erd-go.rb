HOMEBREW_ERD_GO_VERSION="1.4.5".freeze
class ErdGo < Formula
  desc "Translates plain text of RDB schema to entity-relationship diagram"
  homepage "https://github.com/kaishuu0123/erd-go"
  url "https://github.com/kaishuu0123/erd-go/releases/download/v#{HOMEBREW_ERD_GO_VERSION}/darwin_amd64_erd-go"

  version HOMEBREW_ERD_GO_VERSION
  sha256 "c260cf3d05952d3d07a7d76d985c26c5780e5b3ec58f1603c46f70f2c320e07d"

  head "https://github.com/kaishuu0123/erd-go.git", :branch => "master"

  if build.head?
    depends_on "go" => :build
    depends_on "go-bindata" => :build
    depends_on "make" => :build
  end

  def install
    if build.head?
      ENV["GOPATH"] = buildpath
      ENV.prepend_create_path "PATH", buildpath/"bin"
      dir = buildpath/"src/github.com/kaishuu0123/erd-go"
      dir.install buildpath.children - [buildpath/".brew_home"]

      cd dir do
        system "make", "build_no_peg"
        cp "erd-go", buildpath
      end
    else
      mv "darwin_amd64_erd-go", "erd-go"
    end
    bin.install "erd-go"
    prefix.install_metafiles
  end

  test do
    assert_match 'erd-go', shell_output("#{bin}/erd-go --help", 1)
  end
end
