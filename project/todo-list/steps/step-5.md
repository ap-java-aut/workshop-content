# مقدمه

توی قدم‌های قبلی، شما یه in-memory database خیلی خفن ساختین! یکی رو پیدا کنین و با افتخار اینو بهش بگین! دیتابیس شما سه‌تا قابلیت اصلی داره:

+ بستری رو فراهم می‌کنه تا موجودیت‌های مختلف توی اون ذخیره و مدیریت بشن.
+ با استفاده از `Validator`ها، امکان این رو فراهم می‌کنه که این موجودیت‌ها موقع ذخیره شدن ولیدیت بشن. استفاده‌کنندگان دیتابیس می‌تونن با معرفی ولیدیتورهای شخصی‌سازی‌ شدهٔ خودشون برای موجودیت‌های مختلف، از data integrity (یکپارچگی داده) دیتابیس شما مطمئن بشن.
+ اینترفیسی رو دادین که با ارث‌بری از اون، دیتابیس شما تاریخ ساخت و تاریخ آخرین تغییر موجودیت‌ها رو نگه می‌داره.

![تشویق](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExbHB4eWhkNDRscTlxM3cwNm4wNzdydDBvdTl0anA4dzhtYWVraGY1aiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/YRuFixSNWFVcXaxpmX/giphy.gif)

حالا لازمه که از این دیتابیس، توی یه برنامهٔ to-do list استفاده کنین. البته دقت کنید که شما با استفاده از این دیتابیس هر برنامهٔ دیگه‌ای هم می‌تونستید بنویسید! قبل از شروع این بخش، اول راجع به ‍`enum`ها توی جاوا کمی مطالعه کنید.

# کدزنی

## پکیج‌های جدید

سه پکیج جدید به اسم‌های `todo.entity` و `todo.validator` و `todo.service` درست کنید. علاوه بر این می‌تونید پکیج `example` هم پاک کنید، چون دیگه به اون نیازی ندارید.

## کلاس `Task`

توی پکیج `todo.entity`، کلاس جدیدی به اسم `Task` بنویسید. این کلاس، یک «کار» توی to-do list شما رو نشون می‌ده. مثلا «انجام پروژه»، «شستن لباس‌ها» یا چیزهای مشابه. 

کلاس `Task` داخل خودش یک `enum` به اسم `Status` نگه می‌داره که نشان‌دهندهٔ وضعیت کاره. این `enum` مثل inner classها، داخل خود کلاس `Task` تعریف می‌شه و از بیرون این کلاس هم در دسترسه. `Status` می‌تونه سه مقدارِ `NotStarted` و `InProgress` و `Completed` رو داشته باشه.

این کلاس از `Entity` ارث‌بری می‌کنه و اینترفیس `Trackable` هم پیاده‌سازی می‌کنه. `Task` علاوه‌بر فیلدها و متدهایی که به خاطر ارث‌بری‌هاش داره، فیلدهای زیر رو هم داره:

+ فیلد `title`: فیلد `String`ای شامل عنوان کاری که قراره انجام بشه
+ فیلد `description`: فیلد `String`ای شامل توضیحات اضافهٔ مربوط به این کار
+ فیلد `dueDate`: فیلد `Date`ای که زمان اتمام مهلت انجام کار رو نگه می‌داره
+ فیلد `status`: فیلدی از جنس `Status` که وضعیت کار رو نگه می‌داره

## کلاس `Step`

هر `Task`، می‌تونه از چند قدم تشکیل شده باشه. مثلا ممکنه تسک «انجام پروژهٔ AP»، از قدم‌های زیر تشکیل شده:

1. طراحی دیتابیس اولیه
2. کپی کردن objectها
3. درست کردن todo-list

توی پکیج `todo.entity`، کلاس جدیدی به اسم `Step` بنویسید. این کلاس، نمایندهٔ قدم‌های لازم برای انجام یک `Task`ئه.

