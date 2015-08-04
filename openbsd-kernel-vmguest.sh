#!/bin/sh

# wylaczenie w configu openbsd opcji, dzieki temu pracuje wydajniej dyskowo jako vm guest
for kernel in /bsd /bsd.mp
do
        config -fe $kernel << EOF
find mpbios
disable mpbios
find mpbios
find acpimadt
disable acpimadt
find acpimadt
quit
EOF
done


