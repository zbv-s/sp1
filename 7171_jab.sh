#!/bin/bash

echo "Жаргалова Александра 717-1"
echo "Программа поиска файла"
echo "Программа ищет файл в текущем каталоге по заданному имени и определяет осуществлялся ли доступ к файлу после указанной даты"

echo $(pwd)
while true;
do
	read -p "Введите имя файла: " file_name
	if ! [[ $(ls -A) ]]
	then
		echo "Директория пуста"
		exit -1
	elif ls | grep -w $file_name &> /dev/null
	then
		echo "$file_name существует в дан. директории"
		while true; do
		read -p "Введите дату в формате ГГГГ-ММ-ДД: " entered_date 
		# tr - substitute - with / for the date function
		# date - checks if date is valid
		len=$(expr length "$entered_date")		
		date -d $(echo $entered_date | tr - /) > /dev/null
		ret=$?
		if [[ $len -lt 10 ]] || [ $ret -ne 0 ] 
		then
			echo "Неверная дата. Попробуйте снова."
			continue
		fi
		# atime - last read (accessed)
		accessed_date=$(ls -l --time=atime --time-style=long-iso $file_name | awk '{print $6}')
		if [[ "$accessed_date" > "$entered_date" ]]
		then
			echo "Доступ к файлу после указанной даты осуществлялся."	
			exit 0
		else
			echo "Доступ к файлу после указанной даты не осуществлялся."
			exit 120
		fi
		done
	else
		echo "Такой файл не найден. Попробуйте ещё раз."
		continue

	fi
done
