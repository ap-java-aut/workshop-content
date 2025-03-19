# مقدمه

ما می‌خوایم زمان اضافه شدن یک موجودیت به دیتابیس و زمان آخرین تغییرات اون رو ذخیره کنیم. برای این کار، فیلدهای `creationDate` و `lastModificationDate` رو به موجودیت‌هامون اضافه می‌کنیم و حین ذخیره‌شون توی دیتابیس، این دو فیلد رو مقداردهی می‌کنیم.

البته که لزومی نداره همهٔ موجودیت‌های ما به `CreationDate` و `LastModificationDate` نیاز داشته باشن. به خاطر همین، ما به موجودیت‌های دیتابیس‌مون این گزینه رو می‌دیم که از این فیچر استفاده نکنن. ما یه اینترفیس جدید به اسم `Trackable` معرفی می‌کنیم، که هر موجودیتی از اون ارث‌بری کرد `CreationDate` و `LastModificationDate`ش توسط دیتابیس آپدیت بشه و اگر هم موجودیتی از اون ارث‌بری نکرد، دیتابیس مثل قبل ذخیره‌ش کنه و کاری به این دو فیلد نداشته باشه.

قبل از شروع این قدم، کمی راجع به کلاس `Date` توی جاوا مطالعه کنید خوبه.

# کد زنی

## اینترفیس `Trackable`

اینترفیس `Trackable` رو به پکیج `db` اضافه کنید. موجودیت‌هایی که می‌خوان `CreationDate` و `LastModificationDate`شون توسط دیتابیس آپدیت بشه، از این اینترفیس ارث‌بری می‌کنن. این اینترفیس چهار متد داره:

```java
void setCreationDate(Date date);
Date getCreationDate();

void setLastModificationDate(Date date);
Date getLastModificationDate();
```

این چهار متد، گترها و سترهای فیلدهای `creationDate` و `lastModificationDate` موجودیت‌هان. دیتابیس‌تون از این متدها استفاده می‌کنه تا این فیلدها رو آپدیت نگه داره.

## کلاس `Document`

کلاس `Document` رو توی پکیج `example` ایجاد کنین. این کلاس مثل کلاس `Human`، مثالیه که با اون صرفا با دیتابیس‌تون کار کنید و دیتابیس‌تون رو تست کنید.

کلاس `Document`، از `Entity` ارث‌بری می‌کنه و اینترفیس `Trackable` هم پیاده‌سازی می‌کنه. دقت کنید که کلاس `Human` نباید این اینترفیس رو پیاده‌سازی کنه، چون ممکنه که بعضی موجودیت‌های شما مثل `Human`، به `CreationDate` و `LastModificationDate`شون اهمیت ندن و نیازی نداشته باشن که دیتابیس این دو رو مقداردهی کنه.

حواستون به پیاده‌سازی درست کلاس `Document` باشه. علاوه بر تمام فیلدها و متدهایی که به خاطر ارث‌بری از `Entity` و `Trackable` ایجاد می‌کنید، لازمه که یک فیلد `String` به اسم `content` ایجاد کنید و اون رو توی کانستراکتور این کلاس مقداردهی کنید. لازم نیست برای این موجودیت ولیدیتوری بنویسید.

## کلاس `Database`

متدهای `add` و `update` رو جوری تغییر بدین که در صورتی که `entity` ورودی‌شون، اینترفیس `Trackable` رو پیاده‌سازی می‌کرد، `CreationDate` و `LastModificationDate`ش رو آپدیت کنه.

### متد `add`

متد `add`، باید هر دوی `CreationDate` و `LastModificationDate` موجودیت‌های `Trackable` رو برابر با **تاریخ لحظهٔ اضافه شدن** موجودیت بذاره. سرچ کنید که چطور می‌تونید این تاریخ رو در بیارید.

### متد `update`

متد `update`، نباید `CreationDate` رو عوض کنه و باید صرفا `LastModificationDate` رو برابر **تاریخ لحظهٔ آپدیت شدن** موجودیت بذاره. سرچ کنید که چطور می‌تونید این تاریخ رو در بیارید.

# تست

کد زیر رو برای تست تغییراتتون به جای `main` بذارین:

```java
public static void main(String[] args) throws InvalidEntityException {
    Document doc = new Document("Eid Eid Eid");

    Database.add(doc);

    System.out.println("Document added");
    
    System.out.println("id: " + doc.id);
    System.out.println("content: " + doc.content);
    System.out.println("creation date: " + doc.getCreationDate());
    System.out.println("last modification date: " + doc.getLastModificationDate());
    System.out.println();

    try {
        Thread.sleep(30_000);
    } catch (InterruptedException e) {
        System.out.println("Sleep interrupted!");
    }

    doc.content = "This is the new content";

    Database.update(doc);

    System.out.println("Document updated");
    System.out.println("id: " + doc.id);
    System.out.println("content: " + doc.content);
    System.out.println("creation date: " + doc.getCreationDate());
    System.out.println("last modification date: " + doc.getLastModificationDate());
}
```

توی کد بالا، یک موجودیت `Document` درست می‌کنیم، اون رو به دیتابیس اضافه می‌کنیم و بعدش `CreationDate` و `LastModificationDate`ش رو چاپ می‌کنیم. بعد ۳۰ ثانیه صبر می‌کنیم، داکیومنت‌مون رو آپدیت می‌کنیم و دوباره `CreationDate` و `LastModificationDate`ش رو چاپ می‌کنیم. خروجی این کد به شکلی مشابه شکل زیره:

```java
Document added
id: 1
content: Eid Eid Eid
creation date: Wed Mar 19 13:18:45 GMT+03:30 2025
last modification date: Wed Mar 19 13:18:45 GMT+03:30 2025

Document updated
id: 1
content: This is the new content
creation date: Wed Mar 19 13:18:45 GMT+03:30 2025
last modification date: Wed Mar 19 13:19:15 GMT+03:30 2025
```

همون‌طور که می‌بینید، بعد از `add` شدن موجودیت به دیتابیس، `creationDate` و `lastModificationDate` توسط دیتابیس مقداردهی شدن، اما بعد از `update` شدن موجودیت، فقط `lastModificationDate`ش توسط دیتابیس تغییر کرده.

خودتون دست به کار شید و این فیچر رو بیشتر تست کنید. آیا کلاس قدیمی‌تون یعنی `Human` درست کار می‌کنه؟ آیا این کار روی ولیدیشن‌تون توی دیتابیس تاثیر می‌ذاره؟ می‌تونید توی `validatior`هاتون از تاریخ `creationDate` و `lastModificationDate` استفاده کنید؟

# گزارش کار

توی یه فایل pdf، به سوالای زیر جواب بدین و اون رو آپلود کنین:

## سوال ۱

کلاس Date توی جاوا به چه شکل کار می‌کنه؟ چطور تونستید تاریخ لحظهٔ add یا update رو تعیین کنید؟

## سوال ۲

با توجه به این که کلاس Date، یک reference typeئه، توی متد copy کلاس Document چطور فیلدهای creationDate و lastModificationDate رو کپی کردین که مقادیر اون‌ها از بیرون دیتابیس (بدون استفاده از متد update) قابل تغییر نباشه؟

## سوال ۳

از خروجی کدتون در مرحلهٔ «تست» اسکرین‌شات بگیرین و این‌جا بذارینش.