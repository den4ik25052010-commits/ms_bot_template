import os
import logging

def read_message(file_name: str) -> str:
    """Читає текст з файлу в папці text_messages."""
    path = os.path.join('text_messages', f'{file_name}.txt')
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return f.read().strip()
    except FileNotFoundError:
        logging.error(f"Файл не знайдено: {path}")
        return f"Помилка: Текст для '{file_name}' не знайдено."
    except Exception as e:
        logging.error(f"Помилка при читанні файлу {path}: {e}")
        return f"Помилка читання файлу: {file_name}"
