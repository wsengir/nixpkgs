{ lib
, beautifulsoup4
, buildPythonPackage
, fetchPypi
, filelock
, requests
, tqdm
, setuptools
, six
, pythonOlder
}:

buildPythonPackage rec {
  pname = "gdown";
  version = "4.6.2";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-/2pPAymq6dek2NsInD+ga+CYOTG7BPgWGNm7Iwp2GHg=";
  };

  propagatedBuildInputs = [
    beautifulsoup4
    filelock
    requests
    tqdm
    setuptools
    six
  ] ++ requests.optional-dependencies.socks;

  checkPhase = ''
    $out/bin/gdown --help > /dev/null
  '';

  pythonImportsCheck = [
    "gdown"
  ];

  meta = with lib; {
    description = "A CLI tool for downloading large files from Google Drive";
    homepage = "https://github.com/wkentaro/gdown";
    changelog = "https://github.com/wkentaro/gdown/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
