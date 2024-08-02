#!/bin/bash

# 获取/root/backup目录下的所有文件夹
folders=($(ls -d /root/backup/root/backup*/))

# 检查是否存在文件夹
if [ ${#folders[@]} -eq 0 ]; then
    echo "没有找到任何文件夹在 /root/backup 目录下。"
    exit 1
fi

# 显示文件夹列表
echo "请选择一个文件夹："
for i in "${!folders[@]}"; do
    echo "$i) ${folders[$i]}"
done

# 用户选择文件夹
read -p "输入文件夹编号: " index

# 检查用户输入的编号是否有效
if [[ ! "$index" =~ ^[0-9]+$ ]] || [ "$index" -lt 0 ] || [ "$index" -ge "${#folders[@]}" ]; then
    echo "无效的编号。"
    exit 1
fi

# 选择的文件夹路径
selected_folder=${folders[$index]}

# 目标文件夹路径
target_folder="/root/ceremonyclient/.config"

# 确认操作
read -p "你确定要用 $selected_folder 的内容替换 $target_folder 的内容吗？(y/n) " confirm
if [ "$confirm" != "y" ]; then
    echo "操作已取消。"
    exit 0
fi

# 清空目标文件夹并复制内容
rm -rf "$target_folder/*"
cp -r "$selected_folder"* "$target_folder"

echo "替换完成。"

