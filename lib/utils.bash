#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for artefactor.
GH_REPO="https://github.com/appvia/artefactor"
TOOL_NAME="artefactor"
TOOL_TEST="artefactor --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if artefactor is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  list_github_tags
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  local platform
  [ "Linux" = "$(uname)" ] && platform="linux" || platform="darwin"

  local arch
  machine=$(uname -m)
  if [[ $machine == "arm64" ]] || [[ $machine == "aarch64" ]]; then
    arch="arm64"
    echo "${TOOL_NAME} does not currently support arm architecture" && exit 1
  elif [[ $machine == *"386"* ]]; then
    arch="386"
  else
    arch="amd64"
  fi

  # TODO: Adapt the release URL convention for artefactor
  url="$GH_REPO/releases/download/v${version}/artefactor_${platform}_${arch}"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

    # TODO: Asert artefactor executable exists.
    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
