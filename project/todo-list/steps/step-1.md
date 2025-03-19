# مقدمه

اول از همه، می‌خوایم یه دیتابیس توی جاوا درست کنیم. وظیفهٔ این دیتابیس، نگه‌داری `object`های مختلف در کنار هم و محافظت از اون‌هاست. در ادامه خواهید دید که، چطور می‌تونیم فیچرهای مختلف و جالبی به این دیتابیس اضافه کنیم. فعلا اما، لازمه که بدنهٔ اصلی اون رو ایجاد کنیم.

دیتابیس ما، فعلا توی مموری کار می‌کنه (به این دیتابیس‌ها اصطلاحا in-memory database می‌گن). یعنی آبجکت‌هایی که داخل دیتابیس ذخیره می‌شن با خروج از برنامه می‌پرن و دیگه قابل دسترسی نیستن.

دیتابیس ما سه‌تا قابلیت داره:
+ دیتابیس ما، می‌تونه `object`های مختلف رو ذخیره کنه. موقع ذخیرهٔ این آبجکت‌ها، دیتابیس ما یک `id` یکتا به اون‌ها می‌ده که متعلق به هیچ `object` دیگه‌ای نیست.
+ با گرفتن `id` یک `object`، دیتابیس ما می‌تونه اون `object` رو دوباره به کاربر خروجی بده.
+ با گرفتن `id` یک `object`، دیتابیس ما می‌تونه اون `object` رو از توی خودش حذف کنه.

شما قبل‌تر، توی تمرین «شبیه‌سازی دانشگاه» با این `id`ها سر و کله زدین و احتمالا یادتونه که مجبور می‌شدین متد `findByID` رو توی همهٔ کلاس‌هاتون پیاده‌سازی کنید. دیتابیسی که توی این مرحله می‌سازید، قراره این کار رو براتون راحت‌تر کنه تا دیگه لازم نباشه که این همه کد تکراری بین کلاس‌هاتون داشته باشین.

# کدزنی

## پکیج‌های جدید

اول از همه، پکیج‌های جدیدی به اسم `db` و `db.exception` توی پروژه‌تون ایجاد کنید. این پکیج کل کلاس‌ها، اینترفیس‌ها، اکسپشن‌ها و سایر چیزهای مرتبط با دیتابیس‌تون رو توی خودش نگه می‌داره.

پکیج موقتی هم به اسم `example` درست کنید. کلاس‌های موقتی که برای تست کدتون استفاده می‌کنید رو توی این پکیج می‌ذارین.

## کلاس `Entity`

این کلاسِ پکیج `db`، نشان‌دهندهٔ یک `Entity` (موجودیت) توی دیتابیس شماست. چه چیزی بین تمام `Entity`های دیتابیس شما مشترکه؟ بله، فیلد `id`. این کلاس، برای الآن فقط یک فیلد `public` به اسم `id`، از جنس ‍‍`int` توی خودش داره.

کلاس `Entity` رو `abstract` تعریف کنید. با این که الآن متد ابسترکتی نداره، ولی بعدا قراره کلی از این متدها بهش اضافه کنیم.

## کلاس `Database`

