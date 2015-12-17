#!/bin/bash
# 1) applies template to valutazione.tex
# 2) calculates the weighted average values of Results

# SAFE SHELL
set -euf -o pipefail;
IFS=$'\n\t'

# VARIABLES
my_root="$PWD"

# FUNCTIONS
#========================
## applyTemplate :
## applies the template file to valutazione.tex
function applyTemplate {
	cp $my_root/analisi/utils/valutazione.template $my_root/analisi/sezioni/;
	cd $my_root/analisi/sezioni/;
	mv valutazione.template valutazione.tex;
}

## extractFileNames :
## extracts all the filenames related to the file passed
function extractFileNames {
	local my_local_path=${1:-};
	local my_left_delimiter=${2:-};
	local my_right_delimiter=${3:-};
	local my_file=${4:-};
	local my_result=$(grep "$my_left_delimiter" $(find "$my_local_path" -name "$my_file") | cut -d "/" -f 4 | cut -d "$my_right_delimiter" -f 1);
	echo "${my_result} ";
}

## extractResult :
## extracts the result from a specific file
function extractResult {
	local my_local_path=${1:-};
	local my_regexp=${2:-};
	local my_left_delimiter=${3:-};
	local my_right_delimiter=${4:-};
	local my_file=${5:-};
	local my_result=$(grep -E "$my_regexp" ${my_local_path}/${my_file} | cut -d "$my_left_delimiter" -f 2 | cut -d "$my_right_delimiter" -f 1);
	echo "${my_result}";
}

## weightedAverage :
## applies the template file to valutazione.tex
#function weightedAverage {}

function main {
	applyTemplate
	local my_root="$my_root"/analisi/sezioni;
	local my_struttura=($(extractFileNames $my_root "sub\/" "}" "struttura.tex"));
	local my_home=($(extractFileNames $my_root "sub\/" "}" "home.tex"));
	local my_interne=($(extractFileNames $my_root "sub\/" "}" "interne.tex"));
	local my_root="$my_root"/sub;
	#local my_sub=($(grep 'Risultato : \textit{' $(find "$my_root" -name "interne.tex") | cut -d "/" -f 4 | cut -d "}" -f 1));
	#DEBUG
	# for index in "${!my_array[@]}"
	# 	do
	# 	    echo "$index ${my_array[index]}";
	# 	done
	# if containsResult
	# 	then
	#echo "${my_struttura[0]}";
	my_result=$(extractResult $my_root "Risultato" "{" "}" "${my_struttura[0]}");
	echo "$my_result";
	# 	else
	# fi
	#echo "$my_result";
}

main;