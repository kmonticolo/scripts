#!/bin/bash

i=$(( (RANDOM % 19) + 1))
#i=$1
b=$(( $i%2))
case $b in
0) a=Montisia ;;
1) a=Migotke ;;
esac
echo $b >>/tmp/a
echo $i >>/tmp/x
j="Kocham $a"

case $i in
1) cowsay -f  Beavis  $j ;;
2) cowsay -f  Bunny  $j ;;
3) cowsay -f  Cheese  $j ;;
4) cowsay -f  Cow  $j ;;
5) cowsay -f  Daemon  $j ;;
6) cowsay -f  Dragon  $j ;;
7) cowsay -f  Elephant  $j ;;
8) cowsay -f  Frogs  $j ;;
9) cowsay -f  Ghostbusters  $j ;;
10) cowsay -f  Kitty  $j ;;
11) cowsay -f  Koala  $j ;;
12) cowsay -f  Moose  $j ;;
13) cowsay -f  Ren  $j ;;
14) cowsay -f  Sheep  $j ;;
15) cowsay -f  Stegosaurus  $j ;;
16) cowsay -f  Stimpy  $j ;;
17) cowsay -f  Turkey  $j ;;
18) cowsay -f  Turtle  $j ;;
19) cowsay -f  Tux $j ;;
esac 
