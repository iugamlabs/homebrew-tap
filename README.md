# iugam Homebrew tap

Homebrew formulas for iugam and related tools.

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
| `aiquokka`     | [iugamlabs/aiquokka](https://github.com/iugamlabs/aiquokka)         |
| `ship`         | [iugamlabs/ship](https://github.com/iugamlabs/ship)                 |
| `code-porter`  | [iugamlabs/code-porter](https://github.com/iugamlabs/code-porter)   |
| `wechat-clone` | [iugamlabs/wechat-clone](https://github.com/iugamlabs/wechat-clone) |
| `starblog-publisher` | [star-blog/starblog-publisher](https://github.com/star-blog/starblog-publisher) |
| `starblog-publisher-framework-dependent` | [star-blog/starblog-publisher](https://github.com/star-blog/starblog-publisher) |
| `starblog-publisher-self-contained` | [star-blog/starblog-publisher](https://github.com/star-blog/starblog-publisher) |


## Version sync

`aiquokka.rb`, `ship.rb`, and `code-porter.rb` are refreshed by GitHub Actions in this repository (schedule + manual dispatch) from each app's latest GitHub Release and checksum file.

`wechat-clone.rb` is maintained by its own release tooling (GoReleaser).

`starblog-publisher.rb` and its two runtime variants are generated from the
latest GUI Release and its `SHA256SUMS` asset. The default formula is Native
AOT; the framework-dependent variant depends on `dotnet@10`.

## 已有用户 / Existing users

无需卸载应用。旧源名称可保留，只更新 Git remote；避免添加重复源。

Keep installed applications and the existing source name; update its Git remote instead of adding a duplicate source.

[迁移说明 / Migration instructions](https://github.com/iugamlabs/.github/blob/master/docs/migration.md)
