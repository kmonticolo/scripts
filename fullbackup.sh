#!/usr/bin/ksh

export DSM_DIR=/usr/tivoli/tsm/client/ba/bin64
export DSM_LOG=/usr/tivoli/tsm/client/LOG

SEEDFILE=/usr/tivoli/tsm/client/CFG/seedfile
LOGFILE=/usr/tivoli/tsm/client/LOG/file_backup.log
OPT14D=/usr/tivoli/tsm/client/CFG/dsm_14D.opt
OPT3M=/usr/tivoli/tsm/client/CFG/dsm_3M.opt

echo "Backup uruchomiony: " > $LOGFILE
date >> $LOGFILE


if [[ ! -f $SEEDFILE ]] then
        RAND=$(($RANDOM%29+1))
        echo $RAND  > $SEEDFILE
        echo Dopisalem SEED: $RAND >> $LOGFILE
fi

SEED=`cat $SEEDFILE`
DAY=`date +%d`

echo Uzyskany seed to: $SEED >> $LOGFILE


if [[ $DAY -eq $SEED ]] then
        echo SEED:$SEED zgadza sie z DAY:$DAY >> $LOGFILE

        echo Wykonuje backup pelny 14d >> $LOGFILE
        dsmc selective -optfile=$OPT14D -subdir=yes / /usr/ /var/ /home/ /admin/ /opt/ /opt/oracle/ /opt/ctmuser/ /opt/emuser/ /vol/ctm01/ /vol/ctm02/ /vol/ctm03/ >> $LOGFILE 2>&1

        echo Wykonuje backup pelny 3m >> $LOGFILE
        dsmc selective -optfile=$OPT3M -subdir=yes / /usr/ /var/ /home/ /admin/ /opt/ /opt/oracle/ /opt/ctmuser/ /opt/emuser/  /vol/ctm01/ /vol/ctm02/ /vol/ctm03/ >> $LOGFILE 2>&1

else
        echo SEED:$SEED sie nie zgadza z DAY:$DAY >> $LOGFILE
        echo Wykonuje backup incrementalny 14d >> $LOGFILE
        dsmc incr -optfile=$OPT14D -subdir=yes / /usr/ /var/ /home/ /admin/ /opt/ /opt/oracle/ /opt/ctmuser/ /opt/emuser/ /vol/ctm01/ /vol/ctm02/ /vol/ctm03/  >> $LOGFILE 2>&1

