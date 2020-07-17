# How to
## 課題概要
GAPの解決をする.
instanceの読み込みと, 解法のコストの計算も含む.

### Domain
- Job(count is `n`)
  - index(`int`, `0...n-1`)
  
- Agent(count is `m`)
  - index(`int`, `0...m-1`)

#### Warning and help
- SolutionのFileではIndexがそれぞれ `1...m`, `1...n` になってるので注意
- `Param` 構造体や 与えられた `timelim` を上手く使おう 

### Example
以下の例を想定する.
- `n=4`
- `m=3`

割り当ての例としては以下になる
|  Job  | 1 | 2 | 3 | 4 |
| ---- | ---- | ---- | ---- | ---- |
| Agent | 2 | 1 | 3 | 1 |

## Copy of `README.eng`
以下、要点のみまとめる.
### Programming
- `gap.c` という単一ファイルが望ましい
- 分割するならMake使って`gap`というバイナリにまとめろ
- Subroutine の re-computed cost のみを出力すべし
- 日本語禁止(コメント含む)
- `timelim`と`recomputed_cost()` は勝手に変えるな
- timelimitを超えたらとめるべき
  - 例: 
  ```c
      if((cpu_time() - vdata->starttime) > param->timelim){break;}
  ```
  - ただしMain-loopを抜けるのにTIMELIMを使ってはいけない.
  ```c
      if((cpu_time() - vdata->starttime) > TIMELIM){break;}
  ```
- `cpu_time()` を頻繁に呼ばない. 
  - 多少超えてもいいが, 1minでペナルティが出る

### competition
今回は略

### To compile
```shell script
  gcc -Wall -O2 -o gap gap.c -lm
```
```shell script
  make
```

### To execute
- もし `gap_c` が変更されていないなら, `solution file` のcost と 実現可能性をチェックできる.
  ```shell script
    cat data/c05100 data/sol_c05100-1931 | ./gap givesol 1
    cat data/c05100 data/sol_c05100-infeas | ./gap givesol 1
  ```
- 実行する場合
  ```shell script
    cat data/c05100 | ./gap timelim 300
  ```
- `c`, `d`, `e` ではじまるファイルが instance,
`sol` ではじまるファイルが実現可能or不可能な解
- もし 実現不可能な解の場合, 以下の出力になる
  ```
    recomputed cost = 1935
    INFEASIBLE!!
     resource left:-17  0  0  2  6
    time for the search:          0.00 seconds
    time to read the instance:    0.00 seconds
  ```
  - 1行目が再評価コスト
  - 2行目が Infeasableかどうか
  - 3行目が 各Agentの残りの余剰リソースを表す(負の場合超過を表す)
  - 4行目が アルゴリズムのみの実行時間を表す
  - 5行目が ファイルの読み込みの時間を表す
- 実現可能な場合, 2,3行目は出力されない
