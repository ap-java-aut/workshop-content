---
title: انوتیشن‌ها
writers:
  - امین رضایی‌مهر
  - آرمان حسینی
semester: بهار ۱۴۰۴
course: برنامه‌سازی پیشرفته و کارگاه
professor: دکتر مهدی قطعی
professor_2: بهنام یوسفی‌مهر
department: دانشکده ریاضی و علوم کامپیوتر
institution: دانشگاه صنعتی امیرکبیر
---
## مقدمه

توی بخش «شی‌گرایی ۲»، مقداری با Annotation ها در جاوا آشنا شدیم.[^1] Annotation ها به ما امکان این رو می‌دن که به متدهامون، کلاس‌هامون، یا هر بخش دیگه‌ی برنامه‌های جاوا metadata اضافه کنیم. این metadata ها توسط بخش‌های مختلف قابل خوندن هستن.

مثلاً `@Override` به کامپایلر می‌گفت «این متد، داره یکی از متدهای کلاس والد رو override می‌کنه.»، یا `@Deprecated` به برنامه‌نویس‌های دیگه (و IDE هاشون) می‌گفت «این بخش کد، قدیمیه و دیگه نباید استفاده بشه.».

توی این بخش، می‌خوایم ببینیم این Annotation ها چطور تعریف شدن و چطور می‌تونیم با استفاده از Reflection، اطلاعات این Annotation ها رو توی کلاس‌مون بخونیم. احتمالاً شما حالا حالاها  Annotation های جدید زیادی تعریف نمی‌کنید، ولی فریم‌ورک‌هایی که از اون‌ها استفاده می‌کنید، مثل Hibernate و Spring Boot کلی Annotation جدید استفاده می‌کنن و خوبه که بدونین چطور اون‌ها رو تعریف کردن.

## تعریف Annotation ها
در ابتدا IntelliJ رو باز کنید و هر جایی از صفحه، یک `@Override` بنویسید. بعدش با کلیک روی Go To و Declaration and Usages به سور‌کد انوتیشن Override برید. چنین کدی می‌بینید:
```java
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.SOURCE)
public @interface Override {
}
```

توی جاوا، انوتیشن‌ها با عبارت `@interface` تعریف می‌شن. بالای Override دو annotation دیگه هم می‌بینید:
- انوتیشن Target :
این annotation، مشخص می‌کنه که Override به چه عناصری از کد اعمال‌شدنیه. `@Override` فقط بالای سر متدهامون می‌آد، پس این‌جا هم فقط `ElementType.METHOD` توی Target مشخص شده.
- انوتیشن Retention :
بعضی Annotation ها، فقط در زمان کامپایل به درد ما می‌خورن ولی بعضی از اون‌ها، توی زمان اجرای برنامه هم استفاده می‌شن. مثلاً، `@Override` فقط توسط کامپایلر استفاده می‌شه تا در صورتی که متد والد رو به درستی override نکردیم، بهمون خطا بده. بعد از این‌که کار کامپایلر با کد تموم شد، این انوتیشن از خروجی کامپایلر حذف می‌شه.
این‌که طول عمر هر annotation چه‌قدره توسط Retention مشخص می‌شه؛ اگر `RetentionPolicy.SOURCE` انتخاب بشه annotation مون فقط توسط کامپایلر خونده می‌شه و اگر `RetentionPolicy.RUNTIME` انتخاب بشه، حین اجرای برنامه هم می‌تونیم از این Annotation استفاده کنیم.[^2] در ادامه می‌بینید که چطور می‌تونیم Annotation های بالای عناصر برنامه‌مون رو بخونیم.

حالا بیاین نگاهی به `@Deprecated` هم بندازیم. سورس اون رو هم توی IntelliJ باز کنید:
```java
@Retention(RetentionPolicy.RUNTIME)
@Target(value={
        CONSTRUCTOR,
        FIELD,
        LOCAL_VARIABLE,
        METHOD,
        PACKAGE,
        MODULE,
        PARAMETER,
        TYPE})
public @interface Deprecated {
    String since() default "";
    boolean forRemoval() default false;
}
```

همون‌طور که می‌بینید، این انوتیشن هم Target و Retention داره. با توجه به این‌که هر چیزی می‌تونه قدیمی و بلاکاربرد بشه، `@Deprecated` به کانستراکتورها، فیلدها، متدها و خیلی چیزهای دیگه اعمال‌شدنیه.

برخلاف `@Override` مقدار Retention این انوتیشن برابره با `RetentionPolicy.RUNTIME` که یعنی در حین اجرای برنامه هم قابل استفاده است.

علاوه‌بر این، Deprecated دو پارامتر هم داره. پارامترهای `since` و `forRemoval` که به ترتیب `String` و `boolean` هستند. شما می‌تونید موقع استفاده از Deprecated این دو پارامتر رو مقداردهی کنید:

```java
@Deprecated(since = "2.2", forRemoval = true)
public static void remove(int id) {
    // CODE CODE CODE
}
```

اگر هر کدوم از پارامترها رو مقداردهی نکنید، مقدار دیفالت اون‌ها (که جلوی عبارت `default` اومده.) بهشون داده می‌‌شه:

```java
// forRemoval is false now
@Deprecated(since = "2.2")
public static void remove(int id) {
    // CODE CODE CODE
}
```

حالا که یک آشنایی حداقلی با شیوه‌ی تعریف Annotation ها داریم، می‌تونیم ببینیم که چطور می‌شه Annotation های یک کلاس رو خوند. برای این کار، از قابلیت Reflection استفاده می‌کنیم.

## Reflection

جاوا بهتون این قابلیت رو می‌ده که حین اجرای برنامه، ویژگی‌های کلاس‌هاتون، متدهای اون‌ها، فیلدهاشون و همگی این‌ها رو بررسی کنید. به این قابلیت Reflection می‌گن و یکی از قدرتمندترین ویژگی‌های زبان جاواست.

