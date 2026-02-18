---
title: انوتیشن‌ها
writers:
  - آرمان حسینی
  - کیانا رضوی
semester: بهار ۱۴۰۴
course: برنامه‌سازی پیشرفته و کارگاه
professor: دکتر مهدی قطعی
professor_2: بهنام یوسفی‌مهر
department: دانشکده ریاضی و علوم کامپیوتر
institution: دانشگاه صنعتی امیرکبیر
---
## مقدمه
خیلی وقت‌ها نیاز داریم با توابع مثل یک object برخورد کنیم. مثلاً، شاید بخوایم یک تابع رو به یک تابع دیگه ورودی بدیم، از تابعی که یک تابع دیگه رو خروجی بگیریم، و امثال این کارها.
توی جاوا، برای این‌که بتونیم با توابع مثل object برخورد کنیم، از lambda expression ها کمک می‌گیریم. توی این داک می‌خوایم ببینیم lambda expression ها چی هستن و چطور استفاده می‌شن.

## فیلتر کردن داده

فرض کنید رییس، یک `List` از `Person` های مختلف داره و می‌خواد این `List` رو فیلتر کنه. کلاس `Person` به شکل زیره:

```java
public class Person {
    public String name;
    public int age;
    public double height;
    public double weight;
    
    @Override
    public String toString() {
        return "Person{" + 
               "name='" + name + '\'' +
               ", age=" + age +
               ", height=" + height +
               ", weight=" + weight +
               '}';
    }
}
```

حالا، فرض کنید شما می‌خواید یک متد بنویسید که بتونه `List<Person>` رییس ما رو بر اساس پارامترهای مختلف فیلتر کنه. رییس گاهی بر اساس سن آدم‌ها، گاهی بر اساس وزنشون، گاهی بر اساس اسمشون و گاهی هم بر اساس قدشون اون‌ها رو فیلتر می‌کنه. چه‌کار می‌کنید؟
### راه حل اول: برای هر کدوم یک متد بنویسیم

توی راه حل اولمون، برای فیلترِ متفاوت رییس، یک متد می‌نویسیم. مثلاً فرض کنید رییس بخواد اشخاصِ بالای ۱۸ سال رو از توی لیستش پیدا کنه، پس متد زیر رو براش می‌نویسیم:

```java
void printEveryoneOver18(List<Person> people) {
    for (Person p : people) {
        if (p.age > 18) {
            System.out.println(p);
        }
    }
}
```

اگر رییس بخواد همه‌ی آدم‌هایی که قدشون زیر ۱.۹ متره رو پیدا کنه، براش متد زیر رو می‌نویسیم:

```java
void printEveryoneUnder190(List<Person> people) {
    for (Person p : people) {
        if (p.height < 190) {
            System.out.println(p);
        }
    }
}
```

یا اگر رییس بخواد هر کسی که اسمش با `A` شروع بشه رو پیدا کنه، می‌تونه از متد زیر استفاده کنه:
```java
void printEveryoneWhoseNameStartsWithA(List<Person> people) {
    for (Person p : people) {
        if (p.name.startsWith("A")) {
            System.out.println(p);
        }
    }
}
```

می‌تونیم همین‌طور برای رییس متدهای جدید درست کنیم، ولی کد این متدها اون‌قدر با هم تفاوتی نداره. همه‌ی اون‌ها کدشون به شکل زیره:
```java
void printEveryoneWithSomeCondition(List<Person> people) {
    for (Person p : people) {
        if (/* check some condition about p */) {
            System.out.println(p);
        }
    }
}
```

و ما، برنامه‌نویس چندان خوبی نیستیم اگر اجازه بدیم کدمون این‌قدر تکراری باشه! بیاین سراغ راه‌حل بعدی بریم.

### راه‌حل دوم: اینترفیس `CheckPerson`

بیاین یک اینترفیس جدید، به اسم `CheckPerson` ایجاد کنیم. این اینترفیس به شکل زیره:
```java
public interface CheckPerson {
    boolean check(Person p);
}
```

اینترفیس ساده‌ایه. فقط یک متد `check` داره که یک شرط خاص رو در رابطه با `Person` چک می‌کنه. حالا می‌تونیم متدهای تکراری‌مون رو با متد زیر جایگزین کنیم:

```java
void printEveryoneWithSomeCondition(List<Person> people, CheckPerson cp) {
    for (Person p : people) {
        if (cp.check(p)) {
            System.out.println(p);
        }
    }
}
```

حالا اگر رییس بخواد افراد بالای ۱۸ سال رو ببینه، کافیه یک کلاس کوچیک درست کنیم که `CheckPerson` رو پیاده‌سازی می‌کنه:
```java
class CheckOver18 implements CheckPerson {
    @Override
    public boolean check(Person p) {
        return p.age > 18;
    }
}
```

و متد جدیدمون رو با یک instance از این کلاس صدا کنیم:
```java
printEveryoneWithSomeCondition(people, new CheckOver18());
```

متد جدیدمون، خیلی متد قدرتمندتریه و انعطاف بیش‌تری داره، ولی حجم کدمون هنوز هم کم نشده! برای هر فیلتر جدید باید یک کلاس جدید ایجاد کنیم و به‌خاطر همین، حجم کدمون باز هم خیلی زیاده.[^1]

### راه حل سوم: Lambda Expression ها

اینترفیس `CheckPerson`، یک functional interface ‍ه.  به اینترفیس‌هایی که فقط یک متد دارن، functional interface می‌گن. از اون‌جایی که این اینترفیس‌‌ها فقط یک متد دارن، ما می‌تونیم به جای این‌که یک کلاس جدید برای پیاده‌سازی اون‌ها بسازیم، از Lambda Expression ها استفاده کنیم.

