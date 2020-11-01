# Camera Limit

カメラに Limit をつけると、カメラに写す座標の範囲を制限できる

それをかんたんに設定する方法

1. `Limit` という empty Node を作成
2. `Position2D`　で `TopLeft` と `BottomRight` を作成
3. 境界にしたい位置に置く
4. Camera2D にスクリプトをつけ、 Ready で `camera2d.limit_****` のパラメーターを設定

- `limit_top`
- `limit_left`
- `limit_right`
- `limit_bottom`


更に、カメラの境界に移動を塞ぐ Collision をセットしておくとなおよし