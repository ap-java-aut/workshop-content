در این تمرین با یک دیتابیس ساده فوتبال کار می‌کنیم که شامل اطلاعات تیم‌ها، بازیکنان و بازی‌های برگزار شده است.  
شما قرار است کوئری‌هایی بنویسید که تعداد بازیکنان هر تیم، آمار گل‌ها در بازی‌ها، و نتایج تیم‌ها را به‌صورت دقیق استخراج کنند. 

دقت کنید که پاسخ هر سوال، باید توی **فقط یک کوئری** به دست بیاد. این کوئری می‌تونه شامل هر دستور SQLای مثل `where`،‏ `group by`، ‏‍‍`join` یا هر چیز دیگه‌ای باشه، ولی جواب نهایی شما برای هر سوال باید فقط شامل یک کوئری باشه.

# آماده‌سازی دیتابیس
با استفاده از اسکریپت زیر، دیتابیس‌تون رو آماده کنید:
```SQL
create table teams (
    id int auto_increment primary key,
    name varchar(100) not null,
    city varchar(100) not null,
    year_founded int not null
);

create table players (
    id int auto_increment primary key,
    name varchar(100) not null,
    birth_date date not null,
    position varchar(50) not null,
    team_id int,
    
    foreign key (team_id) references teams(id)
);

create table matches (
    id int auto_increment primary key,
    match_date date not null,
    home_team_id int not null,
    away_team_id int not null,
    home_score int not null,
    away_score int not null,
    
    foreign key (home_team_id) references teams(id),
    foreign key (away_team_id) references teams(id)
);

insert into teams (name, city, year_founded) values
('Esteghlal', 'Tehran', 1945),
('Persepolis', 'Tehran', 1963),
('Tractor', 'Tabriz', 1970);

-- بازیکنان استقلال
insert into players (name, birth_date, position, team_id) values
('Ali Karimi', '1990-03-15', 'Midfielder', 1),
('Reza Ghoochannejhad', '1987-09-20', 'Forward', 1),
('Saeid Ezatolahi', '1996-10-01', 'Midfielder', 1),
('Mohammad Hosseini', '1992-05-25', 'Defender', 1),
('Amir Abedzadeh', '1993-04-26', 'Goalkeeper', 1);

-- بازیکنان پرسپولیس
insert into players (name, birth_date, position, team_id) values
('Mehdi Taremi', '1992-07-18', 'Forward', 2),
('Vahid Amiri', '1988-04-02', 'Winger', 2),
('Shoja Khalilzadeh', '1989-05-14', 'Defender', 2),
('Alireza Beiranvand', '1992-09-21', 'Goalkeeper', 2),
('Ehsan Hajsafi', '1990-02-25', 'Midfielder', 2);

-- بازیکنان تراکتور
insert into players (name, birth_date, position, team_id) values
('Ashkan Dejagah', '1986-07-05', 'Midfielder', 3),
('Masoud Shojaei', '1984-06-09', 'Midfielder', 3),
('Saman Ghoddos', '1993-09-06', 'Forward', 3),
('Milad Mohammadi', '1993-09-29', 'Defender', 3),
('Payam Niazmand', '1995-04-06', 'Goalkeeper', 3);

insert into matches (match_date, home_team_id, away_team_id, home_score, away_score) values
('2024-01-10', 1, 2, 2, 1),  -- Esteghlal vs Persepolis
('2024-01-17', 2, 3, 1, 1),  -- Persepolis vs Tractor
('2024-01-24', 3, 1, 0, 3),  -- Tractor vs Esteghlal
('2024-02-01', 1, 3, 2, 2),  -- Esteghlal vs Tractor
('2024-02-08', 2, 1, 0, 1);  -- Persepolis vs Esteghlal

```

# سوالات

## سوال اول

یک کوئری بنویسید که نام هر تیم و تعداد بازیکنان آن را نمایش دهد.

## سوال دوم

یک کوئری بنویسید که نام تیم‌هایی که در بازی‌هایشان مجموعا بیش از دو گل زده‌اند (به عنوان میزبان یا مهمان) را، به همراه مجموع تعداد گل آنها نشان دهد.

## سوال سوم

یک کوئری بنویسید که نام تمام بازیکن‌هایی که تیم آنها قبل از ۱۹۷۵ تاسیس‌ شده را، به همراه اسم تیمشان نشان دهد.

## سوال چهارم

ستونی به نام `result` به جدول `matches` اضافه کنید که بر اساس نتیجهٔ بازی، مقادیر `"win"`، `"lost"` یا ‍‍`"draw"` به خود بگیرد.

# چیزی که باید آپلود کنید.

یک فایل zip، شامل چهار فایل sql آپلود کنید که توی هر فایل، یک کوئری برای خواسته‌های هر سوال موجود باشه. فایل‌هاتون باید بر اساس شماره سوال، به شکل ‍زیر نام‌گذاری بشن:

```
1.sql
2.sql
3.sql
4.sql
```
