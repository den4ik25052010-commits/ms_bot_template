import asyncio
import logging
from aiogram import Bot, Dispatcher, types
from aiogram.filters.command import Command
from aiogram.types import ReplyKeyboardMarkup, KeyboardButton

# Імпортуємо нашу функцію з нового файлу
from file_reader import read_message

# --- Завантаження текстів у змінні з префіксами ---

# Повідомлення, які бачить користувач
MSG_START = read_message('msg_start')
MSG_GREETING = read_message('msg_greeting')
MSG_ABOUT = read_message('msg_about')
MSG_RETURN = read_message('msg_return')
MSG_SITE_URL = read_message('msg_site_url')

# Тексти для кнопок
BTN_HELLO = read_message('btn_hello')
BTN_ABOUT = read_message('btn_about')
BTN_RETURN = read_message('btn_return')
BTN_SITE = read_message('btn_site')

# --- Константи та налаштування ---
BOT_TOKEN = ""  # Вставте сюди ваш токен

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

# --- Ініціалізація бота ---
bot = Bot(token=BOT_TOKEN)
dp = Dispatcher()

# --- Клавіатури ---
# Використовуємо змінні BTN_ для назв кнопок
main_keyboard = ReplyKeyboardMarkup(
    keyboard=[
        [KeyboardButton(text=BTN_HELLO)],
        [KeyboardButton(text=BTN_RETURN)],
        [KeyboardButton(text=BTN_ABOUT)],
        [KeyboardButton(text=BTN_SITE)]
    ],
    resize_keyboard=True
)

# --- Обробники команд та повідомлень ---

@dp.message(Command("start"))
async def handle_start(message: types.Message):
    await message.answer(MSG_START, reply_markup=main_keyboard)

@dp.message(lambda message: message.text == BTN_HELLO)
async def handle_hello_button(message: types.Message):
    await message.answer(MSG_GREETING)

@dp.message(lambda message: message.text == BTN_ABOUT)
async def handle_about_button(message: types.Message):
    await message.answer(MSG_ABOUT)

@dp.message(lambda message: message.text == BTN_RETURN)
async def handle_return_button(message: types.Message):
    await message.answer(MSG_RETURN)

@dp.message(lambda message: message.text == BTN_SITE)
async def handle_site_button(message: types.Message):
    await message.answer(MSG_SITE_URL)

# --- Запуск бота ---
async def main():
    logging.info("Bot is starting...")
    await dp.start_polling(bot)

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        logging.info("Bot was stopped manually.")