کلاس `Step` هم مثل `Task`، یک `inner enum` به اسم `Status` داره. با این تفاوت که `Step`ها به خاطر کوچیک‌تر بودنشون، وضعیت `InProgress` رو ندارن و این `enum`، فقط مقادیر `NotStarted` و `Completed` رو نگه می‌داره.

این کلاس از `Entity` ارث‌بری می‌کنه. `Step` علاوه بر فیلدها و متدهایی که به خاطر ارث‌بری‌ش داره، فیلدهای زیر رو هم داره:

+ فیلد `title`: فیلد `String`ای شامل عنوان قدم
+ فیلد `status`: فیلدی از جنس `Status` که وضعیت قدم رو نگه می‌داره
+ فیلد `taskRef`: فیلد `int`ای که `id` آبجکت `Task` مرتبط با این `Step` رو نشون می‌ده.

## کلاس `TaskValidator`

توی پکیج `todo.validator`، کلاس جدیدی به اسم `TaskValidator` اضافه کنید که وظیفهٔ ولیدیت کردن `Task`ها برای دیتابیس رو بر عهده داره. این کلاس از اینترفیس `Validator` ارث‌‌بری می‌کنه.

توی متد `validate` این کلاس، به ترتیب موضوعات زیر رو چک کنید:

+ اول از همه، چک کنید که آبجکت ورودی از جنس `Task` باشه. در غیر این صورت اکسپشنی از جنس `IllegalArgumentException` با پیام مناسب `throw` کنید.
+ چک کنید که `title` متعلق به `task` ورودی، `null` یا خالی نباشه.

## کلاس `StepValidator`

توی پکیج `todo.validator`، کلاس جدیدی به اسم `StepValidator` اضافه کنید که وظیفهٔ `validate` کردن `Step`ها برای دیتابیس رو بر عهده داره. این کلاس از اینترفیس `Validator` ارث‌‌بری می‌کنه.

توی متد `validate` این کلاس، به ترتیب موضوعات زیر رو چک کنید:
+ اول از همه، چک کنید که آبجکت ورودی از جنس `Step` باشه. در غیر این صورت اکسپشنی از جنس `IllegalArgumentException` با پیام مناسب `throw` کنید.
+ چک کنید که `title` متعلق به `task` ورودی، `null` یا خالی نباشه.
+ چک کنید که `Task`ای با `id`ی مساویِ `taskRef` توی دیتابیس باشه. به عبارتی، چک کنید که `taskRef` توی `step` چرت نباشه!

## کلاس `TaskService`

توی پکیج `todo.service` کلاسی به اسم `TaskService` درست کنید. توی این کلاس، باید متدها و `service`های مرتبط با `Task` رو بنویسید. مثلا اگر می‌خواید `Status` یک `Task` رو به `Completed` تغییر بدین، توی کلاس `TaskService` متد `static`ای مثل متد زیر بنویسید:

```java
public class TaskService {    
    public static void setAsCompleted(int taskId) {
        // get task from the database, set it as completed and update it in the database    
    }
}
```

ما `Logic` مرتبط با کلاس `Task` رو این‌جا می‌نویسیم و سعی می‌کنیم به خود `Task` متد خاصی مثل `setAsCompleted` اضافه نکنیم. به عبارتی، کلاس `Task` برای ما فقط به عنوان یک ظرف برای ذخیرهٔ داده‌هامون توی دیتابیس استفاده می‌کنیم و منطق و متدهای مرتبط با `Task` رو اون‌جا نمی‌نویسیم.

## کلاس `StepService`

توی پکیج `todo.service` کلاسی به اسم `StepService` درست کنید. توی این کلاس، متدها و `service`های مرتبط با `Step` رو بنویسید. مثلا اگر لازم بود `Step` جدیدی به دیتابیس اضافه کنید، متد `static`ای توی کلاس `StepService` به اسم `saveStep` درست کنید:

```java
public class StepService {
    public static void saveStep(int taskRef, String title) {
        // Create a new step with the specified taskRef and title, then
        // set it state to NotStarted and save it to the database
    }
}
```

## کلاس `Database`

