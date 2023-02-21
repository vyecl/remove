#!/bin/bash


DT=`date +%Y%m%d_%H%M%S`
mkdir -p ~/.trash
RED='\E[1;31m'
RES='\E[0m'
GREEN='\E[1;32m'
savePaths=(/tmp/data /tmp/data/aa)
orgPaht=`pwd`
for i in $*
do  
    if [[ "$i" == "-rf" || "$i" == "-r" || "$i" == "-f" ]]
    then
        continue
    fi
    if [ ! -e $i ]
    then
        echo -e "${RED}$i 不存在${RES}"
        exit 1
    fi
    allowToRemove=1
    filePath=$i
    fileName=''
    isFile=0
    if [ -d $i ]
    then
           filePath=$(cd "$i";pwd)
    else
           filePath=$(cd "`dirname $i`";pwd)
        fileName=`basename $i`
        isFile=1
    fi
    #cd $filePath

    for savePath in ${savePaths[@]}
    do
        #匹配数组为目录
        if [[ $filePath == $savePath && $isFile == 0 ]]
        then
            echo 0 >/dev/null
            allowToRemove=0
        #匹配数组为文件
        elif [[ $filePath/$fileName == $savePath && $isFile == 1 ]]
        then
            allowToRemove=0
        else
            echo 1 >/dev/null
        fi 
    done

    echo ===============================
    #移除不带目录参数目录层级
    if [ $allowToRemove == 1 ]
    then
        rmFile=`basename $i`
        
        if mv $i ~/.trash/$rmFile"_"$DT
        then
            echo -e "${GREEN}$i 已经删除${RES}"
        else
            echo -e "${RED}发生错误，请检查${RES}"
            exit 1
        fi
    else
        echo -e "${RED}$i 不允许删除${RES}"
    fi
    cd $orgPaht

done

