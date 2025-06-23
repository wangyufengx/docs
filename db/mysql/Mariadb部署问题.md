# 部署问题

## 缺少libaio.so.1包

> 系统版本 Unbuntu 24.04

**包名已从 libaio1 变更为 libaio1t64**

### 安装新版本依赖库

```bash
sudo apt install libaio1t64 -y
```

###  ‌创建符号链接

```bash

# 修复符号链接
sudo ln -s /usr/lib/x86_64-linux-gnu/libaio.so.1t64.0.2 /usr/lib/x86_64-linux-gnu/libaio.so.1
sudo ln -s /usr/lib/x86_64-linux-gnu/libncursesw.so.6.4 /usr/lib/x86_64-linux-gnu/libncurses.so.6
sudo ldconfig

```

### 验证

```bash
# 验证
ldconfig -p | grep libaio.so.1
```

## 缺少libtinfo.so.5

> 系统版本 Unbuntu 24.04

### 创建符号链接

若系统中存在高版本库（如 libtinfo.so.6），可通过软链接兼容：
```bash
# 创建软链接指向高版本库
sudo ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6 /usr/lib/x86_64-linux-gnu/libtinfo.so.5

# 刷新库缓存
sudo ldconfig
```

### 验证

```bash
ldconfig -p | grep libtinfo.so.5  # 应输出路径
```

