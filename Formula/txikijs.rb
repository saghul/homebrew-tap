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
    root_url "https://github.com/saghul/homebrew-tap/releases/download/txikijs-26.5.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "55197727fc6019a102b160e3fcc6863d572ad9f63945ea54a6c1c925548f8f42"
    sha256 cellar: :any_skip_relocation, sequoia:      "70e051658d21103c372c15049943e298c4e49d3ff5ea4172e3e2a5e01773ab25"
    sha256 cellar: :any,                 x86_64_linux: "e42feeffc0e1c92eb0cf182d76cf96ca3a0b8726c1aa39c8c014eda924837dcb"
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
