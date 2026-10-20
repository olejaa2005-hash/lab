# Lab Works Platform (Ruby on Rails 8)

Функціональна платформа для управління лабораторними роботами з розподілом за ролями (`teacher` та `student`).

---

## 🚀 Вимоги для запуску

* **Ruby**: 3.x або новіша
* **Ruby on Rails**: 8.x
* **Database**: SQLite3
* **Package Manager**: Bundler

---

## 🛠 Кроки для запуску проєкту

### 1. Клонування репозиторію
```bash
git clone https://github.com/olejaa2005-hash/lab.git
cd lab
```

### 2. Встановлення залежностей
```bash
bundle install
```

### 3. Налаштування бази даних
Створіть та застосуйте всі міграції бази даних:
```bash
bin/rails db:prepare
```
*(або `bin/rails db:migrate`)*

### 4. Створення користувачів (Викладач та Студент)
Оскільки реєстрація (Sign Up) відсутня за вимогами ТЗ, користувачів необхідно створити через Rails консоль:

Запустіть консоль:
```bash
bin/rails console
```

Створіть викладача та студента:
```ruby
# Створення викладача
User.create!(
  email_address: "teacher@example.com",
  password: "password123",
  role: "teacher"
)

# Створення студента
User.create!(
  email_address: "student@example.com",
  password: "password123",
  role: "student"
)

exit
```

### 5. Запуск веб-сервера
Запустіть локальний сервер розробки:
```bash
bin/rails server
```

Відкрийте браузер і перейдіть за адресою: `http://localhost:3000`

---

## 🔑 Авторизація та функціонал

1. **Логін викладача:**
   * Email: `teacher@example.com`
   * Password: `password123`
   * **Можливості:** створення шаблонів лабораторних робіт із питаннями різних типів (текст, зображення, код), призначення робіт студентам та перегляд/перевірка сданих робіт.

2. **Логін студента:**
   * Email: `student@example.com`
   * Password: `password123`
   * **Можливості:** перегляд призначених лабораторних робіт, відповіді на обов'язкові та необов'язкові запитання, здача роботи на перевірку викладачу.