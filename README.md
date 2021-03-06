<div align="center">

# asdf-artefactor [![Build](https://github.com/lukeab/asdf-appvia-artefactor/actions/workflows/build.yml/badge.svg)](https://github.com/lukeab/asdf-appvia-artefactor/actions/workflows/build.yml) [![Lint](https://github.com/lukeab/asdf-appvia-artefactor/actions/workflows/lint.yml/badge.svg)](https://github.com/lukeab/asdf-appvia-artefactor/actions/workflows/lint.yml)


[artefactor](https://github.com/appvia/artefactor) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add artefactor
# or
asdf plugin add artefactor https://github.com/lukeab/asdf-appvia-artefactor.git
```

artefactor:

```shell
# Show all installable versions
asdf list-all artefactor

# Install specific version
asdf install artefactor latest

# Set a version globally (on your ~/.tool-versions file)
asdf global artefactor latest

# Now artefactor commands are available
artefactor --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Why

I worked on artefactor years ago and it follows good versioning in its release patterns. So as a test of asdf plugin development :neckbeard: and perhaps for some sort of vanity :love_letter: I wanted to make this plugin for asdf.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/lukeab/asdf-appvia-artefactor/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Luke Ashe-Browne](https://github.com/lukeab/)
