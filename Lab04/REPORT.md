#№ Отчет по лабораторной работе №4
## по курсу "Логическое программирование"

## Обработка естественного языка

### студент: Плешков А.О.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |     4         |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*


## Введение

Под обработкой естественных языков (Natural Language Processing, NLP) понимается создание систем (словарей), обрабатывающих или “понимающих” язык с целью выполнения определенных задач. Язык Prolog в данном случае удобен своими построениями деревьев вывода и метаправилами.

## Задание

Вариант 1. Работа с генеологическим деревом.

## Принцип решения

Факты:

parent(alexey,tolia).

parent(alexey,volodia).

parent(tolia,tima).

parent(tolia,vova).

parent(tolia,kolya).

Создадим словарь имен из списка (в список входят имена из изначальных фактов по условию задачи + доп. факты), где на первом месте будет стоять будет стоять имя в И.п., на втором – Р.п., на третьем – имя, означающее принадлежность.

slovar_name([tolia,toli,tolin]).

slovar_name([alexey,alexeya,alexeya]).

slovar_name([tima,timi,timin]).

slovar_name([volodia,volodi,volodin]).

slovar_name([vova,vovi,vovin]).

slovar_name([kolya,koli,kolin]).

Далее, создадим проверку на то, является ли два разных человека друг другу братьями – да, в случае если у них одни один и тот же родитель.

brother(X,Y):-parent(Z,X), parent(Z,Y), X\=Y.

Потом реализуем поиск наших братьев – проверяем выполнение предиката brother() и смотрим на наличие имени в нужном форме в slovar_name()

answer([X,brat,Y,'?'],L) :- 

    brother(X,Y1),

    slovar_name([X,_,_]),

    slovar_name([Y1,Y,_]), L='yes',!; X\='chei', X\='kto', L='no'.

answer([kto,X,brat,'?'],L) :- 

    brother(X1,L),

    slovar_name([X1,_,X]).

answer([chei,brat,X,'?'],L) :- 

    brother(X,Y),

    slovar_name([Y,_,L]).

## Результаты

Запросы и выводы:

?-answer([volodia,brat,toli,'?'],X).

X = yes

?-answer([kto,tolin,brat,'?'],X).

X = volodia

false

?-answer([chei,brat,volodia,'?'],X).

X = tolin

false

?-answer([vova,brat,timi,'?'],X).

X = yes

?-answer([kto,kolin,brat,'?'],X).

X = tima

X = vova

false

?-answer([chei,brat,vova,'?'],X).

X = timin

X = kolin

%?-answer([volodia,brat,anna,'?'],X).

X = no

Для того, чтобы не было вывода false можно было ставить отсечение, но в этом случае корректно работало только для начального условия – там у человека либо один брат, либо его вовсе нет.
## Выводы

Анализ естественно-языковых текстов очень удобен в языке Prolog - решение можно разбирать на основе построения деревьев.

Но также есть и недостатки - работа с отсечением довольно сложная, она сказывается на бэктрекинге, из-за чего можно потерять решения
