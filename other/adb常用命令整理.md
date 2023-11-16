# adb常用命令整理

### 连接到设备

```cmd
adb connect device_ip_address:port
```

### 查看设备列表

```
adb devices
```

#### 参数

- `-l`:筛选已连接设备

### 安装应用

```
adb install path_to_apk
```

#### 参数

- `-r`：重新安装现有应用，并保留其数据。
- `-t`：允许安装测试 APK。仅当您运行或调试了应用或者使用了 Android Studio 的 **Build > Build APK** 命令时，Gradle 才会生成测试 APK。如果是使用开发者预览版 SDK 构建的 APK，那么安装测试 APK 时必须在 `install` 命令中包含 `-t` 选项。
- `-i installer_package_name`：指定安装程序软件包名称。
- `--install-location location`：使用以下某个值设置安装位置：
  - `0`：使用默认安装位置。
  - `1`：在设备内部存储空间中安装。
  - `2`：在外部介质上安装。
- `-f`：在内部系统内存上安装软件包。
- `-d`：允许版本代码降级。
- `-g`：授予应用清单中列出的所有权限。
- `--fastdeploy`：通过仅更新已更改的 APK 部分来快速更新安装的软件包。
- `--incremental`：仅安装 APK 中启动应用所需的部分，同时在后台流式传输剩余数据。如要使用此功能，您必须为 APK 签名，创建一个APK 签名方案 v4 文件，并将此文件放在 APK 所在的目录中。只有部分设备支持此功能。此选项会强制`adb`使用该功能，如果该功能不受支持，则会失败，并提供有关失败原因的详细信息。附加`--wait`选项，可等到 APK 完全安装完毕后再授予对 APK 的访问权限。`--no-incremental` 可阻止 `adb` 使用此功能。

### 将文件复制到设备以及从设备复制文件

#### 从设备中复制某个文件或目录（及其子目录）

```
adb pull remote local
```

示例：

```
adb pull /sdcard/myfile.txt /opt/
```

#### 将某个文件或目录（及其子目录）复制到设备

```
adb push local remote
```

示例：

```
adb push myfile.txt /sdcard/myfile.txt
```

### adb使用shell命令

#### 发出单个shell命令

```
adb shell shell_command
```

示例：

```
adb shell ls
```

#### 命令启动交互式 shell

```
adb shell
```

如需退出交互式 shell，请按 `Control+D` 或输入 `exit`。



## 原文链接

https://developer.android.google.cn/studio/command-line/adb?hl=zh_cn



