این کلاس، که توی پکیج `db` تعریف می‌شه، همون دیتابیس شماست. **تمام فیلدها و متدهای این کلاس `static`ان و نباید امکان ساخت `instance` از اون‌ها وجود داشته باشه**. اگر یادتون رفته که چطور می‌شه این کار رو کرد، به [**«داکیومنت encapsulation»**](https://drive.google.com/file/d/1OHOuKtX6h4uu0gBJtRwUfX2DxPGVCy23/view?pli=1) نگاهی دوباره بندازید.

این کلاس، یک فیلد `private‍` از جنس `ArrayList<Entity>` به اسم `entities` داره که تمام `entity`های ذخیره شده رو اون‌جا نگه می‌داره. علاوه بر اون، این کلاس چهار متد داره:

+ متد `add(Entity e)`: این متد، با ورودی گرفتن ‍`e` اون رو داخل دیتابیس ذخیره می‌کنه. چون که دیتابیس وظیفهٔ تعیین `id`ی `entity`ها رو داره، لازمه که مقدار `e.id` رو توی این متد مشخص کنید. طبیعتا این متد چیزی خروجی نمی‌ده.
+ متد `get(int id)`: این متد، با گرفتن `id‍‍‍‍` یک `entity`، توی `entities` می‌گرده و موجودیتی که اون `id` رو داره خروجی می‌ده. اگر نتونست موجودیتی با این `id` پیدا کنه، اکسپشنی از جنس `EntityNotFoundException` رو `throw‍‍` می‌کنه. شما در ادامه این اکسپشن رو ایجاد می‌کنید.
+ متد ‍‍`delete(int id)`: این متد، با گرفتن `id`ی یک موجودیت اون رو از دیتابیس پاک می‌کنه. اگر نتونست موجودیتی با این `id` پیدا کنه، اکسپشنی از جنس `EntityNotFoundException` رو `throw‍‍` می‌کنه. **دقت کنید که `id` موجودیت‌های پاک شده نباید به موجودیت جدیدی داده بشه و باید برای همیشه پاک بشه**
+ متد `update(Entity e)`: این متد، با ورودی گرفتن `e‍`، از توی `entities` موجودیتی که `id` اون با `e.id` برابره رو پیدا می‌کنه و `e` رو به جای اون می‌ذاره. اگر نتونست موجودیتی با این `id` پیدا کنه، اکسپشنی از جنس `EntityNotFoundException` رو `throw‍‍` می‌کنه.

## اکسپشن `EntityNotFoundException`

همون‌طور که از اسمش پیداست، این اکسپشن زمانی `throw‍` می‌شه که موجودیت مورد نظر کاربر پیدا نشده. این اکسپشن از نوع un-checkedئه و سه‌تا کانستراکتور داره:

+ `EntityNotFoundException()`: کانستراکتوری که یک اکسپشن با پیام `Cannot find entity` می‌سازه.
+ `EntityNotFoundException(String message)`: کانستراکتوری که یک اکسپشن با پیامی که ورودی گرفته می‌سازه.
+ `EntityNotFoundException(int id)`: کانستراکتوری که یک اکسپشن با پیام ‍‍`"Cannot find entity with id={id}.` می‌سازه. لازمه به جای `{id}` از ‍‍‍`id`ی ورودی داده شده توی متن پیام استفاده کنید.

## کلاس `Human`

کلاس `Human` که ازش برای تست کدتون استفاده می‌کنید رو به پکیج `example` اضافه کنید:

```java
public class Human extends Entity {
    public String name;

    public Human(String name) {
        this.name = name;
    }
}
```

توی این کد، کلاس `Human` که از `Entity` ارث‌بری کرده، می‌تونه ‍‍instanceهای مختلفش رو توی دیتابیس شما ذخیره کنه.

# تست

لازمه که دیتابیس فعلی‌تون رو یه خورده تست کنید. برای تستش می‌تونید از کد زیر هم استفاده بکنید:

```java
public class Main {
    public static void main(String[] args) {
        Human[] humans = {
                new Human("Gholi"),
                new Human("Jamshid"),
                new Human("Akbar"),
        };

        System.out.println("#### Test add method ####");

        for (Human h : humans) {
            System.out.println("Adding " + h.name + " to the database.");
            Database.add(h);
        }

        for (Human h : humans) {
            System.out.println("Id of \"" + h.name + "\" is " + h.id + ".");
        }

        System.out.println();
        System.out.println("#### Test get method ####");

        int gholiId = humans[0].id;
        Human gholi = (Human) Database.get(gholiId);

        System.out.println("successfully got " + gholi.name + " from the database.");

        System.out.println();
        System.out.println("#### Test update method ####");

        gholi.name = "Gholi Mohammadi";
        Database.update(gholi);

        Human gholiAgain = (Human) Database.get(gholiId);
        System.out.println("Updated name: \"" + gholiAgain.name + "\".");

        System.out.println();
        System.out.println("#### Test delete method ####");

        int jamshidId = humans[1].id;
        Database.delete(jamshidId);
        
        try {
            Human jamshid = (Human) Database.get(jamshidId);
        } catch (EntityNotFoundException e) {
            System.out.println(e.getMessage());
        }
    }
}
```

خروجی این کد باید به شکل زیر باشه:

```
#### Test add method ####
Adding Gholi to the database.
Adding Jamshid to the database.
Adding Akbar to the database.
Id of "Gholi" is 1.
Id of "Jamshid" is 2.
Id of "Akbar" is 3.

#### Test get method ####
successfully got Gholi from the database.

#### Test update method ####
Updated name: "Gholi Mohammadi".

#### Test delete method ####
Cannot find entity with id=2.
```

البته اگر راستش رو بخواید شما حتی توی این کد هم متد `update` رو به درستی تست نکردین. توی سوالات گزارش‌تون می‌بینید که این متد چه مشکلی داره و توی قدم بعدی، اون رو برطرف می‌کنید.

نهایتا، یه مقدار بیشتر با این متدهای دیتابیس‌تون ور برین. سعی کنید موجودیت‌های دیگه‌ای مثل `Animal` و غیره هم درست کنید و اون‌ها هم توی دیتابیس‌تون ذخیره کنید. مطمئن بشید که دیتابیس‌تون به درستی کار می‌کنه.

# گزارش کار

توی یک فایل pdf، پاسخ سوالات زیر رو بدین:

## سوال ۰

قبل از هر چیزی، لینک ریپوی گیت‌تون رو این‌جا بذارین و آپلود کنید تا تدریس‌یارها بدونن کجا می‌تونن کدتون رو ببینن.

## سوال ۱
 چطور `EntityNotFoundException` رو un-checked کردین؟ تفاوت بین اکسپشن‌های checked و un-checked چیه؟

## سوال ۲
اگر دقت کنید، متدهای دیتابیس شما `Entity` ورودی می‌گیرن و ‍‍`Entity` خروجی می‌دن. چطور شما می‌تونید آبجکت‌هایی از جنس `Human` رو به این متدها ورودی بدین؟ توی خط زیر، چطور می‌تونید آبجکتی از جنس `Human` از دیتابیس خروجی بگیرین؟

```java
Human gholi = (Human) Database.get(gholiId);
```

## سوال ۳

توی بخش «تست کد»، با این که شما `id` قلی رو توی دیتابیس مقداردهی کردین، به اون از بیرون دیتابیس دسترسی داشتین:

```java
int gholiId = humans[0].id;
```

چجوری؟

## سوال ۴
کد زیر رو اجرا کنید:

```java
public class Main {
    public static void main(String[] args) {
        Human ali = new Human("Ali");
        Database.add(ali);

        ali.name = "Ali Hosseini";

        int aliId = ali.id;
        Human aliFromTheDatabase = (Human) Database.get(aliId);
        
        System.out.println("ali's name in the database: " + aliFromTheDatabase.name);
    }
}
```


توی این کد، ما آبجکت `ali` رو ایجاد و توی دیتابیس ذخیره کردیم، بعدش ‍‍`ali.name` رو عوض کردیم، ولی متد `update` دیتابیس رو صدا نزدیم. پس طبیعتا باید اسم `ali` توی دیتابیس همچنان `Ali` مونده باشه و `Ali Hosseini` نباشه دیگه...

ولی خروجی کد اینه:
```
ali's name in the database: Ali Hosseini
```

چرا این اتفاق افتاد؟