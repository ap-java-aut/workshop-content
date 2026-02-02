# مقدمه

ما می‌خوایم به دیتابیس‌مون، امکان این رو بدیم که موجودیت‌های داخلش رو validate کنه. مثلا اگر `Human`ای ذخیره می‌شه، می‌خوایم دیتابیس‌مون بتونه تشخیص بده که آیا این `Human`، مقادیر درستی توی فیلدهاش داره؟ سنش منفی نیست؟ اسمش کامله؟

ما می‌خوایم به برنامه‌نویس‌هایی که از دیتابیس‌مون استفاده می‌کنن، اجازه بدیم که با تعیین validatorهای مختلف، آبجکت‌هایی که توی دیتابیس ذخیره می‌شن رو validate کنن. توی این بخش، این امکان رو به دیتابیس‌مون اضافه می‌کنیم.

پیشنهاد می‌کنم قبل از شروع به پیاده‌سازی، اول یک بار از ابتدا تا انتهای این قدم رو بخونید تا متوجه بشید که validation توی دیتابیس ما به چه صورت انجام می‌شه.

# کدزنی

## کلاس `Human`

به کلاس `Human`، فیلد پابلیکی به اسم `age` اضافه کنید. توی کانستراکتورها و متد `copy`‌تون هم تغییرات لازم برای اضافه شدن این فیلد رو بدین.

## اکسپشن `InvalidEntityException`

اکسپشن `InvalidEntityException` رو به پکیج `db.exception` اضافه کنید. این اکسپشن checkedئه و فقط هم یک کانستراکتور داره، کانستراکتور `InvalidEntityException(String message)` که با ورودی گرفتن `message`، اون رو به عنوان پیام exception ست می‌کنه.

این اکسپشن وقتی `throw` می‌شه که موجودیتی که داریم توی دیتابیس ذخیره می‌کنیم، مقادیر درستی نداره.

## اینترفیس `Validator`

توی پکیج `db`، یک اینترفیس به اسم `Validator` تعریف کنید. برنامه‌نویس‌‌های دیگه با استفاده از این اینترفیس کلاس‌های ولیدیتور خودشون رو می‌سازن.

این اینترفیس، یک متد داره:

```java
void validate(Entity entity) throws InvalidEntityException;
```

دیتابیس‌تون می‌تونه با صدا زدن این متد، از valid بودن موجودیتی که بهش ورودی داده شده مطمئن باشه.

## کلاس `HumanValidator`

حالا که اینترفیس `Validator` رو ساختید، وقتشه که یک ولیدیتور برای `Human` بسازید. کلاس `HumanValidator` رو توی پکیج `example` ایجاد کنید و از `Validator` ارث‌بری کنید:

```java
public class HumanValidator implements Validator {
    @Override
    public void validate(Entity entity) throws InvalidEntityException {
        // Code for human validation
    }
}
```

بعدا با دادن آبجکت‌هایی از جنس `Human` به متد `validate`، از کلاس شما می‌خوایم که اون‌ها رو validate کنه. 

توی متد `validate`، اول از همه چک کنید که موجودیت ورودی از جنس `Human` باشه و اشتباهی، موجودیت از جنس دیگه بهتون ورودی نداده باشن. اگر جنس موجودیت ورودی هر چیزی جز `Human` بود، اکسپشنی از جنس `IllegalArgumentException` با پیام مناسب `throw` کنید. برای این کار، می‌تونید از کلیدواژهٔ `instanceof` استفاده کنید و لازمه راجع بهش تحقیق کنید.

بعد از این کار، چک کنید که سن `Human` ورودی منفی نباشه و اسمش هم `null` یا خالی نباشه. اگر هر کدوم از این دو اتفاق افتاده بود، اکسپشنی از جنس `InvalidEntityException` با متن مناسب `throw` کنید.

## کلاس `Entity`
 
به کلاس `Entity`، متد ابسترکتی به اسم `getEntityCode()` اضافه کنید که `int` خروجی می‌ده:

```java
public abstract int getEntityCode();
```

این متد برای همهٔ موجودیت‌هایی که جنس یکسانی دارن، عدد یکسانی برمی‌گردونه. مثلا تمام instanceهای کلاس `Human` عدد ۱۴ رو بر می‌گردونن. از طرفی، به طور قراردادی عددی که متد `getEntityCode()` توی هر کلاس برمی‌گردونه نسبت به کلاس‌های دیگه متمایزه. مثلا اگر کلاس `Lion` رو هم به برنامه‌تون اضافه کنید، نباید توی این متد عدد ۱۴ که متعلق به کلاس `Human`ئه رو برگردونید.

