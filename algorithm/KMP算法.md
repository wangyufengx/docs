# KMP算法

KMP算法是一种改进的字符串匹配算法，它的核心是利用匹配失败后的信息，尽量减少模式串与主串的匹配次数以达到快速匹配的目的。具体实现就是通过一个next()函数实现，函数本身包含了模式串的局部匹配信息。

### 字符串的模式匹配

> 字符串的模式匹配是一种常用的运算。所谓模式匹配,可以简单地理解为在目标(字符串)中寻找一个给定的模式(也是字符串)，返回目标和模式匹配的第一个子串的首字符位置。通常目标串比较大，而模式串则比较短小 。【百度百科】

### 朴素的模式匹配算法

> 从目标串的的第一个字符起与模式串的第一个字符比较，若相等，则继续对字符进行后续的比较，否则目标串从第二个字符起与模式串的第一个字符重新比较，直至模式串中的每个字符依次和目标串中的一个连续的字符序列相等为止，此时称为匹配成功，否则匹配失败。
>
> 若模式子串的长度是m,目标串的长度是n，这时最坏的情况是每遍比较都在最后出现不等，即每遍最多比较m次，最多比较n-m+1遍，总的比较次数最多为m(n-m+1)，因此朴素的模式匹配算法的时间复杂度为O(mn)。朴素的模式匹配算法中存在回溯，这影响到匹配算法的效率，因而朴素的模式匹配算法在实际应用中很少采用。在实际应用主要采用无回溯的匹配算法，KMP算法和BM算法均为无回溯的匹配算法。

### KMP中的next数组

求取模式串的从下标0到当前位置的最长公共前缀。

- 示例·一：

    | a    | a    | b    | b    | a    | a    | a    | c    |      |
    | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
    | 0    |      |      |      |      |      |      |      |      |
    | 0    | 1    |      |      |      |      |      |      |      |
    | 0    | 1    | 0    |      |      |      |      |      |      |
    | 0    | 1    | 0    | 0    |      |      |      |      |      |
    | 0    | 1    | 0    | 0    | 1    |      |      |      |      |
    | 0    | 1    | 0    | 0    | 1    | 2    |      |      |      |
    | 0    | 1    | 0    | 0    | 1    | 2    | 2    |      |      |
    | 0    | 1    | 0    | 0    | 1    | 2    | 2    | 0    |      |

- 示例二：

	| i    | s    | s    | i    | p    |
	| ---- | ---- | ---- | ---- | ---- |
	| 0    |      |      |      |      |
	| 0    | 0    |      |      |      |
	| 0    | 0    | 0    |      |      |
	| 0    | 0    | 0    | 1    |      |
	| 0    | 0    | 0    | 1    | 0    |
	

### KMP算法

设目标串为s，模式串为t， i、j 分别为指示s和t的指针，i、j的初值均为0。

若有 s[i ]= t[j]，则i和j分别增1；否则，i不变，j退回至j=next[j]的位置 ( 也可理解为串s不动，模式串t向右移动到s[i]与t的next[j]对齐 )；

比较s[i]和t[j]。若相等则指针各增1；否则 j 再退回到下一个j=next[j]的位置(即模式串继续向右移动 )，再比较 s[i]和t[j]。

依次类推，直到下列两种情况之一：

1)j退回到某个j=next[j]时有 s[i] = t[j]，则指针各增1，继续匹配；

2)j退回至 j=-1，此时令指针各增l，即下一次比较 s[i+1]和 t[0]。

### LeetCode刷题地址

[找出字符串中第一个匹配项的下标](https://leetcode.cn/problems/find-the-index-of-the-first-occurrence-in-a-string/description/?envType=study-plan-v2&id=top-interview-150)

> 给你两个字符串 `haystack` 和 `needle` ，请你在 `haystack` 字符串中找出 `needle` 字符串的第一个匹配项的下标（下标从 0 开始）。如果 `needle` 不是 `haystack` 的一部分，则返回 `-1` 。
>
> 
>
> **示例 1：**
>
> ```
> 输入：haystack = "sadbutsad", needle = "sad"
> 输出：0
> 解释："sad" 在下标 0 和 6 处匹配。
> 第一个匹配项的下标是 0 ，所以返回 0 。
> ```
>
> **示例 2：**
>
> ```
> 输入：haystack = "leetcode", needle = "leeto"
> 输出：-1
> 解释："leeto" 没有在 "leetcode" 中出现，所以返回 -1 。
> ```
>
>  
>
> **提示：**
>
> - `1 <= haystack.length, needle.length <= 104`
> - `haystack` 和 `needle` 仅由小写英文字符组成

### 基本实现

#### Golang实现

```golang
package main

import (
	"fmt"
)

func main() {
	s := ""
	pattern := ""
	s = "bbababaaaababbaabbbabbbaaabbbaaababbabaabbaaaaabbaaabbbbaaabaabbaababbbaabaaababbaaabbbbbbaabbbbbaaabbababaaaaabaabbbababbaababaabbaa"
	pattern = "bbabba"
	fmt.Println(kmpSearch(s, pattern))
	s = "aabaaabaaac"
	pattern = "aabaaac"
	fmt.Println(kmpSearch(s, pattern))
	s = "mississippi"
	pattern = "pi"
	fmt.Println(kmpSearch(s, pattern))
	s = "mississippi"
	pattern = "issip"
	fmt.Println(kmpSearch(s, pattern))
	s = "hello"
	pattern = "ll"
	fmt.Println(kmpSearch(s, pattern))
	s = "aaaaa"
	pattern = "bba"
	fmt.Println(kmpSearch(s, pattern))
	s = "sadbutsad"
	pattern = "sad"
	fmt.Println(kmpSearch(s, pattern))

}

func getNext(pattern string) []int {
	n := len(pattern)
	next := make([]int, n)

	j := 0
	next[0] = j

	for i := 1; i < n; i++ {
		for j > 0 && pattern[i] != pattern[j] {
			j = next[j-1]
		}
		if pattern[i] == pattern[j] {
			j++
		}
		next[i] = j
	}

	return next
}

func kmpSearch(s, pattern string) int {
	next := getNext(pattern)
	fmt.Println(next)
	l := len(pattern)
	i, j := 0, 0
	for i < len(s) && j < len(pattern) {
		if s[i] == pattern[j] {
			j++
			i++
		} else if j == 0 {
			i++
		} else {
			j = next[j-1]
		}

	}
	if j == l {
		return i - j
	}
	return -1
}
```



### 参考文献

https://www.zhihu.com/question/21923021

https://blog.csdn.net/v_july_v/article/details/7041827

https://blog.sengxian.com/algorithms/kmp

https://leetcode.cn/problems/find-the-index-of-the-first-occurrence-in-a-string/solutions/732461/dai-ma-sui-xiang-lu-kmpsuan-fa-xiang-jie-mfbs/