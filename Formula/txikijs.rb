class Txikijs < Formula
  desc "Tiny JavaScript runtime"
  homepage "https://txikijs.org"
  # pull from git tag to get submodules
  url "https://github.com/saghul/txiki.js.git",
    tag:      "v26.5.0",
    revision: "9d7b4dbdf0cd653eab51a77144a2db77c5abcd1e"
  license "MIT"
  head "https://github.com/saghul/txiki.js.git", branch: "master"

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
