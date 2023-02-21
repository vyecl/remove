**# Remove**



linux 删除保护



**#食用方式**

**##修改rm的指向**

在~/.bash_profile中增加以下命令

```shell 
alias rm=/tmp/remove.sh
```

保存退出，执行source ~/.bash_profile

测试删除命令

![image](https://user-images.githubusercontent.com/29686552/220291192-6c6b140a-3db4-4340-8d47-f6520fe36a54.png)

可以看到data目录并没有被删除

需要修改保护目录的话，直接修改remove.sh的savePaths参数即可。



##增加定时清理垃圾桶

~/.trash是存放被删除的文件目录，不清理的话可能导致磁盘使用率过高

![image](https://user-images.githubusercontent.com/29686552/220291228-051cc394-b716-4ea6-966b-d7b7e69c48b4.png)

```shell
0 4 * * * /usr/bin/rm -rf ~/.trash
```



