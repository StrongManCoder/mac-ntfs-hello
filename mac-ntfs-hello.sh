#!/bin/sh
# 以读写权限挂载NTFS驱动器
# Mac OS X平台
# 作者: 祁冰 <qbhust@gmail.com>
# 时间: 2015年 4月29日 星期三 01时44分42秒 CST

if [ $UID -ne 0 ]; then
    echo "需要root权限才能以读写权限挂载NTFS驱动器呦！"
    echo "e.g. sudo $0"
    exit 1
fi

df -h | grep " /Volumes/" | while read line
do
    device_node=$(echo $line | cut -d ' ' -f1)
    mount_point=$(echo $line | cut -d ' ' -f9)

    diskutil_info=$(diskutil info $device_node)
    partition_type=$(echo "$diskutil_info" | grep "Partition Type:" | cut -d ':' -f2)
    read_only=$(echo "$diskutil_info" | grep "Read-Only Volume" | cut -d ':' -f2)

    if [ $partition_type == "Windows_NTFS" -a $read_only == "Yes" ]; then
        # 默认挂载位置: /var/Volumes/
        new_mount_point=$(echo $mount_point | sed 's/^\/Volumes\//\/var\/Volumes\//g')
        # 卸载旧的挂载点
        if [ -e $mount_point ]; then
            umount $mount_point
        fi
        if [ $? -ne 0 ]; then
            echo "卸载失败: $device_node     $mount_point"
            continue
        fi
        # 新建新的挂载点
        if [ ! -e $new_mount_point ]; then
            mkdir -p $new_mount_point
        fi

        # 挂载NTFS
        mount_ntfs -o rw,nobrowse $device_node $new_mount_point
        if [ $? -eq 0 ]; then
            echo "挂载成功: $device_node --> $new_mount_point"
        else
            echo "挂载失败: $device_node --> $new_mount_point"
        fi
    fi
    continue
done

echo "done!"
