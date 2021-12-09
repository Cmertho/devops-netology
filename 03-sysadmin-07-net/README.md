1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?

Ответ:

    root@netology2:/home/vagrant# ip a
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
        valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host
        valid_lft forever preferred_lft forever
    2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
        link/ether 08:00:27:73:60:cf brd ff:ff:ff:ff:ff:ff
        inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
        valid_lft 86212sec preferred_lft 86212sec
        inet6 fe80::a00:27ff:fe73:60cf/64 scope link
        valid_lft forever preferred_lft forever
    3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
        link/ether 08:00:27:bc:90:60 brd ff:ff:ff:ff:ff:ff
        inet 172.28.128.60/24 scope global eth1
        valid_lft forever preferred_lft forever
        inet6 fe80::a00:27ff:febc:9060/64 scope link
        valid_lft forever preferred_lft forever
    Linux
    ip a, ifconfig
    Windows 
    ipconfig /all


2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?

Ответ:

    lldp 
    sudo apt install lldpd
    systemctl enable lldpd && systemctl start lldpd


3. Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.

Ответ:

    vlan 
    apt-get install vlan
    cat /etc/network/interfaces
    auto vlan80
    iface vlan80 inet static        
        address 10.0.3.1        
        netmask 255.255.255.0        
        vlan_raw_device eth0
    auto eth0.80 iface eth0.80 
        inet static        
        address 10.0.3.1       
        netmask 255.255.255.0        
        vlan_raw_device eth0

4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.        

Ответ:

    Статический и динамический 
    auto bond0

    iface bond0 inet static
        address 10.31.1.5
        netmask 255.255.255.0
        network 10.31.1.0
        gateway 10.31.1.254
        bond-slaves eth0 eth1
        bond-mode active-backup
        bond-miimon 100
        bond-downdelay 200
        bond-updelay 200

5. Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.

Ответ:

    6 хостов с маской /29
    42шт подситей из 24 маски
    10.10.10.1-6/29
    10.10.10.8-14/29

6. Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.

Ответ:

    100.64.0.0/26

7. Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?

Ответ:

    linux
    ip neigh
    windows
    arp -a

    Очистить ARP кеш 
    ip neigh flush all

    Очистить ненужный ip
    arp -d 192.168.100.25