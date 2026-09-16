# iugamlabs Homebrew tap

Homebrew formulas for iugamlabs and related tools.

## Install

```bash
brew tap iugamlabs/tap

brew install aiquokka
brew install ship
brew install code-porter
brew install wechat-clone
brew install starblog-publisher
```

> Homebrew maps repository `iugamlabs/homebrew-tap` to the tap name `iugamlabs/tap`.

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
| `starblog-publisher` | [star-blog/starblog-publisher](https://github.com/star-blog/starblog-publisher) |
| `starblog-publisher-framework-dependent` | [star-blog/starblog-publisher](https://github.com/star-blog/starblog-publisher) |
| `starblog-publisher-self-contained` | [star-blog/starblog-publisher](https://github.com/star-blog/starblog-publisher) |


## Version sync

`aiquokka.rb`, `ship.rb`, and `code-porter.rb` are refreshed by GitHub Actions in this repository (schedule + manual dispatch) from each app's latest GitHub Release and checksum file.

`wechat-clone.rb` is maintained by its own release tooling (GoReleaser).

`starblog-publisher.rb` and its two runtime variants are generated from the
latest GUI Release and its `SHA256SUMS` asset. The default formula is Native
AOT; the framework-dependent variant depends on `dotnet@10`.
