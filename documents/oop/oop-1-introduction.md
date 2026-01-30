---
title: مقدمه‌ای بر شی‌گرایی
writers:
  - شهاب گریوانی
  - یونس کاظمی
  - آرمان حسینی
semester: بهار ۱۴۰۴
course: برنامه‌سازی پیشرفته و کارگاه
professor: دکتر مهدی قطعی
professor_2: بهنام یوسفی‌مهر
department: دانشکده ریاضی و علوم کامپیوتر
institution: دانشگاه صنعتی امیرکبیر
---
## مقدمه

توی این داکیومنت و چند داکیومنت بعدی، قراره با شی‌گرایی آشنا بشیم. شی‌گرایی یا object-oriented programming (به اختصار OOP)، یک طرز فکره برای تقسیم یک برنامهٔ بزرگ، به واحدهای کوچیک‌تری به اسم class. خیلی از چیزهایی که قبلا بهتون گفته بودیم «این‌ها رو در آینده بهتون توضیح می‌دیم» رو قراره این‌جا بهتون توضیح بدیم!

در طول خوندن این داکیومنت، اگر سوالی داشتین حتما از تدریس‌یارهاتون یا ChatGPT بپرسین، چون که این داکیومنت یکی از مهم‌ترین داکیومنت‌های شماست که توی داکیومنت‌های آینده بر پایهٔ اون به بررسی مفاهیم دیگه‌ای مثل ارث‌بری، کپسوله‌سازی و مباحث مشابه می‌پردازیم.

## تایپ‌ها در جاوا

شما تا حالا با خیلی از type ها کار کردین و با اون‌ها آشنا شدین؛ مثل `int`، `float`، `String`، `JFrame`، `ArrayList` و امثال اون‌ها. هر برنامه‌نویسی توی جاوا، می‌تونه به راحتی تایپ‌های جدید برای خودش بسازه و به همین خاطر، احتمالا تا به حال میلیون‌ها تایپ توی جاوا نوشته شده. خود شما هم توی این داک قراره یاد بگیرین که چطور می‌تونین تایپ‌های جدید بسازین.

همون‌طور که توی جلسهٔ صفر دیدین، تایپ‌های `int`، `float`، `double`، `long` و `char`، به اسم «تایپ‌های اولیه» یا primitive types شناخته می‌شن. فهرست کامل اون‌ها به شکل زیره:

| Type      | Definition                               | Approximate range or precision          |
| --------- | ---------------------------------------- | --------------------------------------- |
| `boolean` | Logical Value                            | `true` or `false`                       |
| `char`    | $16$-bit, Unicode character              | $64k$ characters                        |
| `byte`    | $8$-bit, signed integer                  | $-128$ to $127$                         |
| `short`   | $16$-bit, signed integer                 | $-32, 768$ to $32,676$                  |
| `int`     | $32$-bit, signed integer                 | $-2.1\mathrm{e}9$ to $2.1\mathrm{e}9$   |
| `long`    | $64$-bit, signed integer                 | $-9.2\mathrm{e}18$ to $9.2\mathrm{e}18$ |
| `float`   | $32$-bit, IEEE 754, floating-point value | $6-7$ significant decimal places        |
| `double`  | $64$-bit, IEEE 754                       | $15$ significant decimal places         |

به این تایپ‌ها، مثل تیکه‌های کوچیک لگو نگاه کنید که تایپ‌های پیچیده‌تر مثل `String`، `JFrame`، `ArrayList` و هر تایپ دیگه‌ای رو تشکیل می‌دن. به این تایپ‌های پیچیده‌تر، reference type می‌گن. بیاید یکی از اون‌ها رو ببینیم. کد زیر رو توی IntelliJ کپی کنید:

```java
public class Main {
    public static void main(String[] args) {  
        String str = "Hello World";  
        System.out.println(str);  
    }  
}
```

موستون رو روی `String` ببرین و کلیک راست کنید. از صفحه‌ای که باز می‌شه، منوی Go To و بعد از اون، Declaration or Usages رو انتخاب کنید:

![](images/oop-1-1.png)

صفحهٔ جدیدی براتون باز می‌شه که شامل پیاده‌سازی تایپ `String ‍ه`:

شما احتمالا هنوز کامل این کد رو نمی‌فهمید، ولی توی این کد، نشون داده می‌شه که تایپ `String` از کنار هم گذاشتن چه تایپ‌های دیگه‌ای درست شده. مثلا، توی خط ۱۶۰ همین تصویر می‌بینید که `String`، توی خودش یک آرایه از `byte` ها داره که اسمش `value` ‍ه. پایین‌تر می‌بینید که توی خودش، یه `int` به اسم `hash` داره. اگر دوست دارین، یه مقدار توی این کد بالا و پایین بشین، خیلی از تیکه‌های اون براتون غریبه‌ن و البته خیلی از بخش‌هاش هم براتون آشنا به نظر میاد.

## کلاس‌ها

کلاس‌ها، به شما اجازه می‌دن تا `type` های جدید خودتون رو درست کنید. بهترین راه یادگیری اونا، اینه که یه خورده باهاشون کار کنید، پس بیاید تا با هم یه کلاس جدید به اسم `Student` درست کنیم. کد زیر رو توی IntelliJ بنویسید:

```java
public class Main {
    public static void main(String[] args) {  
        System.out.println("Hello World!");  
    }  
}

class Student {
    public int age; 
    public String name;
    public String studentID;  
}
```

توی این کد، ما یه `class` جدید، به اسم `Student` تعریف کردیم. این کلاس، از چهار متغیر تشکیل شده:

- متغیر `age`: متغیری از جنس `int` که سن دانشجو رو نشون می‌ده.
- متغیر `grade`: متغیری از جنس `double` که معدل دانشجو رو نشون می‌ده.
- متغیر `name`: متغیرِ `String` ای که اسم دانشجو رو نشون می‌ده.
- متغیر `studentID`: متغیر `String` ای که شماره دانشجویی شخص رو نشون می‌ده.

به این متغیرها که یک کلاس رو تشکیل می‌دن، `field` های اون کلاس می‌گن. نگران کلیدواژهٔ `public` نباشید، دو جلسهٔ دیگه بهتون مفهوم اون رو توضیح می‌دیم ولی برای الآن، لازمه که اون رو قبل از همهٔ `field` های کلاس‌هاتون بذارین. حالا، با کلیدواژهٔ `new`، یه دانشجوی جدید به اسم قلی بسازید و فیلدهای اون رو مقداردهی کنید:

```java
public static void main(String[] args) {  
    Student gholi = new Student();  
  
    gholi.age = 20;  
    gholi.name = "Gholi";  
    gholi.studentID = "40413099";  
}
```

حالا، مشخصات این دانشجو رو چاپ کنید:

```java
System._out_.println("New student:");  
System._out_.println("\t+ Name: " + gholi.name);  
System._out_.println("\t+ StudentID: " + gholi.studentID);  
System._out_.println("\t+ Age: " + gholi.age);
```

کدتون رو اجرا کنید. خروجی زیر رو می‌بینید:

```
New student:  
    + Name: Gholi  
    + StudentID: 40413099  
    + Age: 20
```

می‌بینید که مشخصات قلی، به درستی روی صفحه چاپ می‌شه. تبریک! شما اولین type خودتون رو ساختین و یه متغیر هم از جنس اون درست کردین. بیاین به این type جدید، چیزهای بیشتری اضافه کنیم. به `Student`، فیلدی به اسم `grades` از جنس `ArrayList<Double>` رو اضافه کنید. این فیلد، نمرات دانشجو توی درس‌های مختلف رو نشون می‌ده:

```java
public ArrayList<Double> grades;
```

حالا، وقتی دارین فیلدهای مختلف قلی رو توی `main` مقداردهی می‌کنید، این آرایه هم با یه آرایهٔ خالی مقداردهی کنید:

```java
gholi.age = 20;  
gholi.name = "Gholi";  
gholi.studentID = "40413099";  
gholi.grades = new ArrayList<Double>();
```

بعد از این کار، چندتا نمرهٔ رندوم به قلی بدین:

```java
gholi.grades.add(20.0);  
gholi.grades.add(17.0);  
gholi.grades.add(18.0);  
gholi.grades.add(0.0);
```

حالا، اون‌جا که دارین مشخصات قلی رو چاپ می‌کنید، این نمرات هم چاپ کنید:

```java
System._out_.println("New student:");  
System._out_.println("\t+ Name: " + gholi.name);  
System._out_.println("\t+ StudentID: " + gholi.studentID);  
System._out_.println("\t+ Age: " + gholi.age);  
System._out_.print("\t+ Grades: ");
for (var grade: gholi.grades) {  
    System._out_.print(grade + ", ");  
}
```

کدتون رو اجرا کنید. خروجی کدتون باید به این شکل باشه:

```
New student:  
    + Name: Gholi  
    + StudentID: 40413099  
    + Age: 20  
    + Grades: 20.0, 17.0, 18.0, 0.0,
```

می‌خوایم به `Student`، قابلیت محاسبهٔ معدل هم بدیم. برای این کار، یه متد جدید به اسم `getAverageGrade` توی `Student` تعریف می‌کنیم:

```java
class Student {
    public int age;
    public String name;
    public String studentID;
    public ArrayList<Double> grades;

    public double getAverageGrade() { 
        if (grades.size() == 0) {
            return 0;  
        }

        double gradeSum = 0;
        for (double grade: grades) {  
            gradeSum += grade;  
        }

        return gradeSum / grades.size();  
    }  
}
```

