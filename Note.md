[TOC]

# C++ 基本觀念

☕ 喝著咖啡看更香

❌ 編譯器無法抓出的錯誤

⚓ 結論錨點

---

## class (類別)

傳說中的 _物件導向[^0]_ 基礎單位，將相同作業的項目歸納為同一類別。

- 使用需注意：

1. 名稱爲何？
2. 定義於何處？
3. 支援什麼運算？

⚓ 設計時需注意：需考慮類別的所有運算

## type (型別)

基本的內建型別，主要利用於定義電腦記體體的使用配置。

- 個人電腦基本運算單元：

```plain
1 bit = 1 位元

1 byte = 8 bits

1 word = 8 bytes = 64 bits
```

### 內建型別

![型別佔用記憶體](https://docs.microsoft.com/zh-tw/cpp/cpp/media/built-intypesizes.png?view=msvc-160)

> ☕ 型別的使用情境
>
> 1. 針對已知恆正值，使用 `無號型別`
> 2. 整數運算盡量使用 `int`
> 3. 使用 `char`、`bool` 進行值的存放，而不使用於計算中
> 4. 使用 `double` 取代 `float` 進行浮點數的計算

### variable (變數)

- 初始化

```cpp
//初始化的四種方式
int i = 0;
int i = {0};
int i{0};
int i(0);
```

> **宣告(declaration)** 與 **定義(definition)**
>
> ```cpp
> //宣告一變數，在同一文件中可以同時宣告多個相同名稱的變數
> extern int i;
>
> //宣告並定義一物件，在同一文件中僅能夠定義一次具有相同名稱的變數
> int j;
>
> // ❌ 使用 extern 前綴則會將變數宣告，無法利用初始化定義
> extern int i = 10;
> ```

- 個別編譯：
  即是將大型原始檔案分割為多個不同的原始檔，而分割的原始檔可以獨自編譯為*目的檔(.o)*[^4]，
  並利用連結器串連多個編譯後的目的檔。
  **主要目的是在於大型程式開發的維護方便性。**

- 範疇(scope)：
  指定一變數可以作用的區域，c++ 內通常以大括號 $\{\}$ 作為範疇的上下界。

### 型別轉換

特性：若給定值的型別與原先設計型別不同，型別轉換會自動發生。

```cpp
bool b = 53;           // 非0 數字會指定爲true
int i = b;             // true 也會指定爲 1
i = 3.14;              // 浮點數給予 int 型別，則會截斷小數部分
double pi = i;         // 整數給予 double 型別，則會多出小數部分
unsigned char c = -1;  // 8-bits 無號型別遇上超出範圍(0-255)值，會依據值除以256的餘數顯示
signed char c2 = 256;  // 8-bits 有號型別遇上範圍外值，會產生編譯錯誤或未定義造成的非預期錯誤
```

⚓ 衍生結論：盡量不使用*未定義*[^1]行爲。

### 無號型別的注意事項

盡量不混用 `int` 與 `unsigned` ➡ 倘若計算結果超出範圍，會出現未預期的數值

1. 針對計算部分的錯誤

```cpp
int i = 53;
unsigned int u = 10;
delta = u - i;

// 預期結果
delta = -43;

// 實際結果
delta = 4294967253;
```

2. 針對迴圈部分的錯誤

```cpp
for(unsigned u = 10; u >= 0; --u){
  cout << u << endl;
}
// 預期結果
第一次 => 10
第二次 => 9
...
第十次 => 0

// 實際結果
第一次 => 10
第二次 => 9
...
第十次 => 4294967253
...
第N 次 => 1
第N+1 次 => 4294967253
...
```

### 複合型別

- `&` **參考(reference)**

使用$&$ 符號進行呼叫，將已*初始化*[^2]的物件別名(a.k.a)的字符。

```cpp
// 宣告一物件i 進行初始化，並宣告r1 參考i 的值
int i, &r1 = i;
int i = 10; // i = 10, r1 = 10
int r1 = 20; // i = 20, r1 = 20

// 宣告為參考的名稱(r1)，無法再次宣告
int r2 = &r1; // Error：invalid conversion from 「int*」 to 「int」 [-fpermissive]
```

在 C++11 新標準中，會[利用參考將迭代物件進行取值](#reference)。

- `*` **指標(pointer)**

> <mark style="background: lightblue">
> <font color="white">
> ☕ 指標目的：迅速的標記記憶體位址，程序執行時得以降低找尋時間增加效能。
> </font>
> </mark>

![指標圖解](https://i.stack.imgur.com/AymB9.png)

- 指標的幾個提示

1. 指標為一物件，故指標可以被指定與拷貝
2. 指標的生命週期中，會指向多個物件
3. 指標不一定須要被初始化，與基礎型別相同，皆有*未定義*[^1]之值

- 指標值狀態

1. 指向一明確物件
2. 指向一明確位址
3. 指向一`null`(空值)
4. 以上皆非 ➡ `無效指標`

```cpp
// 定義一明確位址
int i = 10;
int * p = &i;

// 定義一空值指標
int *p = nullptr;
```

> ☕ 符號的多種意義
>
> - reference (參考)：常用於 [low-level const](#const)
>
> ```cpp
> int i = 40;
> int &r = i; // 獲取記憶體位址
> ```
>
> - pointer (指標)
>
> ```cpp
> int *p; // 此情境等同於 int *p = 0; ➡ 給定一記憶體位址
> ```
>
> - address-of (取址)
>
> ```cpp
> int i = 40;
> int *p;
> p = &i;
> ```
>
> - dereference (解參考)：常用於[迭代器中的元素取得](#iterator) <span id="dereference"></span>
>
> ```cpp
> int i = 40;
> int *p;
> *p = &i;
> int v = *p;
> ```

### 常用特定型別

- const：<span id="const"></span>
  使用 `const` 前綴詞進行定義，與變數不同的是宣告一常數時須進行初始化。

```cpp
const int i = 42;  // 定義一常數
const int *p = &i;  // 此指標可藉由 i 變更而變動 ➡ 稱之為low-level const
int *const p = &i;  // 此指標在初始化後則無法更動 ➡ 稱之為top-level const
```

- auto：
  常用於運算後的變數宣告，若無法準確標明輸出的型別，可以使用 `auto` 來定義輸出型別。

```cpp
// 宣告 auto 物件時，必須初始化
auto i = 30;
auto *p = &i;
auto v = get_some_value(); // 運算式宣告會在執行運算式後才寫入宣告中

auto d = 20.0, i2 = 39; // ❌ 針對多個宣告必須為相同型別
```

- decltype：
  用於取得運算式的輸出型別，而不須執行運算式。

```cpp
// 範例一：只取得運算式的型別
int f(x, y){
return x + y;
}
decltype(f()) sum = i; // 此時 sum 為 int 型別

// 範例二：值的型別
int i = 30, &r = i;
decltype(i) c; // ok!
decltype(r) cx; // ❌ 此時 cx 型別為 int& ➡ 必須進行初始化

// 範例三：多括弧誤用
int j = 39;
decltype(j) c2; // ok!
decltype((j)) cx2;
// ⬆ ❌ decltype 括弧內含有括弧則會認定為一運算式
//  而若無法找到函數的歸屬則會認定為參考
```

### 自定義資料結構

- struct：
  將資料歸類為組，其中包含**資料存取**、**運算式**、**運算子**。
  當我們定義一 `struct` 物件時，
  結構內的**資料成員**會將物件中的元素與設計時的初始化值對應
  (_即使用設計時的初始化值_)。

```cpp
struct Jobs{
	// 下列為初始化值，類似python類內的__init__
	string sex = "male";
	unsigned age = 25;
	double height = 180;
	double weight = 70;
};
Jobs sei;

// 使用 . 呼叫資料成員
int main() {
	cout << sei.age << endl; // 25
	return 0;
}
```

- 標頭檔 (.h)

1. 類的定義基於*軟體復用*[^3]的概念，需要在全局的範疇下使用。
2. 解決重複代碼的問題，基本輸出輸入(iostream)時常需要引用至檔案中執行。

下列為 `example.h` 的實作：

```cpp
#ifndef EXAMPLE_H
#define EXAMPLE_H
// ⬆ 標頭守衛(header guard)
// 若有標頭守衛，檔案 #include"examples.h" 時則不須引用 string 與 iostream

#include <string>
#include <iostream>
// ⬆ 引用了 string、iostream 兩標準庫

struct Example{
	std::string msg = "Hello World!";
};

#endif
// ⬆ #endif 以上與 #ifndef 以下的代碼，會在 #include"example.h" 時加入檔案中
```

## abstract type (抽象資料型別)

### namespace (命名空間)

與 python 的 import 語法相似，命名空間使用 `using` 開頭將庫的函數名稱引用。

- 實作的範例

```cpp
#include <iostream> // 引用庫
using std; // 引用命名空間
using std::cin; // 引用命名空間中的函數名稱

// using 的結尾必須為分號(;)
```

⚓ 標頭檔內不可使用 `using` 宣告，由於 _引用標頭檔時會將原始程式碼帶入_ ，
曾引用標頭的每個程式皆會得到相同的 `using` 宣告；
若無意使用所指程式庫名稱的程式，可能會遭遇非預期性錯誤。

### string (字串)

字元構成，可變動長度的序列。

- 字串的初始化

```cpp
string s1;
string s2 = s1;  // s2 為 s1 的拷貝
string s3 = "haiya";
string s4(10, 'c');  // 10個 c 字元的字串
```

- direct initialized (直接初始化) & copy initialized (拷貝初始化)

```cpp
// 若宣告中無等號則為 direct initialized (直接初始化)
string s1;
string s2("haiya");
string s3(10, 'c');
string s5(s2);

// 若宣告中有等號則為 copy initialized (拷貝初始化)
string s4 = s1;
string s6 = "value";
```

- 字串運算：
  字串的加法會將兩字串連接，但若其中僅有字面值不會成立。若兩字面值相加則即便有字串也無法成立。

```cpp
string s1 = "hello", s2;

string s3 = s1 + s2; // ok!
string s4 = s1 + "world"; // ok!

string s5 = "hello" + "world"; // ❌ 兩字面值無法相加
string s6 = "hello" + ", " + s1; // ❌ 兩字面值無法相加

string s7 = s1 + "world" + ", "; // ok!
```

### vector (串列)

- 串列初始化

```cpp
vector<int> v1 = {1, 2, 0};
vector<int> v2(v1); // {1, 2, 0}

vector<int> ivec;
vector<string> svec;
vector<vector<int>> vvec;

vector<string> svec{"hi"}; // {"hi"}
vector<string> svec(3); // {"", "", ""}
vector<string> svec{3, "hi"}; // {"hi", "hi", "hi"}

vector<int> ivec{3}; // {3}
vector<int> ivec(3); // {0, 0, 0}
vector<int> ivec{3, 1}; // {3, 1}
vector<int> ivec(3, 1); // {1, 1, 1}
```

- 串列運算

```cpp
// append
vector<int> v2;
for (int i; i < 100; i++){
	v2.push_back(i)
}

// get elements
vector<int> v{1, 3, 4, 6, 7, 8, 9, 10, 11};
for (auto &i: v){
	cout << i << endl;
}
int v3 = v[2]; // 與python 相同索引值由 0 開始
```

- 須避免的串列錯誤：

1. 下標運算子，僅能擷取串列中的元素。若擷取不在串列中的元素，則會出現未定義的非預期性錯誤。

```cpp
vector<int> iv; // 空的整數串列
cout << iv[0] << endl; // ❌ 空串列中無法以下標擷取元素
```

2. 下標運算子不會增加串列中的元素。
   錯誤的下標運算子設計，可能會造成 **buffer overflow (緩衝區溢位)** 。
   而*此臭蟲 (bug) 則為 PC 和其他應用程式安全性問題最常見的起因*[^5]。

```cpp
vector<int> iv;

for(decltype(iv.size()) idx; idx != 10; idx++){
	iv.push_back(idx); // 正確的加入元素至串列中
	iv[idx] = idx;     // ❌ 下標並不會增加串列中的元素
}
```

### 迭代器 (iterator)

包含著多個元素的一種型別，`vector` 與 `string` 皆為迭代器的一種，
而迭代器存在於容器`container`中，
經常使用[解參考](#dereference)對迭代器內的元素進行動作。

```cpp
// 利用 begin 與 end 取得頭尾元素(end 不為迭代器元素)
string s{"some thing"};
auto it = s.begin();
cout << *it << endl; // 利用解參考形式取得迭代器內元素
```

- 迭代器基本運算

```cpp
string s{"some thing"};
auto it = s.begin();

// 解參考取得元素
*it;

// 由底層元素取出特定成員(此例為mem)
it -> mem;
// 等同於
(*it).mem;

// 前一項、下一項
--it;
++it;

// 比較運算子
it1 == it2;
it1 != it2;

// 相當於串列型別的下標運算子式
v.begin() + n;
v.end() - n;
```

> ☕ 泛型設計概念
>
> ```cpp
> string s{"some thing"};
>
> // C++中常使用!=來限定for迴圈的範圍
> for(auto it = s.begin(); it != s.end(); ++it){
> 	cout << *it << endl;
> }
> ```
>
> 主要是由於可以使用下標運算子`[ ]`的迭代器僅有`vector`與`string`，
> 為了使邊程風格統一；故統一使用迭代器皆有的比較運算子，
> 減少下標運算子所造成編程風格不一致的問題。

### 陣列(array)

- 與`vector`相比較：

1. `array`在初始化時會決定陣列的大小
2. `array`無法使用`push_back`，將元素附加至`array`後方
3. `array`無法拷貝其它陣列來進行初始化

嚴格的初始化條件下，`array`獲得的是比`vector`更為優秀的效能。

- 初始化陣列

```cpp
// 陣列下標運算子中的陣列大小，僅可使用 const 進行初始化
const unsigned sz = 3;
int ia[sz] = {1, 2, 3};

// 預設初始化方式
int ia1[10]; // 若範疇為全域則為0，範疇為函數的情況下則為未定義之無號整數。
string sa[10]; // 字串部份皆為空字串

// 字串陣列的初始化
string sa1[3] = {"Hello", "World", "\0"}; // 結尾為 null，初始化字串陣列須多一筆元素的空間
```

- 指標與陣列： 陣列運算大部分時候是由指標進行，其包括遍歷某一陣列時。
  <span id="iterator"></span>

```cpp
// 陣列指標：指向陣列的一個元素
int arr[] = {1, 2, 3, 4};
int *p = arr; // *p = 1

// 陣列也可以使用begin 與 end，下面範例則是使用指標進行陣列的遍歷
int *pbeg = begin(arr), *pend = end(arr);
while(pbeg != pend){
	cout << *pbeg << endl;
	++pbeg;
}

// 與迭代器運算相同
int last = *(arr+3); // 等同於 arr[3]
int val = *arr + 3;  // 等同於 arr[0] + 3
```

- 下標與陣列：`array`的下標運算子與`vector`不同，
  `vector`可藉由下標運算子取得元素；
  `array`下標運算子則是取得第一筆元素後，推移下標運算子中數字的元素。

  而`array`的此特性，會造就`array`的下標運算子取得陣列範圍外的元素(像是`end`)，
  也因為此特性，在使用下標運算子時，得以使用負數來取得對應位置的元素。

```cpp
int *p = arr[2];   //取得第二筆元素
int *p = arr[-2];  //取得倒數第二筆元素
```

## 針對古老語法的代碼問題

### C-Style 字面值

此代碼可能出現在 C++標準庫尚未出現前，
使用 C 語言的字面值`\0`作為字串的結尾符號(意指讀取到它則為字串結尾)。

```cpp
char ca[] = {'C', '+', '+'};
cout << strlen(ca) << endl;  // ❌ 此字元陣列由於結尾並非為\0，會直到讀取到\0 才進行輸出。

strlen(ca); // 計算非\0 的字元陣列長度
strcmp(ca1, ca2); // 比較兩字元陣列的相等性
strcat(ca1, ca2); // 將 ca2 附加至 ca1
strcpy(ca1, ca2); // 將 ca2 拷貝至 ca1
```

而此字元陣列的比較是與`string`的比較運算子不同的方式

```cpp
// string 的比較
string s1 = "A string example";
string s2 = "A different string";
if(s1 < s2); // 結果為 false (比較字面值順序)

// 字元陣列的比較
const char ca1[] = "A string example";
const char ca2[] = "A different string";
if(ca1 < ca2); // ❌ 結果為未定義之行為
// 陣列的使用是由指標指向第一筆元素的位址，所以 ca1 與 ca2 兩者皆代表一位址；而兩位址是無法進行比較的。

// 若是單純要比較字串的情況
if(strcmp(ca1, ca2) < 0);

```

其中`string`與`vector`性質相似，而`c-style 字串`則與`array`性質相似，
先前提及`array`的初始化是無法使用`vector`與拷貝另一陣列的方式。
但相反的可利用`array`將`vector`進行初始化。

```cpp
int arr1[] = {0, 1, 2, 3, 4, 5, 6};
//                ⬇ 開始位址   ⬇ 結束位址
vector<int> ivec(begin(arr1), end(arr1)); // 等同於將 arr1 的元素拷貝至 ivec

vector<int> ivec2(arr1 + 1, arr1 + 4); // 限定範圍的拷貝:{arr1[1], arr1[2], arr1[3]}

// 相對應的也可應用至 c-style 字串與 string 間的初始化
char ca1[] = {'A', 'B', 'C', '\0'};
string s(ca1 + 1, ca1 + 3); // 'BC'

```

⚓ 雖說可以延續或混用新舊代碼，但在效率上與代碼風格上的考量，仍是建議使用 C++標準庫。

## 針對新技術需求的代碼問題

### 多維陣列

嚴格來說 C++內並無多維陣列的存在，為了較為清楚的與實際所學作結合，
將多維陣列視為 **陣列中的陣列** 是較為方便理解的。

<span id="reference"></span>

```cpp
// 多維陣列的初始化
int arr[3][4];  // 即為一 3x4 的矩陣
arr = {
  {1, 2, 3, 4},
  {2, 3, 5, 6},
  {7, 8, 9, 9}
};

// 多維陣列下標運算子
int i = arr[2][2];
cout << i << endl; // i = 9

// for 迴圈的陣列取值
size_t cnt = 0;
for(auto &row: arr){
    for(auto &col: row){
        col = cnt;
        cnt++;
    }
}
```

`for 迴圈`使用 C++11 新標準方式編寫，其中參考型別為必要宣告方式。

[^0]: 物件導向：將程式和資料封裝其中，以提高軟體的重用性、靈活性和擴充性，物件裡的程式可以存取及經常修改物件相關連的資料。
[^1]: 未定義: 宣告時未給予特定值(即未`初始化`)，容易造成非預期性錯誤。
[^2]: 初始化：宣告變數時(或之後)，給予變數 `值` 的行為。
[^3]: 軟體復用：將軟體看成是由不同功能部分的「組件」所組成的有機體，每一個組件在設計編寫時可以被設計成完成同類工作的通用工具。
[^4]: 目的檔：將高階語言編譯後產生的與電腦溝通的語言，通常為`二進位碼`的內容。
[^5]: 緩衝區溢位：向程式輸入緩衝區寫入使之溢位的內容(通常是超過緩衝區能儲存的最巨量資料量的資料量)，從而破壞程式執行、趁著中斷之際取得程式乃至系統控制權。