این متد رو توی کلاس `Human` به شکل زیر پیاده‌سازی کنید:

```java
class Human extends Entity {
    public static final int HUMAN_ENTITY_CODE = 14;

    // Fields, Constructors, Methods, etc.

    @Override
    public int getEntityCode() {
        return HUMAN_ENTITY_CODE;
    }
}
```

حالا دیتابیس‌تون می‌تونه با صدا زدن این متد، بفهمه که با چه نوع موجودیتی طرفه و ولیدیتور مناسب اون موجودیت رو صدا بزنه. مثلا اگر دیتابیس‌تون در حال ذخیرهٔ موجودیتی با کد ۱۴ بود، می‌تونه بفهمه که این موجودیت از جنس `Human`ئه و متد `validate` تابع `HumanValidator` رو روش صدا بزنه.

## کلاس `Database`

به فیلدهای کلاس دیتابیس، فیلد زیر رو اضافه کنید:

```java
private static HashMap<Integer, Validator> validators;
```

این `HashMap`، شامل ولیدیتور‌های دیتابیس‌تونه. کلیدهای اون، EntityCodeهایی هستن که توی بخش قبل دیدین و مقادیر نظیر هر کلید، `Validator` اون `Entity` رو نشون می‌ده. یک متد هم برای اضافه کردن ولیدیتورهای جدید به دیتابیس‌تون اضافه کنید:

```java
public static void registerValidator(int entityCode, Validator validator) {
    // Code for registering new validators
}
```

توی این متد، اول چک کنید که `Validator`ای با `entityCode` ورودی توی هش‌مپ `validators` وجود نداشته باشه، و اگر وجود داشت، خطای `IllegalArgumentException` با متن مناسب `throw` کنید. بعد از این چک، `Validator` رو به هش‌مپ `validators` اضافه کنید.

حالا لازمه متدهای `add` و `update` رو طوری تغییر بدین که از این `Validator`ها استفاده کنن. با کدی مشابه کد زیر، می‌تونید از صحت اطلاعات موجودیت ورودی مطمئن باشین:

```java
Validator validator = validators.get(entity.getEntityCode());
validator.validate(entity);
```

# تست کد

کد زیر رو با متد main جایگزین کنید:

```java
public class Main {
    public static void main(String[] args) throws InvalidEntityException {
        Database.registerValidator(Human.HUMAN_ENTITY_CODE, new HumanValidator());

        Human ali = new Human("Ali", -10);
        Database.add(ali);
    }
}
```

بعد از اجرای اون، باید با پیغام خطای زیر رو به رو می‌شید:

```
Exception in thread "main" db.exception.InvalidEntityException: Age must be a positive integer
	at example.HumanValidator.validate(HumanValidator.java:15)
	at db.Database.add(Database.java:30)
	at Main.main(Main.java:11)
```

بیاین تا با هم مرور کنیم که توی این کد چه اتفاقی افتاده.

توی خط اول کد، شما یک `Validator` به دیتابیس‌تون اضافه کردید. این ولیدیتور، برای `Human`ئه و به همین خاطر هم، `entityCode` رو برابر با `Human.HUMAN_ENTITY_CODE` گذاشتین و `validator` هم با` new HumanValidator()` مقداردهی کردین.

بعد از صدا زدن متد `add` با آبجکت `ali`، دیتابیس‌تون بررسی کرد که آیا می‌تونه `validator`ای با `entityCode`ای برابر `ali.getEntityCode()` پیدا کنه یا نه. از اون‌جایی که `ali.getEntityCode()` همون مقدار `Human.HUMAN_ENTITY_CODE` رو خروجی می‌ده و شما هم یک `Validator` برای این `entityCode` به دیتابیس‌تون معرفی کرده بودین، دیتابیس‌تون اون `validator` رو صدا می‌زنه که به شما خطای بالا رو می‌ده.

# گزارش کار

توی یک فایل pdf، پاسخ سوالات زیر رو بدین:

## سوال ۱

کلیدواژهٔ `instanceof` چه کار می‌کنه و چطور ازش استفاده می‌شه؟

## سوال ۲

چه راه‌های دیگه‌ای به ذهنتون می‌رسه که با استفاده از اون، بتونید موجودیت‌های مختلف توی دیتابیس رو Validate کنید. مزایا و معایبش نسبت به راه حل فعلی چیه؟

## سوال ۳

یک اسکرین‌شات از خروجی کدتون حین اجرای کد «تست کد» بذارین.