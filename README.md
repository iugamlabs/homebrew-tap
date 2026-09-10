# star-plan Homebrew tap

Homebrew formulas for [star-plan](https://github.com/star-plan) (and related) CLI tools.

## Install

```bash
brew tap star-plan/tap

brew install aiquokka
brew install ship
brew install code-porter
brew install wechat-clone
```

> Homebrew maps repository `star-plan/homebrew-tap` to the tap name `star-plan/tap`.

Update:

```bash
brew update

brew upgrade aiquokka
brew upgrade ship
brew upgrade code-porter
```

## Formulas

| Formula        | Source                                                              |
| -------------- | ------------------------------------------------------------------- |
| `aiquokka`     | [star-plan/aiquokka](https://github.com/star-plan/aiquokka)         |
| `ship`         | [heyoungai/ship](https://github.com/heyoungai/ship)                 |
| `code-porter`  | [star-plan/code-porter](https://github.com/star-plan/code-porter)   |
| `wechat-clone` | [star-plan/wechat-clone](https://github.com/star-plan/wechat-clone) |


## Version sync

`aiquokka.rb`, `ship.rb`, and `code-porter.rb` are refreshed by GitHub Actions in this repository (schedule + manual dispatch) from each app's latest GitHub Release and checksum file.

`wechat-clone.rb` is maintained by its own release tooling (GoReleaser).