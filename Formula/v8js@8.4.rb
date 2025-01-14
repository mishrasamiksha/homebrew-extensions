# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT84 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/7c40690ec0bb6df72a2ff7eaa510afc7f0adb8a7.tar.gz"
  version "2.1.2"
  sha256 "389cd0810f4330b7e503510892a00902ca3a481dc74423802e06decff966881f"
  head "https://github.com/phpv8/v8js.git", branch: "php8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_ventura:  "e91871498f3693dc6a369ef5523bf02a8bea9ed33632ccee3d20d9e766acfe38"
    sha256 arm64_monterey: "c6892cebcbf7b6061a7dbb62bc9ebd4a416552c804fa508693d05234ca94b1b3"
    sha256 arm64_big_sur:  "199e069a9509a33169cb8080f1132e6274dd0b5656c6ce5bca0436de07b781d1"
    sha256 ventura:        "2b205161b830b6b66c2bb3e638e1352108b8175eca9e22ad0d96e24418725647"
    sha256 monterey:       "542271ea3a13ec9078ed6cdd29b7e35da51b41265ef6151ec8ea5361e0835362"
    sha256 big_sur:        "09e923d03e6d8f90279ec025eb6d2a6315ee866415d865b8268c7c55d6e2f1e0"
    sha256 x86_64_linux:   "38b9302cfc39b992a230ccbdf3944311cea76d9098dcada6288b3d9ad6eb27d8"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
    ENV.append "CPPFLAGS", "-DV8_ENABLE_SANDBOX"
    ENV.append "CXXFLAGS", "-Wno-c++11-narrowing"
    ENV.append "LDFLAGS", "-lstdc++"
    inreplace "config.m4", "$PHP_LIBDIR", "libexec"
    inreplace "v8js_v8object_class.cc", "static int v8js_v8object_get" \
                                      , "static zend_result v8js_v8object_get"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
