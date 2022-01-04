## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | ??? |

Будет ошибка

```
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unsupported operand type(s) for +: 'int' and 'str'
```

| Вопрос  | Ответ |
| ------------- | ------------- |
| Как получить для переменной `c` значение 12?  | `c =  str(a) + b`  |
| Как получить для переменной `c` значение 3?  | `c = a + int(b)`  |


## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
import os

def check_git(dir):
    bash_command = [f"cd {dir}", "git status"]
    result_os = os.popen(' && '.join(bash_command)).read()
    is_change = False
    prepare_result = []
    print(f"Рабочая директория {dir}")
    for result in result_os.split('\n'):
        if result.find('modified') != -1:
            prepare_result.append(result.replace('\tmodified:   ', ''))
            is_change = True

    if is_change:
        print("Изменены файлы:\n" + "\n".join(prepare_result))

work_dir = r"C:\Users\dmozo\Desktop\devops-netology"
check_git(work_dir)
```

### Вывод скрипта при запуске при тестировании:
```
$ python 04-script-02-py/script/main.py 
Рабочая директорий C:\Users\dmozo\Desktop\devops-netology
Изменены файлы
.gitignore
03-sysadmin-08-net/README.md
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
import os
import sys

def check_dir(dir):
    try:
        os.chdir(dir)
    except FileNotFoundError:
        print("Директория не найдена")
        sys.exit(1)

def check_git(dir):
    print(f"Рабочая директория {dir}")
    check_dir(dir)
    result_os = os.popen("git status").read()
    if not result_os:
        print("В папке не обнаружена инициализация git")
        sys.exit(1)
    is_change = False
    prepare_result = []
    for result in result_os.split('\n'):
        if result.find('modified') != -1:
            prepare_result.append(result.replace('\tmodified:   ', ''))
            is_change = True
    if is_change:
        print("Изменены файлы:\n" + "\n".join(prepare_result))
    else:
        print("Изменений не найдено")

check_git(sys.argv[1])

```

### Вывод скрипта при запуске при тестировании:
```
dmozo@twiss MINGW64 ~/Desktop/devops-netology (main)
$ python 04-script-02-py/script/main.py "C:\Users\dmozo\Desktop"
Рабочая директория C:\Users\dmozo\Desktop
fatal: not a git repository (or any of the parent directories): .git
В папке не обнаружена инициализация git

dmozo@twiss MINGW64 ~/Desktop/devops-netology (main)
$ python 04-script-02-py/script/main.py "C:\Users\dmozo\Desktop\devops-netology"
Рабочая директория C:\Users\dmozo\Desktop\devops-netology
Изменены файлы:
.gitignore
03-sysadmin-08-net/README.md
```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
import socket
import time
import datetime
import logging
i = 1
wait = 2  # интервал проверок в секундах
srv = {
    'drive.google.com': '0.0.0.0',
    'mail.google.com': '0.0.0.0',
    'google.com': '0.0.0.0'
}

print(f"Start script\nCheck hosts {srv}\n")

while True:
    for host in srv:
        ip = socket.gethostbyname(host)
        if ip != srv[host]:
            logging.error(f'{datetime.datetime.now()} {host} IP mistmatch: {srv[host]} -> {ip}')
            srv[host] = ip
    time.sleep(wait)

```

### Вывод скрипта при запуске при тестировании:
```
Start script
Check hosts {'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}

ERROR:root:2022-01-04 21:29:31.493592 drive.google.com IP mistmatch: 0.0.0.0 -> 142.250.74.46
ERROR:root:2022-01-04 21:29:31.493592 mail.google.com IP mistmatch: 0.0.0.0 -> 142.250.74.101
ERROR:root:2022-01-04 21:29:31.494592 google.com IP mistmatch: 0.0.0.0 -> 142.250.74.142
```