#! /bin/bash

# Exit on error. Append "|| true" if you expect an error.
# Exit on error inside any functions or subshells.
# set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
# set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
# set -o pipefail

#colors=($(convert "./wallhaven-96w8e8_1440x900.png" -format %c -depth 6 -colors 20 histogram:info:- | sort -n | grep -o "#......" | cut -d "#" -f 2))

function order_color_hsv() {
    local colors_hsv_int=( "$@" )

    lum_list_hsv=""
    for cor_hsv in "${colors_hsv_int[@]}"; do
        lum_list_hsv="$(echo $cor_hsv | awk '{print $3}' FS=, | grep -o "[0-9.]*")-$(echo $cor_hsv | awk '{print $1}' FS=-)\n$lum_list_hsv"
    done

    return_sorted_hsv=""
    lum_array=($(echo -e $lum_list_hsv | sort -n))
    for cor_hex_hsv in "${lum_array[@]}"; do
        #echo $cor_hex_hsv
        return_sorted_hsv="$return_sorted_hsv$(echo $cor_hex_hsv | awk '{print $2}' FS=-)\n"
    done
    echo $return_sorted_hsv
}

function colorToLum2(){
  red=${1:1:2}
  green=${1:3:2} 
  blue=${1:5:2} 

  red2=$(echo "obase=10; $red" | bc)
  green2=$(echo "obase=10; $green" | bc)
  blue2=$(echo "obase=10; $blue" | bc)

  red2=$(printf '%.6f\n' $(echo "$red2/255" | bc -l))
  blue2=$(printf '%.6f\n' $(echo "$blue2/255" | bc -l))
  green2=$(printf '%.6f\n' $(echo "$green2/255" | bc -l))

  min=$red2
  max=$red2

  if (( $(echo "$min > $blue2" |bc -l) )); then
      min=$blue2
  fi

  if (( $(echo "$min > $green2" |bc -l) )); then
      min=$green2
  fi

  if (( $(echo "$max < $blue2" |bc -l) )); then
      max=$blue2
  fi

  if (( $(echo "$max < $green2" |bc -l) )); then
      max=$green2
  fi


  lum=$(printf '%.0f\n' $(echo "(($max+$min)/2)*1000000" | bc -l))

  echo $lum
}

colorToLum() {
  red=${1:1:2}
  green=${1:3:2} 
  blue=${1:5:2} 

  red2=$(echo "obase=10; $red" | bc)
  green2=$(echo "obase=10; $green" | bc)
  blue2=$(echo "obase=10; $blue" | bc)

  lum=$(echo "($red2 * 0.241) + (0.691 * $green2) + (0.68 * $blue2)" | bc)

  echo "$lum"
  #return (0.299 * $red + 0.587 * $green + 0.114 * $blue);
}

order_list() {
    colors=( "$@" )
    local count=0
    declare -A colors_lum

    for color in ${colors[@]}; do
        #colorToLum2 $color

        colors_lum[$count]="$(colorToLum2 $color)     $color\n"
        count=$(( count + 1 ))
        #./generate_img.sh "#${color}" "$count"
    done

    echo "${colors_lum[@]}"
}

black_or_white() {
    colors=$1

    index=$2
    
    local colors_abc=($(order_list $colors))
    lums=($(echo -e ${colors_lum[@]}  | sort -n | awk '{print $1}' | cut -d "#" -f 2))

    lum=${lums[$index]}
    echo $lum
    if (( $(echo "$lum  > 200000" |bc -l) )); then
        echo black
    fi
    if (( $(echo "$lum  <= 200000" |bc -l) )); then
        echo light
    fi
}

get_sorted_color() {
    local colors_lum=($(order_list $1))
    echo -e ${colors_lum[@]}  | sort -n | awk '{print $2}' | cut -d "#" -f 2
}

function get_wall_colors() {
    wallpaper=$1
    local colors12=($(convert "${wallpaper}" -scale 50x50! -depth 3 +dither -colors 15 -format "%c" histogram:info: | grep -o "#......"))
    local colors_lum12=$(order_list "${colors12[@]}")
    echo -e  ${colors_lum12}  | sort -n | awk 'NR>1 {print $2}' | cut -d "#" -f 2
}
