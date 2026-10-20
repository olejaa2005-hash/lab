1. КЛОНУВАННЯ ТА ПЕРЕХІД У ДИРЕКТОРІЮ:

   git clone https://github.com/olejaa2005-hash/lab.git

   cd lab



2. ВСТАНОВЛЕННЯ ЗАЛЕЖНОСТЕЙ:

   bundle install



3. МІГРАЦІЯ БАЗИ ДАНИХ:

   bin/rails db:prepare



4. СТВОРЕННЯ КОРИСТУВАЧІВ (ЧЕРЕЗ RAILS CONSOLE):

   Запустіть консоль:

     bin/rails console



   Виконайте Ruby-код для створення тестових облікових записів:

     User.create!(email_address: "teacher@gmail.com", password: "123456", role: "teacher")

     User.create!(email_address: "student@gmail.com", password: "123456", role: "student")

     exit



5. ЗАПУСК СЕРВЕРА:

bin/rails server



6. ВІДКРИЙТЕ В БРАУЗЕРІ:

http://localhost:3000


ДАНІ ДЛЯ ВХОДУ:

Викладач:  teacher@gmail.com / 123456

Студент:   student@gmail.com / 123456

