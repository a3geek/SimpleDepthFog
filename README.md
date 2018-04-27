SimpleDepthFog
===

カメラからのDepthによって、テクスチャとカラーをLerpさせているだけの物です。

View座標系のZ座標をDepth値としているのですが、なぜか負の値が入ってくるのでマイナスの値を乗算しないと上手く動作しないです。

<br />

![Depth Color = RED](./Images/RedDepth.png)
