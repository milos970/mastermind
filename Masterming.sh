#!/bin/bash

clear
color1=$[RANDOM%6+1]
color2=$[RANDOM%6+1]
color3=$[RANDOM%6+1]
color4=$[RANDOM%6+1]

code=($color1 $color2 $color3 $color4)
echo "*** Vitajte v hre logik ***"
echo "Vašou úlohou bude nájsť štvorfarebný farebný kód."
echo "Farby sú červená zelená modrá fialová žltá svetlomodrá."
echo "Jednotlivé farby sú zadávané číselnou formou v jednom riadku oddelené medzerou."
echo "Po zadaní 4 farieb sa vyhodnotí Váš pokus."
echo "Zobrazí sa Vám informácia o tom, koľko farieb v kóde Ste uhádli (biely znak 0) a koľko farieb a ich umiestnení ste uhádli (čierny znak ø)."
read -p  "Zadajte svoj nick: " nick
echo "$nick zadajte obtiažnosť:"
echo "1. ľahká - 6 farieb a 12 pokusov na uhádnutie"
echo "2. stredná - 6 farieb a 9 pokusov na uhádnutie"
echo "3. ťažká - 6 farieb a 6 pokusov na uhádnutie"
read -t 5 dificulty


dificulty=$(echo $dificulty | tr '[:upper:]' '[:lower:]')

case $dificulty in

   2 | s | stredná | stredna )
    dificulty="stredná"
    attempts=9
    ;;

   3 | ť | t | ťažká | tazka | ťazka | ťažka | tažka | tažká | ťazká )
    dificulty="ťažká"
    attempts=6
    ;;

   1 | ľ | l | ľahká | lahká | lahka | ľahka | $(echo $?) | * )
    dificulty="ľahká"
    attempts=12
    ;;

esac

echo "Zvolená $dificulty obtiažnosť!"


arr=()
for ((i = 1 ; i <= $attempts  ; i++)); do
  echo Pokus č.$i

  echo "červená - 1 zelená - 2 modrá - 3 fialová - 4 žltá - 5 svetlomodrá - 6"
  read -p "$nick zadajte kombináciu v tvare 1 1 1 1: " array
  arr=($array)
  echo "Zadaná postupnosť $array"

  result=""
  let right=0

 arrClone=("${arr[@]}")
 codeClone=("${code[@]}")
 
  if [[ ${arrClone[0]} -eq ${codeClone[0]} ]]; then
        arrClone[0]=7
        codeClone[0]=7
        result="${result}ø"
        let right++

  fi

  if [[ ${arrClone[1]} -eq ${codeClone[1]} ]]; then
        arrClone[1]=7
        codeClone[1]=7
        result="${result}ø"
        let right++

  fi

  if [[ ${arrClone[2]} -eq ${codeClone[2]} ]]; then
        arrClone[2]=7
        codeClone[2]=7
        result="${result}ø"
        let right++

  fi

  if [[ ${arrClone[3]} -eq ${codeClone[3]} ]]; then
        arrClone[3]=7
        codeClone[3]=7
        result="${result}ø"
        let right++

  fi


  for (( k=0; k<${#codeClone[*]}; k++ ));
        do

                for (( j=0; j<${#arrClone[*]}; j++ ));
                do
                  if [[ ${codeClone[k]} -eq ${arrClone[j]} ]] && [[ ${codeClone[k]} -ne 7 ]]; then
                                arrClone[j]=7
                                codeClone[k]=7
                                result="${result}0"
                                break
                        fi
                done
        done


if [[ $right -eq 4 ]]; then
        echo "%%% Kód bol nájdený, gratulujem %%%"
        echo "Potrebný počet pokusov: $i"
        echo "Hľadaný kód ${code[*]}"
        exit 0
else
        echo "$nick kód nenájdený;"
        echo "Zhodnotenie pokusu $result"
        continue
fi

done