کلاس زیر رو توی کدتون تعریف کنید:
```java
public class User {
    private String username;
    
    private String password;

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
```

حالا به `main` برید و کد زیر رو بنویسید:

```java
public static void main(String[] args) {
    Class<User> userClass = User.class;
}
```

توی این کد، یک آبجکت ساختیم که شامل ویژگی‌های کلاس `User` ‍ه. همه‌ی عناصر این کلاس، از متدها و فیلدهاش گرفته تا اسم پکیجش و انوتیشن‌هاش، همگی و همگی از طریق `userClass` قابل دسترسی اند. همچنین، اگر توجه کنید خود این آبجکت از جنس `Class<User>` ‍ه.

به‌عنوان مثال، کد زیر اسم کامل این کلاس رو به همراه اسم پکیجش چاپ می‌کنه:

```java
public static void main(String[] args) {
    Class<User> userClass = User.class;
    System.out.println(userClass.getCanonicalName());
}
```

این‌جا کلاس `User` رو توی پکیج `aut.ap` تعریف کردیم، پس خروجی این کد برامون به این شکله:

```text
aut.ap.User
```

یا مثلاً، می‌تونیم با استفاده از آبجکت `userClass`، تمام متدهای این کلاس رو ببینیم:

```java
public static void main(String[] args) {
    Class<User> userClass = User.class;
    
    for (Method method : userClass.getMethods()) {
        System.out.println(method.getName());
    }
}
```

خروجی این کد، به شکل زیره:
```text
getUsername
setUsername
getPassword
setPassword
equals
toString
hashCode
getClass
notify
notifyAll
wait
wait
wait
```

همین‌طور که می‌بینید، علاوه‌بر متدهای خود کلاس‌مون، متدهایی که این کلاس از `Object` به ارث برده هم توی این خروجی دیده می‌شه.
کد زیر هم، تمام فیلدهای این کلاس رو نشونمون می‌ده:

```java
public static void main(String[] args) {
    Class<User> userClass = User.class;
    
    for (Field field : userClass.getDeclaredFields()) {
        System.out.println(field.getName());
    }
}
```

و خروجی‌ش به این شکله:
```text
username
password
```

ما با استفاده از reflection، می‌تونیم annotation های یک کلاس و فیلدهای اون رو هم بخونیم. به کلاس `User` برگردین و با Deprecated، چندتا از متدها و فیلدهای اون رو annotate کنید:

```java
@Deprecated
public class User {
    @Deprecated
    private String username;
    
    private String password;
    
    @Deprecated
    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }
    
    @Deprecated(forRemoval = true, since = "2.2")
    public String getUsername() {
        return username;
    }
    
    @Deprecated
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
}
```

با استفاده از کد زیر، تمام  annotation های متدهاتون رو ببینید. اگر متدی هیچ annotation ای نداشته باشه، توی خروجی این کد چاپ نمی‌شه:
```java
Class<User> userClass = User.class;

for (Method method : userClass.getMethods()) {
    if (method.getAnnotations().length == 0) {
        continue;
    }
    
    System.out.println("Annotations for " + method.getName() + ": ");
    
    for (Annotation annotation : method.getAnnotations()) {
        System.out.println(annotation);
    }
    
    System.out.println();
}
```

خروجی این کد، به شکل زیره:

```text
Annotations for getUsername:
@java.lang.Deprecated(forRemoval=true, since="2.2")

Annotations for setUsername:
@java.lang.Deprecated(forRemoval=false, since="")

Annotations for hashCode:
@jdk.internal.vm.annotation.IntrinsicCandidate()

Annotations for getClass:
@jdk.internal.vm.annotation.IntrinsicCandidate()

Annotations for notify:
@jdk.internal.vm.annotation.IntrinsicCandidate()

Annotations for notifyAll:
@jdk.internal.vm.annotation.IntrinsicCandidate()
```

همون‌طور که می‌بینید، علاوه‌بر `@Deprecated` هایی که برای `getUsername` و `setUsername` و مقادیر اون‌ها مشخص کرده بودیم، annotation هایی که روی متدهای کلاس `Object` اومده بودن هم این‌جا چاپ شدن.

## چیزهایی که یاد گرفتیم
توی این بخش، ما یک نگاه خیلی خیلی مختصر به annotation ها و reflection توی جاوا انداختیم. reflection، از قدرتمندترین ابزارهای جاواست که به دولوپرهای جاوا اجازه می‌ده فریم‌ورک‌های خیلی خوبی بنویسن.
ما توی این داک یاد گرفتیم که:
- چطور Annotation ها تعریف می‌شن.
- با استفاده از Reflection، چطور می‌شه به annotation های یک کلاس دسترسی پیدا کرد.

## منابع بیش‌تر
اگر دوست داشتین راجع‌به reflection بیش‌تر بخونید، [این بلاگ](https://jenkov.com/tutorials/java-reflection/index.html) توضیحات خیلی خوبی راجع‌به اون داده. همچنین اگر دوست دارین راجع‌به Annotation ها بیش‌تر یاد بگیرین، نگاهی به [داک رسمی Oracle](https://docs.oracle.com/javase/tutorial/java/annotations/index.html) بندازید.

---

[^1]: اگر یادتون رفته، یک نگاه کوتاهی بندازین و برگردین.

[^2]: علاوه‌بر این، گزینه‌ی سومی به اسم `RetentionPolicy.CLASS` هم وجود داره که این‌جا بهش نمی‌پردازیم اگر دوست داشتین، از [این‌جا](https://www.geeksforgeeks.org/java-retention-annotations/) می‌تونید بیش‌تر در این مورد بخونید.