به کلاس `Database`تون، متدی به اسم `getAll` اضافه کنید:

```java
public static ArrayList<Entity> getAll(int entityCode) {
    // return all the entities with specified entityCode
}
```

این متد، تمام موجودیت‌های دیتابیس با `entityCode`ای که ورودی گرفته شده رو برمی‌گردونه. این متد احتمالا قراره در ادامه به دردتون بخوره!

## کلاس `Main`

این‌جا قراره با کاربر تعامل کنید و ازش دستورات مشخصی رو بگیرین. این دستورات به چهار نوع تقسیم می‌شن. 

با ورودی گرفتن هر کدوم از این دستورات، باید یکی از متدهای `TaskService` یا `StepService` رو صدا بزنین که کار مورد نظرتون رو براتون انجام بده و نباید منطق برنامه‌تون توی `Main` نوشته بشه. علتش هم اینه که توی برنامهٔ شما، `Main` فقط برای ورودی گرفتن از کاربر و صدا زدن متدهای `Service`هاتونه.

دقت کنید که کاربر ممکنه هر نوع ورودی غلطی به شما بده! برنامهٔ شما در مقابل ورودی‌های غلط نباید کرش کنه و باید با exception handling مناسب از کاربر بخواد که ورودی‌های درستی بهش بده.

توی کلاس `Main‍`، شما باید انقدر دستورات جدید از کاربر بگیرید، تا کاربر دستور `exit` رو بهتون بده و از برنامه‌تون خارج بشه.

### دستورات `add`

دستورات `add`، برای اضافه کردن `Task`ها یا `Step`ها به دیتابیس استفاده می‌شن. کاربر می‌تونه دو دستور به شما بده:

#### دستور `add task`

اگر کاربر ورودی زیر رو به برنامهٔ شما داد:

```
add task
```  

به ترتیب اسم، توضیحات و تاریخ اتمام مهلت `task` رو از کاربر ورودی بگیرین:

```
Title: AP Project
Description: The project assigned to me by the Advanced Programming Teaching Assistant team. The project details have been uploaded on Quera.
Due date: 2025-04-04
```

لازمه Due Date رو به فرمت `yyyy-mm-dd` ورودی بگیرین. بعد از ورودی گرفتن موارد لازم، این `task` رو با وضعیت `NotStarted` توی دیتابیس ذخیره کنید. سپس در صورت موفقیت خروجی زیر رو بدین و توی اون، `id` موجودیت `task` توی دیتابیس رو برگردونین:

```
Task saved successfully.
ID: 7
```

در صورتی که به خطا خوردین، توی پیامی مثل پیام زیر خطا رو به کاربر اعلام کنید:

```
Cannot save task.
Error: Task title cannot be empty.
```

#### دستور `add step`

اگر کاربر ورودی زیر رو به شما داد:

```
add step
``` 

به ترتیب، آی‌دی `task` مربوطه و عنوان قدم رو ورودی بگیرید:

```
TaskID: 7
Title: Implement an in-memory database
```

سپس `Step`ای با `taskRef` و `title` مشخص شده ایجاد کنید، وضعیتش رو `NotStarted` بذارید و توی دیتابیس ذخیره‌ش کنید. اگر موفق شدید، پیغامی مثل زیر خروجی بدین:

```
Step saved successfully.
ID: 8
Creation Date: Tue Mar 19 14:35:02 GMT 2025
```

و در غیر این صورت، خطا رو به کاربر گزارش بدین:

```
Cannot save step.
Error: Cannot find task with ID=7.
```

### دستور `delete`

با استفاده از دستور `delete`، می‌تونید موجودیت‌های مختلف رو از دیتابیس پاک کنید. وقتی کاربر دستور `delete` رو وارد کرد:

```
delete
```

ازش `id`ی موجودیتی که می‌خواد پاک بشه رو ورودی بگیرین:

```
ID: 7
```

و سپس، موجودیت مورد نظر رو از دیتابیس پاک کنید. اگر موفق بودید، پیام زیر رو بدین:

```
Entity with ID=7 successfully deleted.
```

