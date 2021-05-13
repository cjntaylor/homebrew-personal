class AutoconfAT269 < Formula
  desc "Automatic configure script builder"
  homepage "https://www.gnu.org/software/autoconf"
  url "https://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz"
  mirror "https://ftpmirror.gnu.org/autoconf/autoconf-2.69.tar.gz"
  sha256 "954bd69b391edc12d6a4a51a2dd1476543da5c6bbf05a95b59dc0dd6fd4c2969"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/cjntaylor/homebrew-personal/releases/download/autoconf@2.69-2.69"
    sha256 cellar: :any_skip_relocation, catalina:     "35943bb970761e54085ef2838d2f72db0d3378a4d743f8aa72e7a1c700fdce2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bc8b79e7c22e97ea90e1727d61b9c2ae0cf750f09b267cb21d2e949cab1b1b16"
  end

  keg_only :versioned_formula

  uses_from_macos "m4"
  uses_from_macos "perl"

  def install
    on_macos do
      ENV["PERL"] = "/usr/bin/perl"

      # force autoreconf to look for and use our glibtoolize
      inreplace "bin/autoreconf.in", "libtoolize", "glibtoolize"
      # also touch the man page so that it isn't rebuilt
      inreplace "man/autoreconf.1", "libtoolize", "glibtoolize"
    end

    system "./configure", "--prefix=#{prefix}",
                          "--with-lispdir=#{elisp}"
    system "make", "install"

    rm_f info/"standards.info"
  end

  test do
    cp prefix/"share/autoconf/autotest/autotest.m4", "autotest.m4"
    system bin/"autoconf", "autotest.m4"
  end
end
