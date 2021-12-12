1. Есть скрипт:
	```bash
	a=1
	b=2
	c=a+b
	d=$a+$b
	e=$(($a+$b))
	```
	* Какие значения переменным c,d,e будут присвоены?
	* Почему?

Ответ:

    netologe1@vagrant:~$     a=1
        b=2
        c=a+b
        d=$a+$b
        e=$(($a+$b))
    netologe1@vagrant:~$ echo $c
    a+b
    netologe1@vagrant:~$ echo $d
    1+2
    netologe1@vagrant:~$ echo $e
    3

в первых двух переменных не происходит никаких действий т.к. изначально в баше все значения являются строковыми 
в 3 случае благодаря скобкам происходит сложение переменны `a + b`

2. На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным. В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
	```bash
	while ((1==1)
        do
            curl https://localhost:4757
            if (($? != 0))
                then
                    date >> curl.log
                fi
	    done
    ```

Ответ:

Допущенна синтаксическая ошибка, операции с циклами оборачиваются квадратными скобками, так же добавил sleep 60 для проверка раз в минуту

```bash
while [ 1=1 ]
    do
        curl https://localhost:4757
        if [ $? != 0 ]
                then
                    date >> curl.log
                fi
        sleep 60
    done
```


3. Необходимо написать скрипт, который проверяет доступность трёх IP: 192.168.0.1, 173.194.222.113, 87.250.250.242 по 80 порту и записывает результат в файл log. Проверять доступность необходимо пять раз для каждого узла.

Ответ:

```bash
while [ 1=1 ]
do  
    
    for i in 192.168.0.1 173.194.222.113 87.250.250.242
    do 
        for ((j=0;j < 5;j++))
        do
        curl http://$i
            
        if [ $? != 0 ]
                then
                    date >> curl.log
                    echo $i >> curl.log
                fi
        sleep 1
        done
    done
    sleep 20
done 
```

4. Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается

```bash
while [ 1=1 ]
do  
    
    for i in 192.168.0.1 173.194.222.113 87.250.250.242
    do 
        for ((j=0;j < 5;j++))
        do
        curl http://$i
            
        if [ $? != 0 ]
            then
                date >> curl.log
                echo ERROR $i  >> curl.log
                exit
            fi
        sleep 1
        done
    done
    sleep 20
done
```