{ pkgs }:

let
  # Latest commit touching the robotomono tree
  commit = "5338537ef835a3d9ccf8faf386399f13a30605e2";
in
pkgs.stdenv.mkDerivation {
  pname = "et-book-font";
  version = "1.0";

  srcs = [
    (pkgs.fetchurl {
      url = "https://github.com/edwardtufte/et-book/raw/gh-pages/et-book-ligatures-enabled/et-book-bold-line-figures/ETBookOT-Bold.otf";
      sha256 = "sha256-yIc5ZtoLIz8XeKJ3TBREjKKnMexRNV+Ruz2Xq0w4Dwo=";
    })
    (pkgs.fetchurl {
      url = "https://github.com/edwardtufte/et-book/raw/gh-pages/et-book-ligatures-enabled/et-book-display-italic-old-style-figures/ETBookOT-Italic.otf";
      sha256 = "sha256-HZjcXnIqF1wdLsf3HIX0jWmydPdiys6N5iu8JxK27Gg=";
    })
    (pkgs.fetchurl {
      url = "https://github.com/edwardtufte/et-book/raw/gh-pages/et-book-ligatures-enabled/et-book-roman-old-style-figures/ETBookOT-Roman.otf";
      sha256 = "1cayhm3wj36q748xd0zdgrhm4pz7wnrskrlf7khxx2s41m3win5b";
    })
    (pkgs.fetchurl {
      url = "https://github.com/edwardtufte/et-book/raw/gh-pages/et-book/et-book-bold-line-figures/et-book-bold-line-figures.ttf";
      sha256 = "04238dxizdlhnnnyzhnqckxf8ciwlnwyzxby6qgpyg232abx0n2z";
    })
    (pkgs.fetchurl {
      url = "https://github.com/edwardtufte/et-book/raw/gh-pages/et-book/et-book-display-italic-old-style-figures/et-book-display-italic-old-style-figures.ttf";
      sha256 = "00rh49d0dbycbkjgd2883w7iqzd6hcry08ycjipsvk091p5nq6qy";
    })
    (pkgs.fetchurl {
      url = "https://github.com/edwardtufte/et-book/raw/gh-pages/et-book/et-book-roman-line-figures/et-book-roman-line-figures.ttf";
      sha256 = "0fxl6lblj7anhqmhplnpvjwckjh4g8m6r9jykxdrvpl5hk8mr65b";
    })
    (pkgs.fetchurl {
      url = "https://github.com/edwardtufte/et-book/raw/gh-pages/et-book/et-book-roman-old-style-figures/et-book-roman-old-style-figures.ttf";
      sha256 = "1h8rbc2p70fabkplsafzah1wcwy92qc1wzkmc1cnb4yq28gxah4a";
    })
    (pkgs.fetchurl {
      url = "https://github.com/edwardtufte/et-book/raw/gh-pages/et-book/et-book-semi-bold-old-style-figures/et-book-semi-bold-old-style-figures.ttf";
      sha256 = "08y2qngwy61mc22f8i00gshgmcf7hwmfxh1f4j824svy4n16zhsc";
    })
  ];

  sourceRoot = "./";

  unpackCmd = ''
    ttfName=$(basename $(stripHash $curSrc))
    cp $curSrc ./$ttfName
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp -a *.otf $out/share/fonts/truetype/
    cp -a *.ttf $out/share/fonts/truetype/
  '';

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "sha256-cRrIE81ph3ho1KwyqpeyEYwOfx9yOb33mTsEMryb6hk=";

  meta = with pkgs.lib; {
    homepage = "https://github.com/edwardtufte/et-book";
    description = "A webfont version of the typeface used in Edward Tufte’s books";
    longDescription = ''
      ET Book was designed by Dmitry Krasny, Bonnie Scranton, and Edward Tufte.
      It was converted from the original suit files by Adam Schwartz (@adamschwartz).
    '';
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [ "Sagar Patil" ];
  };
}
