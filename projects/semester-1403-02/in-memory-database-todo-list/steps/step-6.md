# مقدمه

تا این‌جای پروژه رسیدین. دور افتخار بزنید!

![I didn't think I'd get this far](https://i.postimg.cc/V6DL4ccy/temp-Image4-VDKr-H.avif)

فقط یک مسئله مونده و اون هم این که، با هر بار خروج از برنامه‌تون، کل دیتای اون می‌پره. به این برنامه‌ها، اصطلاحا برنامه‌های **non-persistent** می‌گن. در مقابل اون‌ها، برنامه‌های **persistent** برنامه‌هایی‌ان که دیتاشون رو جایی ذخیره می‌کنن تا با بسته شدن اون‌ها، دیتاشون نگه‌داری بشه. 

هدف ما توی بخش آخر، persistent کردن برنامهٔ شماست. این‌جا جایی‌ئه که دیتابیس‌تون توش می‌درخشه و کارتون رو راحت‌ می‌کنه!

قبل از شروع این بخش، کمی راجع به کار با فایل توی جاوا مطالعه کنید.

# کد زنی

قبل از شروع به کد، بیاین ببینیم که اصلا می‌خوایم چه کار کنیم.

ما می‌خوایم، دستور جدیدی به اسم ‍`save` به کاربر بدیم که با زدن اون، تمام موجودیت‌های دیتابیس توی یه فایل روی سیستم ذخیره بشن. دفعهٔ بعد که برنامه اجرا شد، ما موجودیت‌های قبلی دیتابیس رو از روی این فایل می‌خونیم و اون‌ها رو توی دیتابیس‌مون `load` می‌کنیم تا کاربر باز هم بتونه باهاشون کار کنه.

فرض کنید توی دیتابیس‌مون، موجودیت‌های زیر باشن:

![تصویر دیتابیس نمونه در برنامه](https://i.postimg.cc/52qKFtty/temp-Imagesog35z.avif)

حالا اگر کاربر دستور `save` رو بزنه، ما توی فایلی مثل `db.txt` دیتای دیتابیس رو ذخیره می‌کنیم:

![محتوای فایل db.txt](https://i.postimg.cc/zGcb7Cvc/temp-Image-Dqp1yb.avif)

حالا، اگر برنامه‌مون بسته و باز بشه، می‌تونیم فایل `db.txt` رو بخونیم تا ببینیم که آخرین موجودیت‌های ذخیره شده توی دیتابیس‌مون چی بودن. این‌طوری کاربر نیازی به باز نگه داشتن برنامهٔ ما برای موندن اطلاعاتش نداره.

## اینترفیس `Serializer`

به فرآیند تبدیل یک `object` به چیزهایی مثل رشته، آرایه‌ای از بایت‌ها، فایل `json` یا هر چیز دیگه‌ای، serialize کردن می‌گن:

![توصیف Srialization به رشته](https://i.postimg.cc/bwffCByV/temp-Imagef-Bpg9u.avif)

اینترفیس `Serializer` توی دیتابیس شما، نمایندهٔ کلاس‌هاییه که می‌تونن موجودیت‌هاتون رو serialize کنن. هر نوع موجودیت، مثل `Task` یا `Human` باید یکی از این `Serializer`ها برای خودش داشته باشه.

اینترفیس `Serializer`، دو متد داره:

```java
String serialize(Entity e);
Entity deserialize(String s);
```

متد `serialize` با گرفتن موجودیت‌های مختلف از شما، اون‌ها رو به یک رشته serialize می‌کنه. متد `deserialize‍` هم با گرفتن یک رشته از شما، اون رو deserialize می‌کنه و موجودیت حاصل رو بهتون برمی‌گردونه.

## کلاس `Database‍`

مثل ولیدتورها، سریالایزرهای هر `Entity` هم توی یک ‍‍`HashMap` نگه دارین:

```java
private static HashMap<Integer, Serializer> serializers = new HashMap<>();
```


به کلاس `Database‍‍` متد `registerSerializer` رو اضافه کنید:

```java
public static void registerSerializer(int entityCode, Serializer serializer) {
    // add serializer for entity
}
```

حالا به `Database`، متدهای ‍‍`save` و `load` رو هم اضافه کنید:

```java
public static void save() {
    // this method will save the content of Database 
    // to some file named db.txt
}

public static void load() {
    // this method will read the content of db.txt and 
    // reconstruct the entities inside the Database
}
```

توی متد `save`، با صدا زدن ‍‍`Serializer` مرتبط با هر `entity` توی دیتابیس، رشته‌های حاصل رو توی `db.txt` بنویسید و توی متد `load`، با صدا زدن متد `deserializer` اون‌ها اطلاعات قبلی دیتابیس رو از فایل `db.txt` بخونید.

## کلاس ‍‍`Main`

با هر بار شروع دوبارهٔ برنامه، باید با استفاده از متد `Database.load()`، آخرین `Task`ها و `Step`های کاربر رو بازسازی کنید. 

# تست

به اندازهٔ کافی، برنامه‌تون رو توی سناریوهای مختلف تست کنید تا مطمئن شید درست کار می‌کنه.

# گزارش کار

توی یک فایل pdf، به سوالات زیر جواب بدید و حاصل رو آپلود کنید.

## سوال ۱

تنها راه serialize کردن objectها، تبدیل اون‌ها به رشته‌ نیست. در واقع این راه اصلا اونقدران هم راه خوبی نیست. در مورد باقی راه‌های serialization تحقیق کنید و نتیجه رو توضیح بدین. چه فرمت‌های معروفی برای serialize کردن وجود داره؟