#!/bin/zsh

# 查找sshd使用的liblzma庫路徑
path=$(otool -L $(which sshd) | grep liblzma | awk '{print $1}')

# 檢查liblzma庫是否存在
if [ -z "$path" ]; then
    echo "probably not vulnerable"
    exit 0
fi

# 檢查函數簽名
if nm "$path" | grep -q f30f1efa554889f54c89ce5389fb81e7000000804883ec28488954241848894c2410; then
#or hexdump -ve '1/1 "%.2x"'
    echo "probably vulnerable"
else
    echo "probably not vulnerable"
fi