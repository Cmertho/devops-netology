# Домашнее задание к занятию "5.5. Оркестрация кластером Docker контейнеров на примере Docker Swarm"

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---

## Задача 1

Дайте письменые ответы на следующие вопросы:

- В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?

Для реплицированного сервиса вы указываете, сколько идентичных задач хотите запустить, а для глобального задача запускается на каждой ноде. Каждый раз, когда мы добавляем ноду в swarm, оркестратор создает задачу, а планировщик назначает задачу новой ноде.
- Какой алгоритм выбора лидера используется в Docker Swarm кластере?

Алгоритм [Raft](https://raft.github.io/)
- Что такое Overlay Network?

Overlay-сеть создает подсеть, которую могут использовать контейнеры в разных хостах swarm-кластера. Контейнеры на разных физических хостах могут обмениваться данными по overlay-сети

## Задача 2

Создать ваш первый Docker Swarm кластер в Яндекс.Облаке

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
[root@node01 centos]# docker node ls
ID                            HOSTNAME             STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
njiaq8b71obcs8z0798l6konk *   node01.netology.yc   Ready     Active         Reachable        20.10.12
3za2fnx73cctgwiinvehltrrt     node02.netology.yc   Ready     Active         Reachable        20.10.12
yj7zvo3t8tmpt2ljn5aqwdia9     node03.netology.yc   Ready     Active         Leader           20.10.12
d0uesz5xpe8vt6pn0sb5x6z8q     node04.netology.yc   Ready     Active                          20.10.12
zpezqod7e11k1hy222fkbktcg     node05.netology.yc   Ready     Active                          20.10.12
5gtj93ej2x1xrkfocjyte5syt     node06.netology.yc   Ready     Active                          20.10.12
```

## Задача 3

Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
[root@node01 centos]# docker service ls
ID             NAME                                MODE         REPLICAS   IMAGE                                          PORTS
obnk45nzxjpf   swarm_monitoring_alertmanager       replicated   1/1        stefanprodan/swarmprom-alertmanager:v0.14.0
nsq6as932p8a   swarm_monitoring_caddy              replicated   1/1        stefanprodan/caddy:latest                      *:3000->3000/tcp, *:9090->9090/tcp, *:9093-9094->9093-9094/tcp
500txfzqvwv1   swarm_monitoring_cadvisor           global       6/6        google/cadvisor:latest
9nvcq9q2k4pa   swarm_monitoring_dockerd-exporter   global       6/6        stefanprodan/caddy:latest
upzp7hogvjlx   swarm_monitoring_grafana            replicated   1/1        stefanprodan/swarmprom-grafana:5.3.4
iefiiojcui8b   swarm_monitoring_node-exporter      global       6/6        stefanprodan/swarmprom-node-exporter:v0.16.0
p7vapetle1vr   swarm_monitoring_prometheus         replicated   1/1        stefanprodan/swarmprom-prometheus:v2.5.0
8ji4c85ojg4i   swarm_monitoring_unsee              replicated   1/1        cloudflare/unsee:v0.8.0
[root@node01 centos]#
```
