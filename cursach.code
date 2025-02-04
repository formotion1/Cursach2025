import tkinter as tk
from tkinter import ttk, messagebox
import pyodbc

# Подключение к базе данных
connection = None

def connect_to_database():
    """Функция подключения к базе данных"""
    global connection
    username = username_entry.get()
    password = password_entry.get()

    try:
        connection = pyodbc.connect(
            f"DRIVER={{ODBC Driver 17 for SQL Server}};"
            f"SERVER=Comp1;"
            f"DATABASE=ARMY;"
            f"UID={username};"
            f"PWD={password};"
        )
        messagebox.showinfo("Успех", f"Добро пожаловать, {username}!")
        login_window.destroy()  # Закрытие окна авторизации
        main_window()  # Открытие главного окна приложения

    except pyodbc.Error as e:
        messagebox.showerror("Ошибка подключения", f"Ошибка: {e}")

def load_data():
    """Функция для загрузки данных из таблицы Draft_Board"""
    if connection is None:
        messagebox.showerror("Ошибка", "Нет соединения с базой данных!")
        return []

    try:
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM Draft_Board")
        rows = cursor.fetchall()
        cursor.close()  # Закрываем курсор

        formatted_rows = []
        for row in rows:
            row = list(row)  # Преобразуем кортеж в список для изменения данных
            if isinstance(row[1], (pyodbc.Date, pyodbc.Timestamp)):
                row[1] = row[1].strftime("%Y-%m-%d")  # Преобразуем дату в строку
            formatted_rows.append(tuple(row))  # Преобразуем обратно в кортеж

        return formatted_rows

    except Exception as e:
        messagebox.showerror("Ошибка загрузки данных", str(e))
        return []

def main_window():
    """Основное окно приложения"""
    global root, tree
    root = tk.Tk()
    root.title("Главнокомандующий - Просмотр набора рекрутов")
    root.geometry("1400x400")
    center_window(root)

    # Определение колонок
    columns = ("id_draft_board", "Date_draft", "Recruit_status", "Recruit_info", "Commissar_info", "Doctor_info")
    tree = ttk.Treeview(root, columns=columns, show="headings")

    # Заголовки колонок
    for col in columns:
        tree.heading(col, text=col)
        tree.column(col, width=150, anchor="center")

    tree.pack(fill="both", expand=True)

    # Заполняем таблицу сразу при запуске
    data = load_data()
    for row in data:
        tree.insert("", "end", values=row)

    root.mainloop()

def center_window(window):
    """Функция для центрирования окна"""
    window.update_idletasks()
    width = window.winfo_width()
    height = window.winfo_height()
    screen_width = window.winfo_screenwidth()
    screen_height = window.winfo_screenheight()
    x = (screen_width // 2) - (width // 2)
    y = (screen_height // 2) - (height // 2)
    window.geometry(f'{width}x{height}+{x}+{y}')

def login_screen():
    """Окно авторизации"""
    global login_window, username_entry, password_entry

    login_window = tk.Tk()
    login_window.title("Авторизация")
    login_window.geometry("300x200")
    center_window(login_window)

    tk.Label(login_window, text="Логин:").pack(pady=5)
    username_entry = tk.Entry(login_window)
    username_entry.pack(pady=5)

    tk.Label(login_window, text="Пароль:").pack(pady=5)
    password_entry = tk.Entry(login_window, show="*")
    password_entry.pack(pady=5)

    tk.Button(login_window, text="Войти", command=connect_to_database).pack(pady=10)

    login_window.mainloop()

# Запуск программы
login_screen()

