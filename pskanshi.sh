#!/bin/bash

# pipeを含む指定コマンドの出力を一行ずつ処理する
while read line
do
  # 一行の出力をスペース区切りで配列に格納する
  psAry=($line)
  # プロセス番号は要素１に、実行経過時間は要素9に格納される

  # 実行経過時間の秒部分":00"をcutで切る為の処理
  # 経過しているプロセスが無い状態から数分に一回の実行を想定し
  # １時間超えの対象プロセスは無いものとする
  psMin=`echo "${psAry[9]}" |rev |cut -c 4- |rev`

  # 実行経過時間が5分より大きければkillを打つ
  if [ $psMin -gt 5 ]; then
    kill -9 ${psAry[1]}
  fi
done < <(ps aux | grep hoge.sh)
# whileで処理するコマンドを指定(psで対象のプロセスを探している)