اگر به خطایی خوردین، متن خطا رو چاپ کنید:

```
Cannot delete entity with ID=7.
Error: Something happend
```

دقت کنید که در صورتی که یک `task` پاک شد، باید `step`های اون `task` هم پاک کنید.

### دستورات `update`

با استفاده از این دستورات، کاربر می‌تونه موجودیت‌های موجود در دیتابیس رو تغییر بده.

#### دستور `update task`

در صورتی که کاربر دستور زیر رو وارد کرد:

```
update task
```

ابتدا آی‌دی `task` مورد نظر کاربر رو ورودی بگیرید، سپس اسم فیلدی که کاربر می‌خواد تغییر بده و مقدار جدید اون فیلد رو ورودی بگیرید:

```
ID: 7
Field: title
New Value: To-Do List Project
``` 

سپس، در صورت موفقیت پیام زیر رو به کاربر بدین. این پیام باید شامل مقدار قبلی فیلد و مقدار جدیدش باشه:

```
Successfully updated the task.
Field: title
Old Value: AP Project
New Value: To-Do List Project
Modification Date: Tue Mar 19 14:35:02 GMT 2025
```

در صورت عدم موفقیت هم، مثل قبل خطا رو چاپ کنید:

```
Cannot update task with ID=7.
Error: Cannot find entity with id=7
```

دقت کنید که اگر کاربر، `Status` یک `Task` رو به `Completed` آپدیت کرد:

```
ID: 7
Field: title
New Value: Completed
```

باید `Status` تمام `Step`های این `Task` به ‍‍`Completed` تغییر بکنه.

### دستور `update step`

در صورتی که کاربر دستور زیر رو وارد کرد:

```
update step
```

مثل قبل آی‌دی `step` مورد نظر رو ورودی بگیرین، فیلدی که کاربر می‌خواد تغییر بده هم به همراه مقدار جدیدش ورودی بگیرین:

```
ID: 8
Field: status
New Value: Completed
```

در صورت موفقیت، پیام زیر رو شامل مقدار قدیمی و جدید فیلد مورد نظر و زمان تغییر به کاربر نشون بدین:

```
Successfully updated the step.
Field: status
Old Value: NotStarted
New Value: Completed
Modification Date: Tue Mar 19 14:35:02 GMT 2025
```

و در صورت عدم موفقیت، به کاربر متن خطا رو نشون بدین:

```
Cannot update step with ID=8.
Error: Cannot find entity with ID=8
```

دقت کنید که اگر تمام قدم‌های یک تسک `Completed` شدن، خود اون تسک هم باید اتوماتیک `Completed` بشه. همچنین اگر تسکی در استیت `NotStarted` بود، با `Completed` شدنِ یکی از قدم‌هاش باید اتوماتیک استیتش به `InProgress` تغییر پیدا کنه.

### دستورات `get`

با استفاده از این دستورات، کاربر می‌تونه `task`ها و `step`های خودش رو ببینه.

#### دستور `get task-by-id`

اگر کاربر دستور زیر رو وارد کرد:

```
get task-by-id
``` 

ابتدا ازش `id` تسکی که می‌خواد ببینه رو بخواید:

```
ID: 7
```

به عنوان مثال، اگر این تسک، اسمش «AP Project» بود و دو قدمِ «Complete the database» و «Implement the to-do list» داشت، باید این `task` رو به شکل زیر نشون بدین:

```
ID: 7
Title: AP Project
Due Date: 2025-04-04
Status: InProgress
Steps:
    + Complete the database:
        ID: 8
        Status: Completed
    + Implement the to-do list:
        ID: 9
        Status: NotStarted
```

اگر تسکی با `id` مورد نظر کاربر پیدا نشد، به کاربر خطا بدین:

```
Cannot find task with ID=7.
```

**دقت کنید که ممکنه `task`‌ها، هیچ `step`ای نداشته باشن.**

#### دستور `get all-tasks`

اگر کاربر دستور زیر رو زد:

```
get all-tasks
``` 