فرض کنید ما می‌خوایم تمام افراد بالای ۱۸ سال رو چاپ کنیم. می‌تونیم کلاس `CheckOver18` رو دور بریزیم و متد `printEveryoneWithSomeCondition` رو به شکل زیر صدا بزنیم:
```java
printEveryoneWithSomeCondition(people, (p) -> {
    return p.age > 18;
});
```

تیکه‌ی جدید این کد، بخش زیره:

```java
(p) -> {
    return p.age > 18;
}
```

این تکه از کد، شبیه یک پیاده‌سازی برای متد `check` از اینترفیس `CheckPerson` ‍ه. توی این متد، ورودی `p` ‍ه و خروجی یک `boolean` ‍ه که نشون می‌ده سن `p` از ۱۸ بزرگ‌تره یا نه. از اون‌جایی که `CheckPerson` تنها یک متد داره، خود جاوا می‌فهمه که این lambda expression پیاده‌سازی متد `check` ‍ه.

وقتایی که lambda مون فقط یک ورودی داره، لازم نیست دور اون پرانتز بذاریم. کد بالا رو می‌شد به شکل زیر هم نوشت:

```java
printEveryoneWithSomeCondition(people, p -> {
    return p.age > 18;
});
```

علاوه بر این، وقتی lambda مون فقط یک return ‍ه، لازم نیست دور کدمون `{}` بذاریم و عبارت `return` رو بنویسیم. کد زیر هم کاملاً درسته:

```java
printEveryoneWithSomeCondition(people, p -> p.age > 18);
```

کلاً lambda expression رو عموماً به شکل بالا می‌نویسن.[^2]

### راه حل چهارم: اینترفیس‌های استاندارد جاوا

حتی این حد از کوتاه بودن کد هم برای ما کافی نیست! ما می‌تونیم از شر اینترفیس `CheckPerson` هم خلاص شیم. خود جاوا، یک اینترفیس جنریک به اسم `Predicate` داره که به شکل زیره:
```java
public interface Predicate<T> {
    boolean test(T t);
}
```

پس ما می‌تونیم به‌جای `CheckPerson`، توی متدمون `Predicate<Person>` ورودی بگیریم:

```java
void printEveryoneWithSomeCondition(List<Person> people,
    Predicate<Person> pp) {
        for (Person p : people) {
            if (pp.test(p)) {
                System.out.println(p);
        }
    }
}
```

جاوا از این functional interface ها زیاد داره. بیاین دو تا دیگه از اون‌ها رو با هم بررسی کنیم:
#### اینترفیس `Consumer`
این اینترفیس، به شکل زیره:
```java
public interface Consumer<T> {
    void accept(T t)
}
```

همون‌طور که می‌بینید، فقط یک متد `void` داره که یک آبجکت `T` ورودی می‌گیره. به‌عنوان مثال، متد زیر رو در نظر بگیرید:

```java
void doSomethingWithEveryone(List<Person> people,
                             Consumer<Person> c) {
    for (Person p : people) {
        c.accept(p);
    }
}
```

این متد، یک `consumer` ورودی می‌گیره و اون رو با تمام `Person` های لیست ورودی‌ش اجرا می‌کنه. اگر این متد رو به شکل زیر صدا بزنیم باعث می‌شیم که تمام اعضای لیست `people` یکی یکی چاپ بشن:

```java
doSomethingWithEveryone(people, p -> {
    System.out.println(p);
});
```

#### اینترفیس `Function`
اینترفیس `Function`، به شکل زیره:

```java
public interface Function<T, R> {
    R apply(T t);
}
```

این اینترفیس، برای زمانی به کار می‌ره که بخوایم توی lambda مون چیزی خروجی بدیم. مثلاً فرض کنید که یک لیست عدد داشته باشیم، و بخوایم یک عملیات ریاضی روی تمام اعضای اون انجام بدیم. می‌تونیم از متد زیر استفاده کنیم:

```java
void numbersAfterOperation(List<Double> numbers,
                           Function<Double, Double> operation) {
    for (Double d : numbers) {
        System.out.println(operation.apply(d));
    }
}
```


حالا، می‌تونیم برای این‌که دو برابر هر عدد رو چاپ کنیم، این متد رو به شکل زیر صدا بزنیم:

```java
numbersAfterOperation(numbers, n -> 2 * n);
```

یا اگر می‌خوایم رادیکال هر عدد رو چاپ کنیم، این متد رو به شکل زیر صدا می‌زنیم:

```java
numbersAfterOperation(numbers, n -> Math.sqrt(n));
```

## چیزهایی که یاد گرفتیم
توی این بخش، ما با lambda expression ها آشنا شدیم. یاد گرفتیم که:
- اینترفیس‌های functional چی هستند و چطور می‌شه به کمک lambda expression ها، یک instance از اون‌ها تعریف کرد.
- اینترفیس‌های functional استاندارد جاوا چی هستن.

## منابع بیش‌تر
اگر دوست دارید بیش‌تر راجع‌به lambda expression ها یاد بگیرید، به [داک رسمی Oracle](https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html) یه سر بزنید.

---

[^1]: به چنین کدی، اصطلاحاً boilerplate code می‌گن؛ کدهای تکراری‌ای که برای کارهای خیلی ساده نوشته می‌شن.

[^2]: برای این‌که با انواع و اقسام شیوه‌های lambda نویسی آشنا بشین، [این داک Oracle](https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html#syntax) رو بخونید.
