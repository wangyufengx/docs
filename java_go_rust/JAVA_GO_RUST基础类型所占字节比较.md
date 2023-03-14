# JAVA、GO、RUST基础类型所占字节比较


## JAVA

JAVA中有8种基本数据类型
- 6种数字类型：
  - 4种整数型：`byte`、`short`、`int`、`long`
  - 2种浮点型：`float`、`double`
- 1种字符类型：`char`
- 1种布尔型：`boolean`

| 基本类型 | 位数  | 字节  |  默认值  |             取值范围             |
| :------: | :---: | :---: | :------: | :------------------------------: |
|   byte   |   8   |   1   |    0     |             -128~127             |
|  short   |  16   |   2   |    0     |           -32768~32767           |
|   int    |  32   |   4   |    0     | -2<sup>32</sup>~2<sup>32</sup>-1 |
|   long   |  64   |   8   |    0L    | -2<sup>64</sup>~2<sup>64</sup>-1 |
|   char   |  16   |   2   | '\u0000' |             0~65535              |
|  float   |  32   |   4   |    0f    |                                  |
|  double  |  64   |   8   |    0d    |
| boolean  |   8   |   1   |  false   |           true、false            |

**Java中每种基本类型所占存储空间大小不会随机器硬件变化而变化。**

## Go

|  基本类型  | 位数  | 字节  | 默认值 |             取值范围             |
| :--------: | :---: | :---: | :----: | :------------------------------: |
|   uint8    |   8   |   1   |   0    |              0~255               |
|   uint16   |  16   |   2   |   0    |             0~65535              |
|   uint32   |  32   |   4   |   0    |        2*2<sup>32</sup>-1        |
|   uint64   |  64   |   8   |   0    |       2*2*2<sup>64</sup>-1       |
|    int8    |   8   |   1   |   0    |             -128~127             |
|   int16    |  16   |   2   |   0    |           -32768~32767           |
|   int32    |  32   |   4   |   0    | -2<sup>32</sup>~2<sup>32</sup>-1 |
|   int64    |  64   |   8   |   0    | -2<sup>64</sup>~2<sup>64</sup>-1 |
|  float32   |  32   |   4   |   0    |                                  |
|  float64   |  64   |   8   |   0    |                                  |
| complex64  |  64   |   8   |  0+0i  |                                  |
| complex128 |  128  |  16   |  0+0i  |                                  |
|   string   |  128  |  16   |   ""   |                                  |
|    int     |       |       |   0    |                                  |
|    uint    |       |       |   0    |                                  |
|  uintptr   |  128  |  16   |   0    |                                  |
|    byte    |   8   |   1   |   0    |                                  |
|    rune    |  32   |   4   |   0    |                                  |
|    bool    |   8   |   1   | false  |          true 或 false           |


`int` 和 `uint` 类型取决于程序运行的计算机 CPU 类型： 若 CPU 是 32 位的，则这两个类型是 32 位的，同理，若 CPU 是 64 位，那么它们则是 64 位。


```golang
package main

import (
	"fmt"
	"unsafe"
)

func main() {
	var a bool
	fmt.Println("bool", unsafe.Sizeof(a))
	var b int8
	fmt.Println("int8", unsafe.Sizeof(b))
	var c rune
	fmt.Println("rune", c, unsafe.Sizeof(c))
	var d byte
	fmt.Println("byte", d, unsafe.Sizeof(d))
	var e complex64
	fmt.Println("complex64", e, unsafe.Sizeof(e))
	var f complex128
	fmt.Println("complex128", f, unsafe.Sizeof(f))
	var str string
	fmt.Println("string", str, unsafe.Sizeof(str))
	var ptr uintptr
	fmt.Println("uintptr", ptr, unsafe.Sizeof(ptr))
}
```

## Rust

基本类型
- 数值类型：
  - 有符号整数：`i8`、`i16`、`i32`、`i64`、`isize`
  - 无符号整数：`u8`、`u16`、`u32`、`u64`、`usize`
  - 浮点数：`f32`、`f64`
  - 有理数：
  - 复数：
- 字符串：
  - 字符串字面量和字符串切片`&str`
- 布尔类型：true和false
- 字符类型：表示单个Unicode字符，存储为4个字节
- 单元类型：即`()`,其唯一的值也是`()`

`isize` 和 `usize` 类型取决于程序运行的计算机 CPU 类型： 若 CPU 是 32 位的，则这两个类型是 32 位的，同理，若 CPU 是 64 位，那么它们则是 64 位。
有理数和复数不在标准库中。

| 基本类型 | 位数  | 字节  |             取值范围             |
| :------: | :---: | :---: | :------------------------------: |
|    i8    |   8   |   1   |             -128~127             |
|   i16    |  16   |   2   |           -32768~32767           |
|   i32    |  32   |   4   | -2<sup>32</sup>~2<sup>32</sup>-1 |
|   i64    |  64   |   8   | -2<sup>64</sup>~2<sup>64</sup>-1 |
|  isize   |  64   |   8   | -2<sup>64</sup>~2<sup>64</sup>-1 |
|    u8    |   8   |   1   |              -0~255              |
|   u16    |  16   |   2   |             0~65535              |
|   u32    |  32   |   4   |       0~2*2<sup>32</sup>-1       |
|   u64    |  64   |   8   |       0~2*2<sup>64</sup>-1       |
|  usize   |  64   |   8   |       0~2*2<sup>64</sup>-1       |
|   bool   |   8   |   1   |           true, false            |
|   f32    |  32   |   4   |                                  |
|   f64    |  64   |   8   |                                  |
|    ()    |   0   |   0   |              占位符              |



```rust
pub fn main() {
    println!(
        "{}, {},{}",
        std::i8::MIN,
        std::i8::MAX,
        std::mem::size_of::<i8>()
    );
    println!(
        "{}, {},{}",
        std::i16::MIN,
        std::i16::MAX,
        std::mem::size_of::<i16>()
    );
    println!(
        "{}, {}, {}",
        std::i32::MIN,
        std::i32::MAX,
        std::mem::size_of::<i32>()
    );
    println!(
        "{}, {},{}",
        std::i64::MIN,
        std::i64::MAX,
        std::mem::size_of::<i64>()
    );
    println!(
        "{}, {},{}",
        std::isize::MIN,
        std::isize::MAX,
        std::mem::size_of::<isize>()
    );
    println!(
        "{}, {},{}",
        std::u8::MIN,
        std::u8::MAX,
        std::mem::size_of::<u8>()
    );
    println!(
        "{}, {},{}",
        std::u16::MIN,
        std::u16::MAX,
        std::mem::size_of::<u16>()
    );
    println!(
        "{}, {},{}",
        std::u32::MIN,
        std::u32::MAX,
        std::mem::size_of::<u32>()
    );
    println!(
        "{}, {},{}",
        std::u64::MIN,
        std::u64::MAX,
        std::mem::size_of::<u64>()
    );
    println!(
        "{}, {},{}",
        std::usize::MIN,
        std::usize::MAX,
        std::mem::size_of::<usize>()
    );
    println!("{}", std::mem::size_of::<bool>());
    
}

```



