class IsoCodes < Formula
  desc "Provides lists of various ISO standards"
  homepage "https://salsa.debian.org/iso-codes-team/iso-codes"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/i/iso-codes/iso-codes_4.1.orig.tar.xz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/i/iso-codes/iso-codes_4.1.orig.tar.xz"
  sha256 "67117fb76f32c8fb5e37d2d60bce238f1f8e865cc7b569a57cbc3017ca15488a"
  head "https://salsa.debian.org/iso-codes-team/iso-codes.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "09a225b6c89068799a337b88b9f4b0a22e8f04bc609b91318190c37d8eb16405" => :mojave
    sha256 "5d780c5026dd9e639ce62e07f93709bea286482f85a401dec25b89bfe2c0d505" => :high_sierra
    sha256 "5d780c5026dd9e639ce62e07f93709bea286482f85a401dec25b89bfe2c0d505" => :sierra
    sha256 "5d780c5026dd9e639ce62e07f93709bea286482f85a401dec25b89bfe2c0d505" => :el_capitan
  end

  depends_on "gettext" => :build
  depends_on "python"
  depends_on "pkg-config"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    pkg_config = Formula["pkg-config"].opt_bin/"pkg-config"
    output = shell_output("#{pkg_config} --variable=domains iso-codes")
    assert_match "iso_639-2 iso_639-3 iso_639-5 iso_3166-1", output
  end
end