تمامی تسک‌هاش رو بهش نشون بدین. این تسک‌ها باید بر اساس Due Dateشون به صورت صعودی مرتب شده باشن:

```
ID: 4
Title: Read "Learning Java" Book
Due Date: 2025-03-06
Status: Completed

ID: 7
Title: AP Project
Due Date: 2025-04-04
Status: InProgress
Steps:
    + Complete the database:
        ID: 8
        Status: Completed
    + Implement the to-do list:
        ID: 9
        Status: NotStarted

ID: 10
Title: LO Assignment
Due Date: 2025-04-06
Status: NotStarted
```

#### دستور `get incomplete-tasks`

اگر کاربر دستور زیر رو زد:

```
get incomplete-tasks
```

باید بهش تمام `task`های ناتمامش رو نشون بدین:

```
ID: 7
Title: AP Project
Due Date: 2025-04-04
Status: InProgress
Steps:
    + Complete the database:
        ID: 8
        Status: Completed
    + Implement the to-do list:
        ID: 9
        Status: NotStarted

ID: 10
Title: LO Assignment
Due Date: 2025-04-06
Status: NotStarted
```

### دستور `exit`

با زدن این دستور، از برنامه خارج بشید.

# تست

برنامه‌تون رو تحت شرایط مختلف تست کنید و مطمئن بشید که به درستی کار می‌کنه. سعی کنید سناریوهای مختلفی رو در پیش بگیرید و برنامه‌تون رو به چالش بکشید تا مطمئن بشید که خطایی نداره.

# خلاق باشید!

![Here Be Dragons](https://i.postimg.cc/zDp1FZrB/temp-Image-SI7-Th-D.avif)

حالا که برنامه‌تون رو کامل کردین، سعی کنید که بهش فیچرهای جدید اضافه کنید! هر چیزی که این‌جا به برنامه‌تون اضافه می‌کنید ممکنه براتون نمرهٔ امتیازی داشته باشه.

مثلا، می‌تونید به کاربر، امکان دسته‌بندی `Task`هاش رو به لیست‌های مختلف، مثل University و Personal و ... رو بدین! می‌تونید بهش امکان تعیین اهمیت و اولویت تسک‌هاش رو بدین یا می‌تونید رابط کاربری گرافیکی براش بنویسید. کلی کار هست که می‌تونید با این to-do بکنید =)))

اگر کردین، حتما به تدریس‌یارهاتون بگید تا براتون بسته به کاری که انجام شده، نمرهٔ امتیازی در نظر بگیرن.

# گزارش کار

یک فایل pdf با پاسخ سوالات زیر توی این بخش آپلود کنید

## سوال ۱

توی جاوا، `enum`ها چی‌ان و به چه دردی می‌خورن؟ چطور اون‌ها رو تعریف می‌کنید؟

## سوال ۲

با توجه به این که شما `TaskValidator` و `StepValidator` رو نوشتید تا `Task` و `Step`های invalid توی دیتابیس ذخیره نشن، آیا لازمه که برای فیلدهاتون گتر و ستر بنویسید؟ چرا؟

## سوال ۳

توی این پروژه، ما آرایه‌ای از `Step`ها توی `Task` تعریف نکردیم. یعنی این‌طور نیست که `Task` شما فیلدی از جنس `ArrayList<Step>` داشته باشه که بیان‌گر قدم‌های اون `Task` باشه. به نظرتون آیا می‌تونستیم این کار رو بکنیم؟ این کار چه تاثیری روی ذخیره‌سازی موجودیت `Task` توی دیتابیس داشت؟

## سوال ۴

به نظرتون این که `Main` فقط برای ورودی گرفتن از کاربر باشه و `Logic` برنامه توی `Main` نوشته نشه، چطور به دیزاین برنامه کمک می‌کنه؟ اگر پس‌فردا، می‌خواستید به جای shell، از یک رابط گرافیکی استفاده کنید، این که `Main` شامل `Logic` برنامه‌تون نبود چه کمکی بهتون می‌کرد؟