اون‌جای کدتون که دارین مشخصات `gholi` رو چاپ می‌کنید، خطوط زیر رو اضافه کنید:

```java
System._out_.println();  
System._out_.println("\t+ Average Grade: " + gholi.getAverageGrade());
```

کدتون رو دوباره اجرا کنید. خروجی‌ای مثل زیر می‌بینید:

```
New student:  
    + Name: Gholi  
    + StudentID: 40413099  
    + Age: 20  
    + Grades: 20.0, 17.0, 18.0, 0.0,   
    + Average Grade: 13.75
```

یه لحظه به خود تابع `main` توجه کنید. می‌بینید که خود اون هم توی کلاسی به اسم `Main` ‍ه! شما توی تمام این مدت، داشتین کلاس `Main` رو تعریف می‌کردین بدون این که حتی خبر داشته باشین:

```java
public class Main {
    public static void main(String[] args) {
        // Your code here
    }  
}
```

حتی شما می‌تونید از این کلاس هم یک متغیر درست کنید:

```java
public class Main {
    public static void main(String[] args) {  
        Main a = new Main();  
    }  
}
```

البته که متغیر ساختن از جنس `Main` خیلی کار خوبی نیست! ولی جالبه که تا همین الآن هم شما از `class` ها استفاده می‌کردین، بدون این که بدونین. =)))

بیاین در ادامه، یک خورده رسمی‌تر و قدم به قدم‌تر کلاس‌ها رو بررسی کنیم.

### تعریف کلاس

تعریف کلاس، کار راحتیه، فقط از کلیدواژهٔ `class` استفاده کنید و اسم کلاستون رو بنویسید:

```java
class Student {
    // Everything an student can do
}
```

هر چیزی که بین دو براکت میاد، متعلق به اون کلاسه. کلاس‌ها، به شما اجازه می‌دن که کدهای خیلی خیلی بزرگ رو، به تیکه‌های کوچیک‌تر تقسیم کنید و با این کار، برنامه‌های منظم‌تر و بهتری داشته باشین.

یادآوری می‌کنیم که type هایی که به وسیلهٔ `class` ها تعریف می‌شه، همگی از reference typeها محسوب می‌شن.

## ایجاد Object

به متغیرهایی که از جنس یک reference type درست می‌شن، object یا instance می‌گن. توی کد زیر، قلی و ممد و سلطان همگی object هایی از جنس `Student` ان:

```java
public static void main(String[] args) {  
    Student gholi;  
    Student mamad;  
    Student soltan;  
}
```

تلاش کنید این کد رو اجرا کنید. می‌بینید که طبیعتا، بدون هیچ مشکلی اجرا می‌شه. شما توی این کد سه object جدید تعریف کردید و هیچ‌جایی اون‌ها رو مقداردهی نکردین، و جایی هم ازشون استفاده نشده.

برای این که اون‌ها رو مقداردهی کنید، از کلید‌واژهٔ new استفاده کنید:

```java
Student gholi = new Student();  
Student mamad = new Student();  
Student soltan = new Student();
```

حالا فیلدهای اون‌ها رو مقداردهی کنید:

```java
gholi.age = 21;  
gholi.name = "Gholi";  
gholi.studentID = "40513089";  
gholi.grades = new ArrayList<>();  
  
mamad.age = 25;  
mamad.name = "Mamad";  
mamad.studentID = "40513090";  
mamad.grades = new ArrayList<>();  
  
soltan.age = 103;  
soltan.name = "Soltan";  
soltan.studentID = "40513091";  
soltan.grades = new ArrayList<>();
```

اوه اوه، چقدر توی این کد، مجبور شدیم کد تکراری بزنیم! کدی که مربوط به بخش مقداردهی field های یه object ‍ه سه بار تکرار شده و همون‌طور که توی داک کلین‌کد گفتیم، این یعنی خوبه این کدها رو به یه متد تبدیل کنیم. `Constructor` ها، متدهایی هستن که دقیقا برای همین کار، به کمک ما میان.

### Constructor ها

به داخل کلاس Student، متد زیر رو اضافه کنید:

```java
public Student(int newStudentAge, String newStudentName, String newStudentID) {
    age = newStudentAge;
    name = newStudentName;
    studentID = newStudentID;

    grades = new ArrayList<>();  
}
```

می‌بینید که این متد، یه مقدار ظاهر عجیب و غریبی داره! نه نوع خروجی‌ش مشخص شده، نه جایی از کلیدواژهٔ `return` استفاده شده. به این متد، `Constructor` می‌گن و وظیفهٔ اون، مقداردهی یه object جدید از کلاس `Student` ‍ه. توی constructor بالا، ما برای ساخت یه `Student` جدید، سن، اسم و شماره دانشجویی‌ش رو ورودی گرفتیم و با استفاده از اون‌ها، فیلدهای `Student` رو برای object جدیدمون مقداردهی کردیم.

برای این که از این `constructor` استفاده کنید، کد توی `main` رو با کد زیر جایگرین کنید:

```java
public static void main(String[] args) {  
    Student gholi = new Student(21, "Gholi", "40513089");  
    Student mamad = new Student(25, "Mamad", "40513090");  
    Student soltan = new Student(103, "Soltan", "40513091");  
}
```

می‌بینید که با استفاده از یه `constructor` خوب، چقدر کد `main` کوتاه‌تر و تمیزتر شد! حالا متد زیر رو به `Student` اضافه کنید:

```java
public void printInfo() {  
    System._out_.println("Student info:");  
    System._out_.println("\t+ Name: " + name);  
    System._out_.println("\t+ StudentID: " + studentID);  
    System._out_.println("\t+ Age: " + age);  
    System._out_.print("\t+ Grades: ");
    for (var grade: grades) {  
        System._out_.print(grade + ", ");  
    }  
    System._out_.println();  
    System._out_.println("\t+ Average Grade: " + getAverageGrade());  
}
```

و توی `main`، این متد رو صدا بزنید تا اطلاعات ممد و قلی و سلطان چاپ بشه:

```java
gholi.printInfo();  
mamad.printInfo();  
soltan.printInfo();
```

خروجی‌ای مثل زیر می‌بینید:

```java
Student info:  
    + Name: Gholi  
    + StudentID: 40513089  
    + Age: 21  
    + Grades:   
    + Average Grade: 0.0  
Student info:  
    + Name: Mamad  
    + StudentID: 40513090  
    + Age: 25  
    + Grades:   
    + Average Grade: 0.0  
Student info:  
    + Name: Soltan  
    + StudentID: 40513091  
    + Age: 103  
    + Grades:   
    + Average Grade: 0.0
```

می‌بینیم که constructor ها کار کردن و کد ما هم، کوتاه و تمیزه!

### Default Constructor

تا قبل از این که ما برای کلاس `Student` کانستراکتور تعریف کرده باشیم، می‌تونستیم هنوز با استفاده از کلیدواژهٔ `new` از اون object بسازیم:

```java
Student gholi = new Student();
```

اما چطوری؟ ما که `constructor` ای برای `Student` نداشتیم! با نوشتن این کد، دقیقا چه `constructor` ای صدا زده می‌شه؟

وقتی که کلاسی `constructor` نداشته باشه، جاوا خودش یه `constructor` خالی براش می‌نویسه. این `constructor`، به شکل زیره:

```java
public Student() {}
```

توی این کانستراکتور هیچ اتفاقی نمی‌افته و هیچ field ای مقداردهی نمی‌شه. صرفاً اضافه تا شما بتونید به راحتی با استفاده از `new Student()`، آبجکت‌های جدید از این کلاس بسازید. به محض این که شما اولین `constructor` کلاس `Student` رو بنویسید، دیگه نمی‌تونید از default constructor جاوا استفاده کنید. توی کد فعلی‌تون این خط رو بنویسید و کد رو اجرا کنید:

```java
Student pedram = new Student();
```

همچین خطایی می‌گیرید:

از اون‌جایی که کلاس `student`، الآن یک `constructor` برای خودش داره، جاوا برای شما کانستراکتور دیفالت رو درست نمی‌کنه.

### کلاس‌ها با چند کانستراکتور

شما می‌تونید برای رفع مشکلی که بالاتر به اون برخورد کردین، خودتون یه کانستراکتور خالی برای `Student` بنویسید:

```java
public Student() {}
```

دقت کنید که لازم نیست کانستراکتور قبلی‌تون رو پاک کنید! هر کلاس، می‌تونه چندین constructor داشته باشه. شما می‌تونید این constructor رو در کنار کانستراکتور قبلی‌تون بنویسید و کدتون همچنان کار می‌کنه.

## field ها

متغیر های یک کلاس، یا fieldها، ویژگی‌های اون کلاس رو نشون می‌دن. شما تا الآن تعداد خوبی field برای کلاس student تعریف کردین و با اون‌ها آشنا شدین:

```java
class Student {
    public int age;
    public String name;
    public String studentID;
    public ArrayList<Double> grades;

    // Other things happening in the Student class

}
```

شما توی یک کلاس، حتی می‌تونید field هایی از جنس همون کلاس تعریف کنید! مثلاً، می‌تونید فیلد friend رو برای `Student`، از جنس خود `Student` تعریف کنید:

