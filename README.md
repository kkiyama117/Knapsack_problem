# Jubijubi
他人の手伝いになります(n回目)

## ダウンロード
1. 右上の方の緑の `Clone or Download` をクリック
2. 出てきたPopupの `Download zip` を押す
3. 手元で解凍する

## 使い方
もし `make` が使えるなら
```
make gap
make run
```

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
To compile "gap.c", type for example

  gcc -Wall -O2 -o gap gap.c -lm

from the command line.
You can also use "makefile", which is also available in
this directory.
 To compile "gap.c", just type `make` from the command line. 

### To execute
The template program "gap.c", if it is unchanged, can be used to check the
cost and feasibility of a solution stored in a file. To use this, type, e.g.,
```shell script
  cat data/c05100 data/sol_c05100-1931 | ./gap givesol 1
  cat data/c05100 data/sol_c05100-infeas | ./gap givesol 1
```

from the command line. (Note that this illustrates the case in which the problem
instances are stored in the directory "data". Note also that files beginning
with c, d or e are the instances, and the files beginning with sol are
feasible and infeasible solutions to the instance "c05100".) If the stored
solution is infeasible, then the output is as follows:
```
  recomputed cost = 1935
  INFEASIBLE!!
   resource left:-17  0  0  2  6
  time for the search:          0.00 seconds
  time to read the instance:    0.00 seconds
```

The first line is the re-evaluated cost. The second line means that the
solution is infeasible, and the third line shows the residual resource at
each agent (a negative value means the excess). The fourth line tells the
CPU seconds consumed by the algorithm (time to read the instance data is
not included), and the fifth line shows the time to read the data file.
If the solution is feasible, the second and third lines are not output.
(The fourth line is not useful in this case, but the output by "gap.c" is
the same, and in the latter case, this line is useful.)

To execute your algorithm (named gap.c), type, e.g.,

  cat data/c05100 | ./gap timelim 300 givesol 0

from the command line. (You can omit "givesol 0", because this is the default
value.) You can also input various parameters from the command line like this.
This is useful to tune the parameter values of your program before submitting
it, though changing the default values of the parameters is not allowed in the
competition.
