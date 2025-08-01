#!/bin/bash

# Цей скрипт створює файл README.md з правильним форматуванням,
# щоб уникнути проблем при копіюванні.

cat > README.md << 'EOF'
# Твій перший Telegram-бот на Python! 🤖

Привіт! 👋 Це супер простий шаблон, щоб ти міг швидко створити свого Telegram-бота на Python. Ми використовуємо бібліотеку `aiogram`, а вся магія в тому, що тексти (повідомлення, назви кнопок) лежать окремо від коду. Так набагато легше все міняти і додавати нове, не ламаючи логіку! 😉

---
## Поїхали! Запускаємо все в GitHub Codespaces 🚀

Це найпростіший і найкращий спосіб працювати з цим шаблоном. Ніяких зайвих налаштувань на твоєму комп'ютері!

### Крок 1: Робимо форк (копію) репозиторію

Просто натисни кнопку **"Fork"** вгорі праворуч на сторінці [AlexOrd/ms_bot_template](https://github.com/AlexOrd/ms_bot_template). Або, якщо хочеш, тисни **"Use this template"**. Обидва варіанти підійдуть! 👍

### Крок 2: Запускаємо Codespace

Тепер у твоєму новому репозиторії тисни зелену кнопку **"< > Code"**, вибирай вкладку **"Codespaces"** і клікай **"Create codespace on main"**. Дай йому пару хвилин, щоб усе налаштувати. Можеш поки заварити чайку! ☕

### Крок 3: Додаємо секретний токен

Коли все завантажиться, знайди файл `bot.py`. Там є рядок `BOT_TOKEN = ""`. Саме сюди, між лапками, треба вставити твій токен, який ти отримав від [@BotFather](https://t.me/BotFather).

```python
# bot.py
# --- Константи та налаштування ---
BOT_TOKEN = "СЮДИ-ВСТАВТЕ-ВАШ-ТОКЕН"
```

### Крок 4: Встановлюємо все необхідне

Перед першим запуском давай переконаємося, що всі потрібні бібліотеки встановлено. Введи в термінал цю команду:

```bash
pip install -r requirements.txt
```

Зазвичай Codespaces робить це сам, але про всяк випадок краще перевірити!

### Крок 5: Запускаємо бота!

Тепер все готово! Внизу вже має бути відкритий термінал. Просто введи туди команду:

```bash
python bot.py
```

І вуаля! Якщо побачиш `INFO:aiogram.dispatcher:Bot is starting...`, значить, твій бот живий і працює! 🎉

### Маленька порада: як перезапускати бота

Кожен раз, коли ти щось міняєш у коді (наприклад, додаєш кнопку), бота треба перезапустити. Це просто:

1.  **Зупини його:** У терміналі, де працює бот, натисни `Ctrl + C`.
2.  **Запусти знову:** Введи ту саму команду: `python bot.py`.

---
## Що тут де лежить? (Структура проєкту)

```
.
├── bot.py              # Головний мозок нашого бота, вся логіка тут
├── file_reader.py      # Маленький помічник, що читає тексти з файлів
├── requirements.txt    # Список того, що потрібно для роботи
└── text_messages/      # Скринька з усіма текстами для бота
    ├── msg_start.txt   # Привітання
    └── ...             # І всі інші тексти
```

---
## Додамо щось нове? Наприклад, кнопку "Допомога"

Побачиш, як це легко. Давай додамо кнопку "Допомога" і відповідь на неї.

### Крок 1: Створюємо файлики з текстом

Заходимо в папку `text_messages` і створюємо два нових файли:

* Для назви кнопки: `text_messages/btn_help.txt`
    ```plaintext
    ❓ Допомога
    ```

* Для повідомлення-відповіді: `text_messages/msg_help.txt`
    ```plaintext
    Це повідомлення-довідка. Якщо щось не так, пиши адміну!
    ```

### Крок 2: Оновлюємо код в `bot.py`

Тепер треба сказати боту про ці нові тексти.

1.  **Читаємо тексти в змінні:**
    ```python
    # bot.py
    # ... (де вже є інші змінні)
    MSG_HELP = read_message('msg_help')
    BTN_HELP = read_message('btn_help')
    # ...
    ```

2.  **Додаємо кнопку на клавіатуру:**
    ```python
    # bot.py
    main_keyboard = ReplyKeyboardMarkup(
        keyboard=[
            # ... (тут існуючі кнопки)
            [KeyboardButton(text=BTN_HELP)]  # <-- Ось і наша нова кнопка!
        ],
        resize_keyboard=True
    )
    ```

3.  **Вчимо бота реагувати на цю кнопку:**
    ```python
    # bot.py
    # ... (після інших обробників)

    @dp.message(lambda message: message.text == BTN_HELP)
    async def handle_help_button(message: types.Message):
        await message.answer(MSG_HELP)
    ```

### Крок 3: Перезапускаємо бота

Зберігай зміни, зупиняй бота (`Ctrl + C`) і запускай знову. Готово! Нова кнопка вже має з'явитися в меню.
EOF

echo "✅ README.md було успішно створено!"