```java
class Student {
    // Other fields
    
    public Student friend;

    // Other things happening in the Student class

}
```

حالا، یه `student` جدید به اسم شهرام توی کدتون تعریف کنید:

```java
var shahram = new Student();
```

برای الآن، بدون این که فیلدهای شهرام رو مقداردهی کنید، سعی کنید تا اطلاعات اون رو چاپ کنید:

```java
System._out_.println("Shahram: ");  
System._out_.println("\t+ Name: " + shahram.name);  
System._out_.println("\t+ Age: " + shahram.age);  
System._out_.println("\t+ StudentID: " + shahram.studentID);
```

کدتون رو اجرا کنید، خروجی زیر رو برای شهرام می‌بینید:

```
Shahram:  
    + Name: null  
    + Age: 0  
    + StudentID: null
```

می‌بینید که علی رغم این که شما به شهرام اسم و سن و شماره دانشجویی ندادین، خود جاوا یه سری مقدار به اون‌ها داده. مقدار دیفالت جاوا برای فیلدهایی که مقداردهی نشدن، به این شکله:
- **متغیرهای عددی (مثل `int`، `float` و امثال اون‌ها):** مقدار `0` رو به خودشون می‌گیرن.
- **متغیرهای `char`:** مقدار `'\0'` رو به خودشون می‌گیرن.
- **متغیرهای `boolean`:** مقدار `false` به خودشون می‌گیرن.
- **متغیرهای از جنس reference type :** مقدار `null` به خودشون می‌گیرن.

کلیدواژه `null`، یکی از کلیدواژه‌های خاص جاواست که نشون‌دهندهٔ اینه که یک متغیر از جنس reference type، هنوز مقداری به خودش نگرفته. اگر توی کد قبلی‌مون، خط زیر رو بنویسیم:

```java
if (shahram.studentID == null) {  
    System._out_.println("Shahram does not have a studentID");  
}
```

می‌بینید که پیام زیر چاپ می‌شه:

```
Shahram does not have a studentID
```

جلوتر، با این کلید‌واژه بهتر آشنا می‌شیم.

### فیلدهای static

بعضی ویژگی‌ها، متعلق به هیچ object ای نیستن، ولی بی‌ربط به خود `class` هم نیستن. مثلا توی کلاس `Student`، ویژگیِ «تعداد کل دانشجوها» متعلق به هیچ کدوم از قلی، ممد یا سلطان نیست، ولی به کلاس `Student` ربط داره.

به این ویژگی‌ها، ویژگی‌های `static` می‌گیم. اون‌ها به خود class مرتبطن و بین تمام instance های اون class مشترکن. فیلد `static` زیر رو برای دانشجوها تعریف کنید:

```java
class Student {
    public static int totalNumberOfStudents = 0;

    // other stuff

}
```

سپس توی همهٔ constructor هایی که برای `Student` نوشتین، به مقدار اون یکی اضافه کنین. با این کار، با ساخت هر دانشجو، تعداد کل دانشجوها یکی زیاد می‌شه:

```java
public Student() {
    totalNumberOfStudents++;  
}

public Student(int newStudentAge, String newStudentName, String newStudentID) {
    age = newStudentAge;
    name = newStudentName;
    studentID = newStudentID;
    grades = new ArrayList<>();
    
    totalNumberOfStudents++;  
}
```

حالا، کد زیر رو توی main بنویسین:

```java
public static void main(String[] args) {
    var gholi = new Student();  
    System._out_.println("Current number of students: " + Student.totalNumberOfStudents);

    var mamad = new Student();  
    System._out_.println("Current number of students: " + Student.totalNumberOfStudents);

    var javad = new Student();  
    System._out_.println("Current number of students: " + Student.totalNumberOfStudents);  
}
```

همچین خروجی‌ای می‌بینید:

```
Current number of students: 1  
Current number of students: 2  
Current number of students: 3
```

می‌بینید که ما برای دسترسی به `totalNumberOfStudents`، از خود کلاس `Student` استفاده کردیم. می‌تونستید با کد زیر، از هر کدوم از instance های `student` هم به اون دسترسی پیدا کنین، ولی کار چندان خوبی نیست:

```java
System._out_.println("Current number of students: " + gholi.totalNumberOfStudents);
```

## method ها

تا اینجای کار، با کلاس‌های نسبتاً ساده ای سر و کار داشتید. اما جاهای مختلف به «رفتار کلاس» یا این ایده که کلاس ما کاری انجام بده اشاره کردیم، اینجاست که متدها وارد عمل میشن: به طور کلی هروقت بخواهید توی کدتون تصمیمی بگیرید یا عملیات منطقی انجام بدید یا کلا کاری انجام بدید، باید از متدها استفاده کنید. متدها انقدر مهمن که حتی توی اولین مواجه‌­تون با جاوا از متد `main` استفاده کردید و توی اون کدتون رو نوشتید! توی این بخش قراره دقیق­تر و کامل­تر با متدها آشنا بشید. کد زیر، یک مثال ساده از یک متده:

```java
public class Refrigerator {
    int numberOfBananas;

    public void getBananas(int n) {
        boolean enoughBananas = numberOfBananas >= n;
        if (enoughBananas) {
            numberOfBananas -= n;  
            System._out_.println(
                    "You took " + n + " bananas out of your fridge!"
            );  
        } else {  
            System._out_.println(
                    "You don't have that many bananas in your fridge!"
            );  
        }  
    }  
}
```

توی این مثال، یه کلاس `Refrigerator` داریم که یک فیلد از نوع `int` داره به نام `numberOfBananas` و یک متد داره که نوع خروجیش `void` ‍ه (خروجی نداره) و یک ورودی (argument) از نوع `int` داره. با استفاده از این متد می­تونید از توی یخچالتون موز بردارید! حالا خودتون یه متد اضافه کنید که باهاش بتونید توی یخچالتون موز بذارید. متدتون احتمالاً چیزی شبیه به این میشه:

```java
public void putBananas(int n) {    
    numberOfBananas += n;  
    System._out_.println("You put " + n + " bananas in your fridge!");  
}
```

