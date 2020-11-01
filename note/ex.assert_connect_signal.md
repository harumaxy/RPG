# Assert Connect Signal

`node.connect(signal, obj, method_name)`の戻り値は、
結果を示す enum整数値


値を無視すると警告が出るし、
使いもしない`var _res`とかに代入しても見栄えが悪い。

`_ready`で接続する文については、`assert(res == OK)`でラップすると
開発段階ではエラーも検知できていい感じ

```gd
func _ready():
  assert(stats.connect("no_health", self, "queue_free") == OK)
  assert(hurtbox.connect("area_entered", self, "_on_HurtBox_area_entered") == OK)
```

実行中に、動的に signal を connect, disconnect するようなコードだと
やらないほうがいいかもしれない
(実行中に assert エラーで止まる)

なお、DEBUG build または editor 内でゲームを動かしてるときしか
`assert`は動作しないらしい？

内部で式を評価するのはやらないほうがいい？
(`release`buidl すると connect されない？)


# signal に登録されるメソッドの引数

引数が signal のスキーマと違うと、
`connect()`ではエラーが出ないのに 実際の動作中は signal が発生しても動作しない

`assert` では検知できない