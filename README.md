# mac-ntfs-hello
Mac OS X平台以读写权限挂载NTFS驱动器

## 用途

Mac上插入移动硬盘默认挂载只能读，不能写

这个程序脚本将系统默认的NTFS驱动器挂载点卸掉，以rw权限重新挂载

## 用法

* 插入移动硬盘到你的Mac
* 打开Terminal.app，下载该程序，运行
`sudo ./mac-ntfs-hello.sh`
* 去/var/Volumes/里查看吧，Finder -> 前往 -> 前往文件夹 -> 输入“/var/Volumes/”