اینجا، متدمون تعداد مشخص و ثابتی ورودی داره ( یکی )؛ اما می­تونید متدهایی تعریف کنید که تعداد ورودی­هاشون ثابت نباشه. برای این درس لازم نیست اینو یاد بگیرید، ولی اگه خودتون دوست دارید بیشتر راجع بهش بدونید، می­تونید کلمه “varargs” رو جستجو کنید یا از [این لینک](https://www.geeksforgeeks.org/variable-arguments-varargs-in-java/) راجع بهش بخونید.

### متغیرهای محلی (local variables)

متد `getBananas()` که توی مثال بخش قبل تعریف کردیم، قبل از هر چیزی چک می­کنه که توی یخچال به اندازه کافی موز وجود داشته باشه و این رو توی یک متغیر محلی به اسم `enoughBananas` ذخیره می­کنه. متغیرهای محلی موقتی هستن و فقط توی همون متدی که تعریف شدن قابل استفاده‌اند. این متغیرها وقتی متد صدا زده می‌شه، ساخته می‌شن و معمولاً بعد از تموم شدن متد از بین میرن. همچنین از بیرون متد هم نمی‌تونید بهشون دسترسی داشته باشید. برای این که خودتون ببینید، توی همین کلاس `Refrigerator` سعی کنید توی متد `putBananas` از متغیر `enoughBananas` استفاده کنید؛ همچین چیزی مثلا:

```java
public void putBananas(int n) {  
    System._out_.println(enoughBananas);
    numberOfBananas += n;  
    System._out_.println("You put " + n + " bananas in your fridge!");  
}
```

احتمالاً می­­بینید که `enoughBananas` قرمز شده. موستون رو ببرید روش؛ با همچین چیزی مواجه می­شید:

اینجا Intellij داره بهتون می­گه که نمی­تونه `enoughBananas` رو پیدا کنه! دلیلش هم همونطور که گفتیم اینه که `enoughBananas` توی متد `getBananas` تعریف شده و مربوط به همون متده و توی `putBananas` همچین متغیری وجود نداره! حالا یک متد `main` خالی توی کلاستون بنویسید و سعی کنید اجراش کنید:

```java
public class Refrigerator {
	int numberOfBananas;
    
	public void getBananas(int n) {
		boolean enoughBananas = numberOfBananas >= n;
		if (enoughBananas) {
			numberOfBananas -= n;
			System._out_.println(
			   "You took " + n + " bananas out of your fridge!"
			);  
			} else {
			System._out_.println(
				"You don't have that many bananas in your fridge!"
			);  
		}  
	}

	public void putBananas(int n) {  
		System._out_.println(enoughBananas);
		numberOfBananas += n;
		System._out_.println("You put " + n + " bananas in your fridge!");  
    }
    
    public static void main(String[] args) {  
    }  
}
```

کدتون کامپایل نمیشه، و با همچین چیزی مواجه می­شید:

اینجا جاوا نتونسته کدتون رو کامپایل کنه و بهتون میگه که نمی­تونه `enoughBananas` رو پیدا کنه. باید هشدار های Intellij رو جدی می­گرفتید!

ورودی‌های یه متد هم جزو متغیرهای محلی اون متد حساب میشن، با این تفاوت که مقدار اولیه‌شون موقعی که متد صدا زده می‌شه، از طرف کسی که متد رو فراخوانی کرده، مشخص میشه.

#### مقداردهی اولیه به متغیرهای محلی

بر خلاف فیلدهای آبجکت که اگه مقداردهیشون نکنید، جاوا براشون مقدار پیش­فرضی قرار میده، متغیر های محلی رو باید قبل از استفاده کردن مقداردهی کنید وگرنه خطای کامپایل می­گیرید:

```java
public class SomeClass {
    // instance variables always get default values if  
    // you don't initialize them
    int foo;

    void myMethod() {
    // local variables do not get default values
        int bar;
        foo += 1; // This is ok, foo has the value 0
        bar += 1; // compile-time error, bar is uninitialized
    }

    public static void main(String[] args) {  
        SomeClass something = new SomeClass();  
        something.myMethod();  
    }  
}
```

سعی کنید کد بالا رو اجرا کنید. می­بینید که کدتون حتی کامپایل هم نمیشه! باید اول `bar` رو مقداردهی کنید:

```java
bar = 99; // This is ok, we're setting bar's initial value  
bar += 1; // Now this calculation is ok
```

البته دقت کنید که لازم نیست حتماً موقع تعریف کردن یک متغیر بهش مقداردهی کنید؛ صرفاً قبل از این که ازش استفاده کنید باید مقداردهیش کنید. موضوع وقتی پیچیده­تر میشه که مقداردهی رو داخل یک شرط انجام بدید:

```java
void myMethod() {
    int bar;
    if (someCondition) {  
        bar = 42;  
    }  
    bar += 1; // Still a compile-time error, bar may not be initialized
}
```

توی این مثال، `bar` فقط در صورتی مقداردهی میشه که شرط `someCondition` برقرار باشه. یعنی همچنان ممکنه که قبل از خط `bar += 1`، متغیر `bar` مقداردهی نشده باشه. کامپایلر به شما اجازه نمیده همچین کاری بکنید و این کد هم خطای کامپایل میده.

برای حل این مشکل، چند راه حل وجود داره. می­تونید متغیر رو قبل از شرطتون مقداردهی کنید، یا استفاده ای که از متغیر می­کنید رو هم داخل شرط ببرید، یا می­تونید با توجه به برنامه­ای که دارید می­نویسید، به نحوی مطمئن بشید که متغیر قبل از مقداردهی استفاده نمیشه. برای مثال، توی کد بالا می­تونید `bar` رو هم در بلوک if و هم در بلوک `else` مقدار دهی کنید یا در صورتی که `someCondition` برقرار نبود، متد رو تموم کنید و `return` کنید:

```JAVA
void myMethod() {
    int bar;
    if (someCondition) {  
        bar = 42;  
    } else {
        return;  
    }  
    bar += 1; // This is ok!
}
```

توی این کد، یا `bar` مقداردهی میشه و بعد ازش استفاده میشه، یا کلا متد قطع میشه و `return` می­کنه. جاوا این رو ازتون می­پذیره!

حالا چرا اصلاً جاوا انقدر روی این موضوع حساسه؟ یکی از متداول ترین مشکلاتی که توی زبان هایی مثل C و C++ به وجود میاد اینه که یادتون میره متغیری رو مقداردهی کنید. توی این زبان­ها، متغیر های مقداردهی نشده، مقادیر ظاهراً رندومی اختیار می­کنند و این می­تونه دردسرساز باشه و باعث بشه دیباگ کردن برنامه­‌ها سخت تر بشه. جاوا با مجبور کردن شما به مقداردهی به متغیر ها، باعث جلوگیری از این مشکلات میشه.

### Shadowing

وقتی که یک متغیر محلی یا یک ورودی متد اسمش با اسم یکی از فیلد های کلاسمون یکی باشه، اون متغیر محلی، اصطلاحا روی اون فیلد "سایه می­اندازه" و جلوی دسترسی ما به اون فیلد رو می­گیره. شاید فکر کنید این مشکل به ندرت پیش میاد ، ولی shadowing اتفاق نسبتاً متداولیه مخصوصا وقتی که متغیرهامون اسم های متداولی داشته باشن. بیاید با یه مثال ببینیم:

```java
public class Car {
	double x;
	double y;
	
	public void moveTo(double x, double y) {  
		System._out_.println("The car is moving to " + x + ", " + y);  
	}  
}
```

اینجا ما یک کلاس به نام `Car` داریم که فعلاً فقط دو تا فیلد برای مختصات داره ( `x` و `y` ). یک متد `moveTo` براش تعریف کردیم که قراره ماشین رو برامون حرکت بده. همونطور که می­بینید، فعلاً متد `moveTo` فقط داره `x` و `y` رو چاپ می­کنه. اما این `x` و `y`، کدوم `x` و `y` هستن؟ اگر مثلاً مختصات ماشینمون الان `(3,4)` باشه و ما متد `moveTo` رو روی ماشین صدا بزنیم و بهش مقادیر (`6,7)` رو بدیم، چه چیزی چاپ میشه؟ خودتون امتحان کنید! توی همین کلاس یک متد `main` بنویسید، توش یک آبجکت جدید از `Car` بسازید، بهش `x` و `y` بدید و متد `moveTo` رو روش صدا بزنید.

همونطور که می­بینید، `moveTo` همون مقادیری رو چاپ می­کنه که بهش ورودی دادیم؛ ولی ما اگر بخواهیم ماشین رو حرکت بدیم، باید بتونیم مختصاتش رو تغییر بدیم، ولی چطور می­تونیم به فیلد های `x` و `y` که مربوط به آبجکتمون هستن دسترسی پیدا کنیم؟

#### this

هروقت نیاز دارید که صریحاً به آبجکتی که توش هستیم یا یکی از اعضای اون اشاره کنید، می­تونید از کلیدواژه `this` استفاده کنید. بیاید دوباره با مثال `moveTo` ببینیم:

```java
public class Car {
	double x;
	double y;
	double gas;
	
	public void moveTo(double x, double y) {
		double distance = Math._sqrt_(  
			(this.x - x) * (this.x - x) + (this.y - y) * (this.y - y)  
		);
		if (5 * distance > gas) {  
			System._out_.println("Not enough gas!");  
		} else {
			this.x = x;
			this.y = y;
			gas -= 5 * distance;  
			System._out_.println("The car is moving to " + x + ", " + y);  
		}  
	}  
}
```

اینجا، اول فاصله ای که قراره طی بشه رو حساب کردیم و توی متغیر محلی `distance` ریختیم. همونطور که می­بینید، برای دسترسی به `x` و `y` مربوط به آبجکت ( مختصات فعلی ماشین )، از `this.x` و `this.y` استفاده کردیم. `this` در واقع به همون آبجکتی که توش هستیم اشاره می­کنه.

اینجا یک فیلد `gas` هم به `Car` اضافه کردیم که قراره مقدار بنزین ماشین رو نشون بده. در ادامه ی متد اول مطمئن می­شیم که ماشین به اندازه کافی بنزین داره و بعد اگه بنزین داشت ماشین رو حرکت می­دیم. می­بینید که برای دسترسی به `gas` از `this` استفاده نکردیم؛ این به این دلیله که اشاره به آبجکتی که توش هستیم به طور ضمنی برقراره و `gas` و `this.gas` اینجا یک چیز هستند. مشکل جایی به وجود میاد که اسم یکی از متغیرهای محلیمون با اسم یکی از فیلدهای کلاسمون یکی باشه. اون وقت اگه بخواهیم از فیلد کلاس استفاده کنیم، باید صریحاً این رو مشخص کنیم وگرنه پیش­فرض جاوا استفاده از متغیر محلیه.

استفاده از `this` برای دسترسی به فیلدهایی که روشون سایه افتاده، روش مرسومیه و باعث می­شه که بتونیم از اسم­های متداولی که برای متغیرهای مختلف وجود داره ( مثلاً `x` و `y` برای مختصات ) استفاده کنیم و لازم نباشه هر بار دنبال یه اسم جدید برای متغیرهامون بگردیم. علاوه بر این، هر جای دیگه‌ای که بخواید به آبجکتی که داخلش هستید اشاره کنید، می‌تونید از `this` استفاده کنید. مثلاً وقتی بخواید خود همین آبجکت رو به‌عنوان ورودی به یه متد بفرستید.

### متدهای استاتیک

متدهای استاتیک (static methods)، مثل فیلدهای استاتیک، به خود کلاس تعلق دارند، نه به آبجکت­های مستقلی که ما از روی اون کلاس می­سازیم. اما این یعنی چی؟ اول از همه، متد­های استاتیک خارج از آبجکت­‌ها وجود دارند و برای صدا زدنشون لازم نیست آبجکتی وجود داشته باشه؛ شما می­تونید اسم کلاس رو بنویسید و با عملگر نقطه متد­های استاتیک رو صدا بزنید. قبلاً از متد­های استاتیک زیاد استفاده کردید، مثلاً برای مرتب کردن آرایه­ها از `Arrays.sort()` استفاده می­کردید؛ ولی اینجا آبجکتی از کلاس `Arrays` نساختید و مستقیماً متد `sort` رو روی کلاس `Arrays` صدا زدید؛ این کار رو می­تونید بکنید چون `sort` یک متد استاتیکه.

دوباره از `Arrays.sort()` استفاده کنید یا جایی که اون رو نوشتید رو بیارید، بعد روش راست کلیک کنید و گزینه Go To و بعد Declaration or Usages رو انتخاب کنید:

با همچین کدی مواجه می­شید:

همونطور که می­بینید، پشت این متد از کلیدواژه static استفاده شده. این نشون میده که این متد، یک متد استاتیکه. حالا که می­دونید متد­های استاتیک چجوری تعریف می­شن، بیاید برای کلاس Car که تا الان داشتیم یک متد استاتیک تعریف کنیم:

 ```java
public class Car {
	public static final int _SUV_ = 0;
	public static final int _SEDAN_ = 1;
	public static final int _HATCHBACK_ = 2;

	double x;
	double y;
	double gas;
	int model;

	public static String[] getCarModels() {
		return new String[]{"SUV", "SEDAN", "HATCHBACK"};  
	}
    // ...
 ```

اینجا، اول از همه یک فیلد جدید به ماشین هامون اضافه کردیم به اسم `model` که مدل ماشینمون رو نشون میده: ماشینمون می­تونه شاسی­‌بلند (`model = 0`)، سواری (`model = 1`) یا هاچ­بک (`model = 2`) باشه. برای راحتی، مدل های مختلف ماشین رو به صورت فیلد­های `static final` تعریف کردیم. حالا فرض کنید به اسم این مدل ها به صورت `String` نیاز داشته باشیم، می­تونیم مثل بالا یک متد استاتیک تعریف کنیم که این اطلاعات رو بهمون بده. دقت کنید که مدل‌های مختلف ماشین‌ها هیچ ارتباطی به یه ماشین خاص یا یه آبجکت مشخص از نوع `Car` ندارن و به‌طور کلی برای همه ماشین‌ها یکسان هستن. به همین خاطر، استفاده از فیلدها و متدهای استاتیک بهترین انتخابه.

اصلی‌ترین کاربرد متدهای استاتیک، برای تعریف متدهای کمکیه؛ متدهایی که یا مستقل از آبجکت‌ها کار می‌کنن، یا روی آبجکت‌هایی که از اون کلاس (یا حتی کلاس‌های دیگه) می‌سازیم، عملی انجام میدن و منطقشون به یک instance خاص تعلق نداره و به طور کلی عمل می­کنند.

حالا بیاید یه متد استاتیک دیگه برای Car بنویسیم:

```java
public void printModelsCount(ArrayList<Car> list) {
	int suvCount = 0;
	int sedanCount = 0;
	int hatchbackCount = 0;
	for (Car car : list) {
		switch (car.model) {
			case 0:  
				suvCount++;
				break;
			case 1:  
				sedanCount++;
				break;
			case 2:
				hatchbackCount++;
				break;  
		}  
	}
	System._out_.println("SUV: " + suvCount);
	System._out_.println("SEDAN: " + sedanCount);
	System._out_.println("HATCHBACK: " + hatchbackCount);  
}
```

این متد، یک ArrayList از ماشین ها می­گیره، تعداد مدل های مختلف ماشین ها رو می­شمره و چاپ می­کنه. همونطور که می­بینید کارکرد این متد هیچ ربطی به یک instance خاص از Car نداره و به همین دلیل استاتیک تعریفش می­کنیم.

مثال خوب دیگه­ای برای کاربرد متدهای استاتیک، کلاس `Math` هست. این کلاس قراره مجموعه­ای از عملیات­های ریاضی باشه؛ به همین دلیل تمام متد­های کلاس `Math` استاتیک هستند. البته `Math` یک مرحله فراتر میره، شما نمی­تونید اصلا آبجکتی از `Math` بسازید! اصلاً این که یک آبجکت از روی `Math` بسازید، معنی نداره و نیازی بهش نیست. این کلاس صرفاً قراره که مجموعه­ای از متدها و متغیرها برای انجام عملیات ریاضی باشه. شما چند "ریاضی" مختلف ندارید که بخواهید instance های مختلفی از `Math` بسازید!

حالا سعی کنید توی یکی از متدهای استاتیک `Car` از یکی از فیلدها یا متدهای غیر استاتیک `Car` استفاده کنید. همچین چیزی مثلا:

```java
public static String[] getCarModels() {  
    System._out_.println(model);
    return new String[]{"SUV", "SEDAN", "HATCHBACK"};  
}
```

اگر موستون رو ببرید روی `model` یا سعی کنید کلاس `Car` رو کامپایل کنید و جایی ازش استفاده کنید، با همچین خطاهایی مواجه می­شید:

همونطور که می­بینید، جاوا داره بهتون میگه که نمی­تونید یک فیلد غیر استاتیک مثل `model` رو توی یک متد استاتیک استفاده کنید. شما می­تونید متد `getCarModels` رو بدون داشتن هیچ آبجکتی صدا بزنید؛ پس این `model` ی که سعی دارید ازش استفاده کنید، مربوط به کدوم آبجکته؟ از اون جایی که متدهای استاتیک مربوط به کلاسن و از آبجکت­ها جدا هستن، طبیعیه که نمی­تونند به فیلدها و متدهای عادی که مربوط به هر آبجکت هستند دسترسی داشته باشن و فقط به متد ها و متغیر های استاتیک دسترسی دارند.

### Method overloading

قابلیت Method overloading، این قابلیته که شما چند متد رو با یک اسم، ولی با جنس و تعداد ورودی متفاوت توی یک کلاس تعریف کنید؛ وقتی که متد رو صدا می­زنید، کامپایلر با توجه به نوع ورودی، متد درست رو انتخاب می­کنه و اجرا می­کنه.

قابلیت Method overloading، بسیار قدرتمند و پرکاربرده. ایده اصلی اینه که متدهایی درست کنیم که روی ورودی های مختلف، کارهای یکسانی انجام میدن. با این کار می­تونید این توهم رو ایجاد کنید که یک متد می­تونه روی انواع مختلفی از ورودی ها کار کنه. متد `println()` که از اولین جلسه باهاش کار کردید، مثال خیلی خوبی از method overloading هست؛ شما به `println()` می­تونید هر ورودی دلخواهی بدید و اون به نحوی یک نمایش متنی از اون ورودی رو براتون چاپ می­کنه. توی زبان هایی که method overloading ندارند، کار سخت­تر میشه. مثلاً برای چاپ چیزهای مختلف باید متدهای مختلف با اسم­های مختلف تعریف کنیم و در اون صورت، این مسئولیت روی دوش شما می­افته که متد درست رو انتخاب کنید. بیاید یه مثال دیگه از method overloading ببینیم:

```java
public class Sum {
    // Overloaded sum(). This sum takes two int parameters
    public int sum(int x, int y) {
        return (x + y);  
    }

    // Overloaded sum(). This sum takes three int parameters
    public int sum(int x, int y, int z) {
        return (x + y + z);  
    }

    // Overloaded sum(). This sum takes two double  
    // parameters
    public double sum(double x, double y) {
        return (x + y);  
    }

    public static void main(String[] args) {  
        Sum s = new Sum();  
        System._out_.println(s.sum(10, 20));  
        System._out_.println(s.sum(10, 20, 30));  
        System._out_.println(s.sum(10.5, 20.5));  
    }  
}
```

همونطور که می­بینید، اینجا سه تا متد با نام یکسان `sum` داریم، ولی ورودی­هاشون فرق می­کنه. هر سه تای این متدها دارن عمل جمع کردن رو انجام میدن، ولی یکی دو تا `double` رو جمع می­کنه، یکی دو تا `int` رو جمع می­کنه و یکی 3 تا `int` رو جمع می­کنه!

به غیر از نوع ورودی­ها و تعدادشون، با تغییر دادن ترتیب ورودی­ها هم میشه متدها رو overload کرد:

```java
class Student {
    // Method 1
    public void getStudentInfo() {  
        System._out_.println("Name :" + name + " "
                + "ID :" + roll_ studentID);  
    }

    // Method 2
    public void getStudentInfo (String name) {
        // Again printing name and id of person
        System._out_.println("ID :" + studentID + " "
                + "Name :" + name);  
    }  
}
```

بعد از این که با مباحث مربوط به polymorphism و متد های override شده آشنا شدید، به method overloading دوباره برمیگردیم.

## Reference type ها

همون‌طور که تا الآن به خوبی می‌دونید، توی جاوا، type ها به دو دستهٔ primitive type و reference type تقسیم‌بندی می‌شن. primitive type ها، تایپ‌های بسیار ساده‌ای مثل `int`، `char`، `boolean` و امثال اون‌ها هستن. فهرست کامل اون‌ها توی لیست زیر اومده:

| Type      | Definition                               | Approximate range or precision          |
| --------- | ---------------------------------------- | --------------------------------------- |
| `boolean` | Logical Value                            | `true` or `false`                       |
| `char`    | $16$-bit, Unicode character              | $64k$ characters                        |
| `byte`    | $8$-bit, signed integer                  | $-128$ to $127$                         |
| `short`   | $16$-bit, signed integer                 | $-32, 768$ to $32,676$                  |
| `int`     | $32$-bit, signed integer                 | $-2.1\mathrm{e}9$ to $2.1\mathrm{e}9$   |
| `long`    | $64$-bit, signed integer                 | $-9.2\mathrm{e}18$ to $9.2\mathrm{e}18$ |
| `float`   | $32$-bit, IEEE 754, floating-point value | $6-7$ significant decimal places        |
| `double`  | $64$-bit, IEEE 754                       | $15$ significant decimal places         |

هر تایپ دیگه‌ای توی جاوا، reference typeئه. `String`، `JFrame`، `ArrayList` و حتی تایپ‌هایی مثل `Car` و `Student` که تا این‌جای کار تعریف کردیم، همگی reference type ان. هر reference type ای با یک کلاس تعریف شده.

### تفاوت reference typeها و primitive typeها

همون‌طور که می‌دونید، تمام متغیرهای برنامه‌های شما، توی حافظهٔ خاصی به اسم RAM ذخیره می‌شن. سیستم عامل، متغیرهای شما رو توی دو بخش متفاوتی از این حافظه، به اسم stack و heap نگه می‌داره. با این دو توی درس‌های ساختمان داده و سیستم عامل بیشتر آشنا می‌شین، ولی برای الآن، بدونید که حافظهٔ stack، از heap سریع‌تره، ولی در مقابل یه خورده کم‌حجم‌تره. [^1] 

متغیرهایی که از جنس primitive type تعریف می‌کنین، حجم کمی دارن و بین `1` با `8` بایت از مموری رو اشغال می‌کنن. به همین خاطر، جاوا اون‌ها رو توی stack نگه می‌داره تا از سرعت بهتر stack استفاده بکنه و همزمان، stack سریع پر نشه. از طرفی، ممکنه object هایی که توی برنامه‌تون تعریف می‌کنین -و همیشه از جنس reference type ان-، حجم بسیار بیشتری داشته باشن. جاوا، اطلاعات این object ها رو توی heap ذخیره می‌کنه و توی stack، صرفا یه اشاره‌گر (pointer) به اون‌ها نگه می‌داره.

مثلا، برنامهٔ زیر رو در نظر بگیرین:

```java
public class Main {
    public static void main(String[] args) {
        int radius = 5;
        double pi = 3.14;  
        Student changiz = new Student(50, "Changiz", "112");  
    }  
}
```

اگر مموری رو حین اجرای این برنامه ببینیم، همچین شکلی داره:

اگر مقدار خود متغیر چنگیز رو چاپ کنید:

```java
System._out_.println(changiz);
```

همچین خروجی‌ای می‌بینید:

```text
Student@6acbcfc0
```

متغیر `changiz`، در واقع صرفا یک pointer یا reference به یه آبجکت از جنس Student ‍ه و نه چیزی بیشتر. با استفاده از اپراتور نقطه `(.)`، می‌تونید به field ها و method های این آبجکت دسترسی داشته باشین.

این اتفاق، یه ساید افکت جالب روی کدهای شما داره. فرض کنید، یه دانشجوی دیگه به اسم بنگیز درست کردیم و اون رو مساوی با چنگیز قرار دادیم:

```java
Student bangiz = changiz;
```

حالا، بنگیز و چنگیز هر دو به یک نقطه از heap اشاره می‌کنن:

حالا اگر شما، شماره دانشجویی چنگیز رو عوض کنید:

```java
changiz.studentID = "40113";
```

و بعد، شماره دانشجویی چنگیز و بنگیز رو چاپ کنید:

```java
System._out_.println("Changiz studentID: " + changiz.studentID);  
System._out_.println("Bangiz studentID: " + bangiz.studentID);
```

می‌بینید که شماره دانشجویی بنگیز هم عوض شده!

```java
Changiz studentID: 40113  
Bangiz studentID: 40113
```

عجیبه، نه؟ راستش نه اونقدران. اگر به مموری نگاه کنید، بعد از عوض شدن شماره دانشجویی چنگیز، همچین وضعیتی داره:

چنگیز، شماره دانشجویی آبجکتی که به اون اشاره می‌کرده رو تغییر داده. دست بر قضا، بنگیز هم به همین آبجکت اشاره می‌کرده و در نتیجه، شماره دانشجویی بنگیز هم واقعا عوض شده.

یه جای دیگه هم اتفاق مشابه‌ای می‌افته. برای دیدن اون، متد زیر رو به کدتون اضافه کنین:

```java
public static void resetID(Student student) {  
    student.studentID = "00000000";  
}
```

این متد، یه `Student` رو ورودی می‌گیره، و شماره دانشجویی‌ش رو دستکاری می‌کنه. حالا با استفاده از کد زیر، چنگیز رو به این متد ورودی بدین و بعدش، شماره دانشجویی چنگیز و بنگیز رو چاپ کنید:

```java
resetID(changiz);  
  
System._out_.println("Changiz studentID: " + changiz.studentID);  
System._out_.println("Bangiz studentID: " + bangiz.studentID);
```

خروجی، به همچین شکلیه:

```text
Changiz studentID: 00000000  
Bangiz studentID: 00000000
```

شاید بتونید حدس بزنید که این‌جا چی شده. با ورودی دادن چنگیز به `resetID`، در واقع شما اشاره‌گرتون به heap رو به این تابع ورودی دادین. پس متغیر `student` توی `resetID` و `changiz` و `bangiz`، هر سه به یک نقطه از heap اشاره می‌کنن و مثل قبل، با تغییر فیلدهای یکی از اون‌ها، هر سه تغییر می‌کنن. به این نوع ورودی دادن به توابع، اصطلاحا passing by reference می‌گن.

مشابه هیچ کدوم از این اتفاق‌ها، برای primitive type ها نمی‌افته. چون همیشه توی stack نگه‌داری می‌شن و پوینتری به heap برای اون‌ها نگه‌داری نمی‌شه.

[^1]: اگر راستش رو بخواید، در واقعیت ممکنه این‌جور نباشه. Stack و Heap به خودی خود از دیگری سریع‌تر یا حجیم‌تر نیستن و ما این‌جا داریم خیلی (خیلی خیلی خیلی) ساده‌سازی می‌کنیم. توی درس‌های بعدی‌تون بهتر می‌فهمید که تفاوت این دو با هم چیه. برای الآن، فرض کنید این چیزی که گفتیم کاملا درسته.

### کلاس‌های wrapper برای primitive typeها

هر کدوم از primitive type ها، یه تایپ مشابه از جنس reference type هم دارن. این تایپ‌ها، توی جدول زیر اومدن:


| Primitive | Wrapper               |
| --------- | --------------------- |
| `void`    | `java.long.Void`      |
| `boolean` | `java.lang.Boolean`   |
| `char`    | `java.lang.Character` |
| `byte`    | `java.lang.Byte`      |
| `short`   | `java.lang.Short`     |
| `int`     | `java.lang.Integer`   |
| `long`    | `java.lang.Long`      |
| `float`   | `java.lang.Float`     |
| `double`  | `java.lang.Double`    |


شما لازم نیست خیلی نگران این تایپ‌های جدید باشین، ولی بدونین که وجود دارن. وقتی که یک آرایه از intها تعریف می‌کنین، از اون‌ها استفاده می‌کنین:

```java
var arr = new ArrayList<Integer>();
```

اگر دقت کنید، به جای این که بین دو براکت از `int` استفاده کنید، از `Integer` استفاده کردین. اگر روی اون کلیک راست کنید و از Go To به Declaration and Usages برین، می‌تونید ببینید که پشت اون یک کلاسه:

این کلاس، معادل reference type گونه‌ای برای `int` ‍ه، و وقتی با کلاس‌ها سر و کار دارین ازش استفاده می‌شه. اگر خواستین بیشتر راجع به اون بدونین، به [این داکیومنت](https://docs.oracle.com/javase/tutorial/java/data/autoboxing.html) رجوع کنین.

## Garbage Collection

قبل اینکه بریم سراغ Garbage Collection بیاین اول مفهوم نشت حافظه (Memory Leak) رو بررسی کنیم.

### آشنایی با Memory Leak

توی بعضی از زبان‌های برنامه‌نویسی (مثل C و C++) مسئولیت «آزاد کردن» حافظه بر عهده خود برنامه‌نویس هست. این یعنی شما باید هر وقت که دیگه به یک شی نیاز نداشتین، خودتون اون حافظه رو آزاد کنین. مثلاً اگه با استفاده از تابع `malloc` یه مقداری از حافظه رو allocate کردین، وقتی که دیگه این حافظه رو نیاز نداشتین، باید خودتون با استفاده از تابع `free` اون حافظه رو آزاد کنین. بیاین یه مثال ببینیم:

```c
#include <stdlib.h>

int main() {
    // Allocate memory dynamically
    int *ptr = (int *)malloc(sizeof(int) * 5);  // Allocating memory for 5 integers  
  
    // Use the allocated memory
    for (int i = 0; i < 5; i++) {  
        ptr[i] = i + 1;  
    }
    /*  
     * Doing some stuff with these numbers  
     */  
  
    // Forgetting to free the allocated memory causes a Memory Leak  
    // free(ptr); // If we uncomment this line, the Memory Leak will be avoided.

    return 0;  
}
```

توی این برنامه که به زبان C (!) نوشته شده، اول به اندازه 5 متغیر `int` حافظه اشغال می‌کنیم. اشاره‌گر `ptr` به اولین خونه از این `20` بایت [^2]  اشاره می‌کنه. حالا میایم 5 تا عدد صحیح رو در حافظه ذخیره می‌کنیم. فرض کنین با این اعداد یه سری کار انجام دادیم و الان کارمون باهاشون تموم شده. اما بعد اینکه کارمون تموم شد، فراموش کردیم که این 20 بایت حافظه رو آزاد کنیم! در حقیقت باید با صدا زدن تابع free اعلام می‌کردیم که ما دیگه به این 20 بایت نیازی نداریم و در نتیجه این حافظه آزاد میشد.

اگه آزادش نکنین چی میشه؟ در این صورت اون حافظه همچنان در اختیار برنامه قرار داره و به اصطلاح Memory Leak رخ می‌ده. این یعنی حافظه‌ای که دیگه به کار نمیاد، همچنان در اختیار برنامه باقی می‌مونه و هیچوقت آزاد نمی‌شه. این موضوع می‌تونه باعث بشه که برنامه به مرور زمان حافظه زیادی مصرف کنه و سیستم دچار مشکلاتی مثل کندی عملکرد یا حتی crash بشه.

[^2]: با این فرض که هر متغیر از جنس `int`، حافظه‌ای به اندازه `4` بایت رو اشغال کنه.

### Garbage Collection: یه راه‌حل خوب

وقتی داریم راجع به Garbage Collection در جاوا صحبت می‌کنیم، به زبان ساده یعنی جاوا خودش می‌ره و حافظه‌ای که دیگه به هیچ‌کار نمی‌آد رو آزاد می‌کنه. مثلا وقتی که شما یه شی رو توی برنامه می‌سازید و دیگه به اون نیاز ندارین، جاوا خود به خود این شی رو پاک می‌کنه. شما اصلا نیازی نیست که خودتون حافظه رو آزاد کنین، همه چی به صورت خودکار اتفاق می‌افته!

شاید بپرسین که چطور این کار انجام میشه؟ خوب، جاوا از یه سری الگوریتم‌ها برای این کار استفاده می‌کنه. ولی ما اون‌ها رو اینجا بررسی نمی‌کنیم. توی این [ویدیوی یوتیوب](https://youtu.be/Mlbyft_MFYM?si=jhAdnlq12houCo1F) و این [داک اوراکل](https://docs.oracle.com/en/java/javase/21/gctuning/introduction-garbage-collection-tuning.html) می‌تونین مطالب بیشتری در رابطه با این موضوع ببینین.

به طور کلی این ویژگی جاوا باعث میشه که شما تمرکز بیشتری روی منطق برنامه‌نویسی داشته باشین و دیگه نگران مدیریت دستی حافظه نباشین.

حالا تو کد زیر، می‌تونین رفتار Garbage Collector رو در ارتباط با آبجکت `cuteCat` رو بگین؟

```java
Cat cuteCat = new Cat("Cat 1");  
cuteCat = new Cat("Cat 2");
```

شکل زیر میتونه نمایش خوبی از اتفاقات باشه. در اینجا `cuteCat` به جایی از حافظه اشاره [^3]  می‌کنه که توی اون یه آبجکت از جنس `Cat` (که فیلد اسمش `Cat1` هست) ذخیره شده. توی خط بعدی `cuteCat` به جایی از حافظه اشاره می‌کنه که توی اون یه آبجکت از جنس `Cat` (که فیلد اسمش Cat2 هست) ذخیره شده. اما الان هیچ فلشی به `Cat1` وارد نمیشه، پس Garbage Collector اون را آزاد می‌کنه.

[^3]: دقت کنین که لفظ «اشاره کردن» در جاوا خیلی درست نیست. به خاطر اینکه ما در جاوا `pointer` نداریم و مدیریت حافظه رو خود جاوا برامون انجام میده. در جاوا حتی دسترسی مستقیم به حافظه هم نداریم (برخلاف `C`). اما برای مشابهت با زبان `C`، در اینجا هم از لفظ اشاره کردن استفاده کردیم. در جاوا به متغیر هایی مثل `cuteCat`، میگن reference variable.
### Garbage Collector حواسش هست!

Garbage Collector آبجکت هایی که هنوز بهشون نیاز داریم (بهشون رفرنس داریم) رو پاک نمی‌کنه. مثلا بیاین کد زیر رو ببینیم:

```java
class Duck {  
    String name;  
}

public class Main {
    public static void main(String[] args) {  
        Duck duck = _createDuck_(); // a duck object will be created
        System._out_.println(duck.name);  
    }


    public static Duck createDuck() {  
        Duck localDuck = new Duck();  
        localDuck.name = "A White Duck";
        return localDuck;  
    }  
}
```

توی این کد اومدیم اول یه کلاس خیلی ساده به اسم `Duck` تعریف کردیم. یه متد هم به اسم `createDuck` تعریف کردیم که اول میاد یه آبجکت از جنس `Duck` میسازه، بعد متغیر `name` رو توی این آبجکت مقداردهی می‌کنه و در نهایت این آبجکت رو به عنوان خروجی متد بر میگردونه. بعد توی متد `main`، سعی می‌کنیم به متغیر `name` توی این آبجکت دسترسی داشته باشیم.

اما نکته کجاست؟ احتمالا توی درس های قبلیتون خوندین که _«متغیر هایی که توی یک تابع تعریف میشن عمرشون به اندازه اجرای همون تابع هست و پس از اتمام اجرای تابع، اون متغیر هم از بین میره»._ پس شاید انتظار داشته باشیم Garbage Collector آبجکت Duck رو از بین ببره! اما واقعیت اینه که Garbage Collector _حواسش هست_ که ما کدوم آبجکت ها رو هنوز نیاز داریم و نباید پاکشون کنه. اینجا هم ما چون `Duck` رو به عنوان خروجی برگردوندیم، یعنی لابد نیازش داریم، پس پاکش نمی‌کنه.

خروجی کد بالا به صورت زیر هست.

```text
A White Duck
```

### یک نکته در مورد کلاس‌ها

در هر فایل جاوا (فایل با پسوند `.java`)، متونیم حداکثر یک کلاس `public` داشته باشیم و همچنین اسم این کلاس `public` باید حتما با اسم فایل یکی باشه. مثال درست زیر رو ببینین:

```java
// MyClass.java
public class MyClass {
    public void sayHello() {  
        System._out_.println("Hello, Java!");  
    }  
}
```

کد‌های زیر نادرست هستن:

```java
// MyFile.java
public class MyClass { } // Error! The class name does not match the file name.
```

```java
// MyFile.java
public class MyClass { }

public class AnotherClass { } // Error! Only one public class is allowed.
```

## Packages

### نیاز به منظم کردن فایل‌ها

در برنامه‌های که توی جاوا می نویسیم، همیشه از کلاس ها یا اینترفیس ها [^4]  استفاده می کنیم. مثلا برنامه ساده زیر که در کلاس Sample نوشته شده رو ببینین:

```java
public class Sample {
    public static void main(String[] args) {  
        System._out_.println("Hello World!");  
    }  
}
```

ولی برنامه‌های پیچیده تر ممکنه از صد ها کلاس تشکیل شده باشن. اگه همه این کلاس ها رو بدون هیچ نظمی کنار هم قرار بدیم باعث میشه برنامه‌مون ناخوانا باشه و خودمون هم گیج می شیم.

احتمالا یکی از اولین چیز هایی که برای منظم کردن فایل ها به ذهنمون میرسه استفاده از پوشه هاست. و این دقیقا همون امکانیه که جاوا برای منظم کردن کلاس های برنامه‌مون واسه ما فراهم کرده: ایجاد `package` های مختلف.

[^4]: با اینترفیس‌ها بعداً آشنا می‌شید. فعلاً کاری بهشون نداریم.

### پکیج چیه؟

پکیج‌ها در جاوا مثل پوشه‌هایی هستن که کدهای برنامه‌نویسی (شامل کلاس ها و اینترفیس ها) رو داخلشون قرار می‌دیم تا همه چیز منظم و مرتب باشه. وقتی که برنامه‌های پیچیده‌تر رو می‌نویسیم، تعداد کلاس ها زیاد می‌شه و اینجاست که پکیج‌ها به کمکمون میاد تا بتونیم این کلاس‌ها رو دسته‌بندی کنیم.

### چطور یک پکیج ایجاد کنیم؟

اول یه پروژه به اسم `PackageDemo` ایجاد کنین. حالا روی پوشه `src` راست کلیک کنین و از نوار New، گزینه Package رو انتخاب کنین.

حالا اسم پکیج رو وارد کنین. مثلا در اینجا `edu.ap.animals` :

به همین شکل پکیج `edu.ap.vehicles` رو هم بسازین.

الان باید چیزی شبیه به تصویر زیر رو توی پوشه `src` داشته باشین:

حالا بیاین چند تا کلاس به هر کدوم از این پکیج‌ها اضافه کنیم. مثلا کلاس های `Dog` و `Cat` رو به پکیج `animals` و کلاس های `Bike` و `Car` رو به پکیج `vehicles` اضافه کنیم. در نهایت باید چیزی شبیه به تصویر زیر رو داشته باشین:

پکیج‌هامون رو ساختیم! حالا ببینیم واقعا چه فایل هایی ایجاد شده. اگه از توی explorer به محل ایجاد پروژه‌تون برین و به ترتیب وارد پوشه های `src`، `edu`، `ap` و `animals` بشین چیزی شبیه به این ها می بینین:

پس دیدیم که وقتی ما داریم یه پکیج تعریف می‌کنیم، واقعا پوشه ایجاد می‌شه!

در نهایت پکیج `edu.ds` شامل کلاس `Stack` رو درست کنین. در نهایت باید چیزی شبیه به این ببینین:

اما الان بریم کد Cat.java رو ببینیم:

```java
package edu.ap.animals;

public class Cat {  
}
```

همونطور که میبینین، عبارت `package edu.ap.animals;` به ابتدای این کد اضافه شده. این خط رو نباید پاک کنین، چون اون موقع جاوا متوجه نمیشه `Cat` متعلق به کدوم پکیجه و خطای کامپایل میخورین.

### نام گذاری متداول پکیج‌ها (Naming Conventions)

1.  پکیج‌ها همواره با حروف کوچک نامگذاری میشن. مثلا `java.util`
2.  از کلمات رزرو شده جاوا استفاده نکنین. کلماتی مثل `class`، `public`، `static` و...
3.  از underscore (`_`)، dash (`-`)، space و کاراکتر های خاص (مثل `@`،`$`،`&`) استفاده نکنین. در نامگذاری پکیج‌ها فقط مجازیم از dot (`.`) استفاده کنیم.
    1.  نادرست: `com.github.my-awesome-project`
    2.  درست: `com.github.myawesomeproject`
4.  یک قاعده دیگه در نامگذاری پکیج‌ها، reverse domain name هست (برعکس نوشتن نام دامنه). اگه یه پروژه ای متعلق به شرکت یا سازمانی هست که دامنه (domain) خودش رو داره، اون دامنه رو به شکل برعکس می‌نویسیم. مثلا شرکت Mozilla (که نام دامنه‌ش `mozilla.org` هست) چند تا پکیج توی جاوا داره. یکی از این پکیج‌ها اسمش `org.mozilla.javascript` هست (البته این قاعده در مورد پکیج‌های استاندارد خود جاوا صدق نمی‌کنه).

### کلیدواژهImport

#### یک مثال عملی

بیاین توی کلاس `Bike` یه آبجکت از کلاس `Cat` بسازیم (دقت کنین که این دو کلاس متعلق به دو پکیج متفاوت هستن):

```java
package edu.ap.vehicles;

public class Bike {
    public static void main(String[] args) {  
        Cat cat = new Cat();  
    }  
}
```

اگه سعی کنیم این کد رو اجرا کنیم، موقع کامپایل به مشکل می‌خوریم:

```bash
java: cannot find symbol  
symbol:   class Cat  
  location: class edu.ap.vehicles.Bike
```

مشکل چیه؟ جاوا نمیتونه کلاسی به اسم `Cat` رو پیدا کنه! دلیلش هم اینه که جاوا فقط کلاس هایی رو میبینه که توی همین پکیج هستن.

پس باید یجوری کلاس `Cat` رو به کدمون اضافه کنیم. کلیدواژه `import` دقیقا برای همین کار هست. با استفاده از این کلیدواژه، ما به جاوا اعلام می‌کنیم که می‌خوایم این کلاس رو به کدمون اضافه کنیم:

```java
package edu.ap.vehicles;
import edu.ap.animals.Cat;

public class Bike {
    public static void main(String[] args) {  
        Cat cat = new Cat();  
    }  
}
```

الان دیگه کدمون کار می‌کنه و می‌تونیم یه آبجکت از کلاس `Cat` بسازیم.

### در اهمیت پکیج‌ها

یکی از بزرگترین مزایای جاوا داشتن کتابخانه (library) ها بسیار متنوع و کاربردی هست.

میخواین یه PDF درست کنین؟ کتابخانه مربوط به اون رو `import` کنین. میخواین با دیتابیس کار کنین؟ کتابخانه مربوط بهش رو `import` کنین ...

مثلا یکی از پکیج‌های مهم جاوا، `java.lang` هست. این پکیج شامل کلاس های پایه ای مثل `System`، `Integer`، `Math` و `String` هست.

تو شکل زیر میتونین یه نمای کلی از پکیج‌های جاوا ببینین:

### import کردن کل پکیج

شما میتونین تمام کلاس های موجود توی یک پکیج رو یکجا `import` کنین. این کار رو با عبارت `*` میتونین انجام بدین. مثلا کد زیر تمام کلاس های موجود در پکیج `edu.ap.animals` رو `import` می‌کنه.

```java
import edu.ap.animals.*;
```

این قابلیت کار ما رو خیلی اوقات آسون می‌کنه. ولی انجام این کار همیشه هم مناسب نیست. `import` کردن دقیق کلاس ها علاوه بر خوانایی بیشتر کدمون، کمی هم زمان کامپایل‌مون رو کمتر می‌کنه.

دقت کنین که پکیج‌ها خودشون میتونن شامل پکیج باشن؛ همونطوری که پوشه ها میتونن داخل خودشون پوشه داشته باشن. اما عبارت `*` فقط کلاس های متعلق به پکیج رو `import` می‌کنه و نه sub-package ها رو (import کردن recursive نداریم).

مثلا در نظر بگیرین که پکیج `java.awt` یک کتابخونه استاندارد جاوا هست که شامل sub-package مثل `java.awt.event` هست. کلاس `Color` متعلق به پکیج `java.awt` و کلاس `ActionEvent` متعلق به زیرپکیج `java.awt.event` هست.

حالا شما اگه به هر دوی این کلاس ها نیاز دارین باید هر کدوم رو جدا `import` کنین. کد زیر اشتباه هست:

```java
import java.awt.*;
```

دلیل اشتباه بودنش هم اینه که در نتیجه این کد کلاس `Color`، ایمپورت میشه ولی کلاس `ActionEvent` نه.

کد زیر درست هست:

```java
import java.awt.Color;
import java.awt.event.ActionEvent;
```

#### دو مثال دیگه: مرور خاطرات

##### `java.util.Scanner`

احتمالا یکی از اولین برنامه‌هایی که توی جاوا نوشتین گرفتن ورودی از کاربر بوده. مثلا کد ساده زیر رو ببینین:

```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        int x;  
        Scanner scanner = new Scanner(System._in_);  
        x = scanner.nextInt();  
    }  
}
```

شاید قبلا براتون سوال شده باشه که اون `import` توی خط اول چکار می‌کنه. خوب الان احتمالا می‌تونیم به راحتی به این سوال جواب بدیم. در واقع کلاس `Scanner` متعلق به پکیج `java.util` هست و ما چون میخوایم از این کلاس توی کدمون استفاده کنیم، اون رو `import` کردیم.

حتی اگه وارد سورس کد این کلاس بشین، عبارت زیر رو در خطوط ابتدایی می بینین:

```java
package java.util;
```

##### `javax.swing.JFrame`

در صورتی که با گرافیک کار کرده باشید، می‌دونید وقتی میخواستیم یه `frame` ایجاد کنیم، از کد زیر استفاده می کردیم:

```java
import javax.swing.JFrame;

public class Main {
    public static void main(String[] args) {  
        JFrame jFrame = new JFrame();  
    }  
}
```

همونطور که می‌تونیم حدس بزنیم، کلاس `JFrame` متعلق به پکیج `javax.swing` هست و چون ما میخوایم از این کلاس توی کدمون استفاده کنیم، اون رو `import` کردیم.

می تونیم خیلی راحت این رو بررسی کنیم. هر موقع خواستین کد یک کلاس رو ببین (سورس کد جاوا)، می تونین روی اسم اون کلاس راست کلیک کنین و از نوار Go To قسمت Declaration or Usages رو انتخاب کنین. میبینین که به سورس کد اون کلاس منتقل میشین.

اگه این کار رو انجام بدین، توی فایل `JFrame.java` که بهش منتقل شدین، توی خطوط ابتدایی عبارت `package javax.swing;` رو میبینین.

### چند نکته در مورد پکیج‌ها

#### هر کلاس دقیقا به یک پکیج تعلق داره

هر کلاس دقیقا به یک پکیج تعلق داره. اگه کلاسی که نوشتین رو توی یه پکیج قرار ندادین، به صورت پیش‌فرض این کلاس متعلق به default package خواهد بود. مثلا کلاس زیر رو در نظر بگیرین:

```java
public class Student {
    private String name;
    private int age;
    
    // Some other variables and methods
}
```

دقت کنین که الان کلاس `Student` رو نمیشه در پروژه ها یا کلاس های دیگه `import` و استفاده کرد؛ چون به پکیج نام‌گذاری شده ای تعلق نداره (default package واقعا اسم یه پکیج نیست).

تعریف نکردن پکیج برای کلاس هامون در پروژه های کوچک ایرادی نداره؛ ولی در پروژه های بزرگ حتما باید سعی کنیم که پکیج‌های مناسبی ایجاد کنیم.

همچنین یک کلاس نمیتونه به بیش از یک پکیج تعلق داشته باشه (در غیر این‌صورت خطای کامپایل میخوریم).

#### استفاده از یک کلاس بدون import کردن اون

گاهی اوقات که فقط یک بار میخواین از یک کلاس توی کدتون استفاده کنین، میتونین اون کلاس رو به طور مستقیم import نکنین و بجاش به طور کامل به اسم پکیج توی کد اشاره کنین. مثال زیر رو ببینین:

```java
public class Main {
    public static void main(String[] args) {  
        javax.swing.JFrame jFrame = new javax.swing.JFrame();  
    }  
}
```

در اینجا ما بدون استفاده از عبارت `import javax.swing.JFrame;` تونستیم از کلاس `JFrame` استفاده کنیم. اینجور نوشتن شاید یکم طولانی بنظر بیاد، ولی توی کلاس هایی که تعداد زیادی `import` دارن و حتی ممکنه کلاس هایی با اسم یکسان بخوان `import` بشن، به ما کمک می‌کنه این مشکلات رو حل کنیم.