class Txikijs < Formula
  desc "Tiny JavaScript runtime"
  homepage "https://txikijs.org"
  # pull from git tag to get submodules
  url "https://github.com/saghul/txiki.js.git",
    tag:      "v26.6.0",
    revision: "1a230d31183f062fae7a6c4fd2cff466cecc1787"
  license "MIT"
  head "https://github.com/saghul/txiki.js.git", branch: "master"

  bottle do
    root_url "https://github.com/saghul/homebrew-tap/releases/download/txikijs-26.6.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "bfd229767477241e16ea46aeac23d5f55b7273c909253a04e3e67d480124fd23"
    sha256 cellar: :any_skip_relocation, sequoia:      "5ec3300ff34d1ecd5d19f564a00cb7b5711dd77a8bb8f2f148b17ee937974fa9"
    sha256 cellar: :any,                 x86_64_linux: "c297fc04615d2f112e843baa290f838a0265d506706919e2ebd16731a11d6cd8"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           "-DHOMEBREW_ALLOW_FETCHCONTENT=ON",
           *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/tjs"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tjs --version")
    assert_equal "hello", shell_output("#{bin}/tjs eval \"console.log('hello')\"").strip
  end
end
