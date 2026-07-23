# Usage

因为没发现一个同时支持中文和日语的输入方案, 所以我就自建一个. 同时基于日语配列的键盘做了一些个人配置.

完整的快捷键、中文与日语输入技巧见：[Rime 使用速查](usage.md)。

- `Ctrl + .` : 方案切换, 日语配列下 grave 符号 不是在数字1左侧, 而是在字母P右侧, 而且需要使用shift才能打出, 所以我把方案切换改为了 `Ctrl + .`, 这样的话通过period翻页的方式也被禁用. 其他快捷键在 [`default.yaml`] 中可查看.
- `Shift_L` : 输入码上屏, 然后切换英语
- `Shift_R` : 首选候选码上屏, 然后切换英语
- `Enter` : 输入码上屏, 不切换

参考的项目

- 中文输入基于[iDvel/雾凇拼音](https://github.com/iDvel/rime-ice)
- 皮肤使用了[Mintimate/oh-my-rime](https://github.com/Mintimate/oh-my-rime)的配置.
- 日语输入基于[lazyfoxchan/rime-jaroomaji](https://github.com/lazyfoxchan/rime-jaroomaji)

其他参考的项目在文末.

其中一些额外配置, 如降低英文单词的权重需要更新librime, 参考了[rime-ice/issues](https://github.com/iDvel/rime-ice/issues/133)
## 安装
Windows上可以用winget

Mac上使用
```shell
brew install --cask squirrel
rm -rf ~/Library/Rime
git clone https://github.com/Insomnia1437/rime.git ~/Library/Rime/
```

## 中文输入

资料很详尽, 略.

## ローマ字 -> カナ 変更

[romaji to kana](romaji-to-kana.md)

## 日本語のローマ字表記の推奨形式

对于romaji to kana 的转换, 常用有两种, (才发现我之前的习惯是混用二者..😅)

- 訓令式, romaji较短
- ヘボン式, 与英语发音对应

|      | 訓令式 | ヘボン式 |
| ---- | ------ | -------- |
| し   | si     | shi      |
| じ   | zi     | ji       |
| つ   | tu     | tsu      |
| しゃ | sya    | sha      |
| じゃ | zya    | ja       |
| ちょ | tyo    | cho      |
| しょ | syo    | sho      |

以上为例子.

另一例, 对于`ちかてつ`, 前者需要输入`tikatetu`, 英语话者按照英语拼读的话与实际发音差异较大, 而后者的输入码为`chikatetsu`, 英语发音与日语读音接近.

东京大学(见参考文献7)推荐使用后者. 但对于长音, 促音, hyphen, 鼻音的使用又有不同的建议.

- 长音, ばあい (場合) baai (×bāi), かつうら (勝浦) Katsuura (×Katsūra)
- 促音, あっしゅく asshuku, あっちゃく atchaku, よっつ yottsu
- 鼻音, しんかんせん shinkansen, ほんい hon’i, ほんやく hon’yaku
- hyphen, 田中さん Tanaka-san, 山の手線 Yamanotesen または Yamanote Line (×Yamanote-sen)

但对于鼻音的输入, 使用分隔符显得麻烦. 最好是能做到自动识别, 比如输入konyaku, 会同时候选こんやく和こにゃく.

## 在Mac上的某些app中默认不启用中文

首先得到某个app的Identifier, 以Firefox为例, 以下命令会得到`org.mozilla.firefox`

`cat /Applications/Firefox.app/Contents/Info.plist| grep -A 1 BundleIdentifier| sed -n '2p'| tr -d ' '| cut -d '<' -f 2 | cut -d '>' -f 2`

然后在`squirrel.custom.yaml`文件中加入需要设定的app Identifier
```yaml
patch:
  app_options:
    com.apple.Spotlight:
      ascii_mode: true    # 开启默认英文
    org.alacritty:
      ascii_mode: true
    com.uranusjr.macdown:
      ascii_mode: true
    org.mozilla.firefox:
      ascii_mode: true
    com.raycast.macos:
      ascii_mode: true
    com.microsoft.VSCode:
      ascii_mode: true
```

## TODO

- 暂无

## 参考/致谢

1. [Rime/RimeWithSchemata](https://github.com/rime/home/wiki/RimeWithSchemata)
2. [Mintimate/oh-my-rime](https://github.com/Mintimate/oh-my-rime)
3. [LEOYoon-Tsaw/Rime_collections/Rime description](https://github.com/LEOYoon-Tsaw/Rime_collections/blob/master/Rime_description.md)
4. [iDvel/雾凇拼音](https://github.com/iDvel/rime-ice)
5. [gkovacs/rime-japanese](https://github.com/gkovacs/rime-japanese)
6. [DreamAfar/Rime-Japanese ](https://github.com/DreamAfar/Rime-Japanese)
7. [日本語のローマ字表記の推奨形式](https://park.itc.u-tokyo.ac.jp/eigo/UT-Komaba-Nihongo-no-romaji-hyoki-v1.pdf)
8. [lazyfoxchan/rime-jaroomaji](https://github.com/lazyfoxchan/rime-jaroomaji)
