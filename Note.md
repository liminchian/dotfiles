[TOC]

# C++ 基本觀念

☕ 喝著咖啡看更香 ❌ 編譯器無法抓出的錯誤

---

## class (類別)

傳說中的 _物件導向[^0]_ 基礎單位，將相同作業的項目歸納為同一類別。

- 使用需注意：

  1. 名稱爲何？
  2. 定義於何處？
  3. 支援什麼運算？

- 設計時需注意：需考慮類別的所有運算

## type (型別)

基本的內建型別，主要利用於定義電腦記體體的使用配置。

- 個人電腦基本運算單元：

  ```text
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

> ☕ **宣告(declaration)** 與 **定義(definition)**
>
> ```cpp
> //宣告一變數，在同一文件中可以同時宣告多個相同名稱的變數
> extern int i;
>
> //宣告並定義一物件，在同一文件中僅能夠定義一次具有相同名稱的變數
> int j;
>
> // Error: 使用 extern 前綴則會將變數宣告，無法利用初始化定義
> extern int i = 10;
> ```

- 個別編譯

  即是將大型原始檔案分割為多個不同的原始檔，而分割的原始檔可以獨自編譯為*目的檔(.o)*[^4]，
  並利用連結器串連多個編譯後的目的檔。
  **主要目的是在於大型程式開發的維護方便性。**

- 範疇(scope)

  指定一變數可以作用的區域，c++ 內通常以大括號 $\{\}$ 作為範疇的上下界。

### 型別轉換

- 特性：若給定值的型別與原先設計型別不同，型別轉換會自動發生。

  ```cpp
  bool b = 53;
  // 非0 數字會指定爲true
  int i = b;
  // true 也會指定爲 1
  i = 3.14;
  // 浮點數給予 int 型別，則會截斷小數部分
  double pi = i;
  // 整數給予 double 型別，則會多出小數部分
  unsigned char c = -1;
  // 8-bits 無號型別遇上超出範圍(0-255)值，會依據值除以256的餘數顯示
  signed char c2 = 256;
  // 8-bits 有號型別遇上範圍外值，會產生編譯錯誤或未定義造成的非預期錯誤
  ```

  ❌ 衍生結論：盡量不使用*未定義*[^1]行爲。

### 無號型別的注意事項

- 盡量不混用 `int` 與 `unsigned` ➡ 倘若計算結果超出範圍，會出現未預期的數值

  ❌ 針對計算部分的錯誤

  ```cpp
  int i = 53;
  unsigned int u = 10;
  delta = u - i;
  // 預期結果
  delta = -43;
  // 實際結果
  delta = 4294967253;
  ```

  ❌ 針對迴圈部分的錯誤

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

- $&$ **參考(reference)**

  使用$&$ 符號進行呼叫，將已*初始化*[^2]的物件別名(a.k.a)的字符。

  ```cpp
  // 宣告一物件i 進行初始化，並宣告r1 參考i 的值
  int i, &r1 = i;
  int i = 10; // i = 10, r1 = 10
  int r1 = 20; // i = 20, r1 = 20
  // 宣告為參考的名稱(r1)，無法再次宣告
  int r2 = &r1; // Error：invalid conversion from 「int*」 to 「int」 [-fpermissive]
  ```

- $*$ **指標(pointer)**

  > ☕ 指標目的：迅速的標記記憶體位址，程序執行時得以降低找尋找尋時間增加效能

  ![指標圖解](https://i.stack.imgur.com/AymB9.png)

  指標的幾個提示

  1. 指標為一物件，故指標可以被指定與拷貝
  2. 指標的生命週期中，會指向多個物件
  3. 指標不一定須要被初始化，與基礎型別相同，皆有*未定義*[^1]之值

  指標值狀態

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
> - reference
>
> ```cpp
> int i = 40;
> int &r = i; // 獲取記憶體位址
> ```
>
> - pointer
>
> ```cpp
> int *p; // 此情境等同於 int *p = 0; ➡ 給定一記憶體位址
> ```
>
> - address-of
>
> ```cpp
> int i = 40;
> int *p;
> p = &i;
> ```
>
> - dereference
>
> ```cpp
> int i = 40;
> int *p;
> *p = i;
> int &r = *p;
> ```

### 常用特定型別

- const

  使用 `const` 前綴詞進行定義，與變數不同的是宣告一常數時須進行初始化。

  ```cpp
  const int i = 42;  // 定義一常數
  const int *p = &i;  // 此指標可藉由 i 變更而變動 ➡ 稱之為low-level const
  int *const p = &i;  // 此指標在初始化後則無法更動 ➡ 稱之為top-level const
  ```

- auto

  常用於運算後的變數宣告，若無法準確標明輸出的型別，可以使用 `auto` 來定義輸出型別。

  ```cpp
  // 宣告 auto 物件時，必須初始化
  auto i = 30;
  auto *p = &i;
  auto v = get_some_value(); // 運算式宣告會在執行運算式後才寫入宣告中

  auto d = 20.0, i2 = 39; // Error: 針對多個宣告必須為相同型別
  ```

- decltype

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
  decltype(r) cx; // Error: 此時 cx 型別為 int& ➡ 必須進行初始化

  // 範例三：多括弧誤用
  int j = 39;
  decltype(j) c2; // ok!
  decltype((j)) cx2;
  // ⬆ Error: decltype 括弧內含有括弧則會認定為一運算式
  //  而若無法找到函數的歸屬則會認定為參考
  ```

### 自定義資料結構

- struct

  將資料歸類為組，其中包含**資料存取**、**運算式**、**運算子**。
  當我們定義一 `struct` 物件時，
  結構內的**資料成員**會將物件中的元素與設計時的初始化值對應
  (_即使用設計時的初始化值_)。

  ```cpp
  struct Jobs{
    // 下列為初始化值
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

  ```cpp
  // 下列為 example.h 的實作
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

❌ 標頭檔內不可使用 `using` 宣告，由於*引用標頭檔時會將原始程式碼帶入*，
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

- direct initialized & copy initialized

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

- 字串運算

  字串的加法會將兩字串連接，但若其中僅有字面值不會成立。若兩字面值相加則即便有字串也無法成立。

  ```cpp
  string s1 = "hello", s2;

  string s3 = s1 + s2; // ok!
  string s4 = s1 + "world"; // ok!

  string s5 = "hello" + "world"; // Error: 兩字面值無法相加
  string s6 = "hello" + ", " + s1; // Error: 兩字面值無法相加

  string s7 = s1 + "world" + ", "; // ok!
  ```

### vector (向量)

[^0]: 物件導向：將程式和資料封裝其中，以提高軟體的重用性、靈活性和擴充性，物件裡的程式可以存取及經常修改物件相關連的資料。
[^1]: 未定義: 宣告時未給予特定值(即未`初始化`)，容易造成非預期性錯誤。
[^2]: 初始化：宣告變數時(或之後)，給予變數 `值` 的行為。
[^3]: 軟體復用：將軟體看成是由不同功能部分的「組件」所組成的有機體，每一個組件在設計編寫時可以被設計成完成同類工作的通用工具。
[^4]: 目的檔：將高階語言編譯後產生的與電腦溝通的語言，通常為`二進位碼`的內容。
