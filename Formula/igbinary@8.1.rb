# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhp81Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.1.6.tar.gz"
  sha256 "86079a3a0e0ea46292ed0ebe69748c5e09c68fe5b0e274d0dd45f3d9c80f61a8"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "f70e4b8bd87ba595123244fcf54b5bf489b4757f8bfafbf248fed28611d02bd6" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/igbinary.so"
    write_config_file
  end
end
