#!/bin/bash
. ./demo-env.sh
echo "Hello, "$USER".  This script will help you set up ENV for khan session manager demo."

Check_Value=1
while [ $Check_Value == 1 ]
do
  echo "  1) Library mode"
  echo "  2) Server/Client mode (Hotrod) "
  echo -n  "(1): "
  read -n1  FIRST_SELECT
  if [[ $FIRST_SELECT == "" ]];
  then
    FIRST_SELECT=1
     Check_Value=0
  elif [ $FIRST_SELECT -gt 0 ] && [ $FIRST_SELECT -lt 3 ];
  then
     Check_Value=0
  else
     echo "Please select 1 or 2"
  fi
done
 case $FIRST_SELECT in
         1)
          ./demo-lib-start.sh 
           ;;
         2)
         ./demo-hotrod-start.sh
           ;;
          *)
           echo "Please select proper number"
           ;;
     esac


echo $LINE_BLANK
