#!/bin/bash
# 1) applies template to valutazione.tex
# 2) calculates the weighted average values of Results

# SAFE SHELL
set -euf -o pipefail;
IFS=$'\n\t'

# VARIABLES
my_root="$PWD";

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

function containsResult {
	local my_list=${1:-};
	
}

## weightedAverage :
## applies the template file to valutazione.tex
#function weightedAverage {}

function main {
	local my_path="$my_root"/analisi/sezioni;
	applyTemplate
	local struttura=($(extractFileNames $my_path "sub\/" "}" "struttura.tex"));
	local home=($(extractFileNames $my_path "sub\/" "}" "home.tex"));
	local interne=($(extractFileNames $my_path "sub\/" "}" "interne.tex"));
	local my_path="$my_path"/sub;

	# checking if the subfile doesn't contains a Result
	if [ -z $(containsResult struttura) ]
  then
    echo "Search in the subfolder"
	else
		echo "contains Result"
	fi

	my_result=$(extractResult $my_path "Risultato" "{" "}" "${struttura[0]}");
	echo "$my_result";
	# 	else
	# fi
	#echo "$my_result";
}

main;
