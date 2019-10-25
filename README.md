# GMT. Pilot: Ninja Coders

## Концепт

Концепт игры xonix.

https://www.youtube.com/watch?v=zJCbKPNEnF8

Есть поле, на нем в произвольных направлениях двигаются какие-то враги.
Есть персонаж (игрок). Его задача обрезать поля до тех пор, пока не останется < 10% покрытия
Враги могут двигаться в любом направлении. Персонаж только по вертикали и по горизонтали.
Кусок поля считается срезанным только тогда, когда персонаж замкнул лини.

Если враг пересекает не замкнутую линию - персонаж погибает.
Если персонаж обрезает кусок поля с врагом - враг погибает.

## Задание

Сейчас вам доступно: поле, персонаж, враги, цикл движения врагов.

Необходимо:
- Добавить интерфейс для персонажа. 
В качестве интерфейса можете рассмотреть свайп (вниз/вверх и вправо/влево), либо кнопки "джойстик". Можете свой вариант придумать.
Т.е. при нажатии "вправо", персонаж начинает движение вправо и не останавливается, пока а) не поменяет направление б) не обрежет кусок поля или в) не умрет
- Добавить функционал обрезания поля.
Сейчас вам доступна уже подложка (GameView) и доска (Board), персонаж создается на подложке и должен обрезать доску, враги двигаются только по доске.
Обрезание должно быть визуально отображено, т.е. доска после таких действий может уже стать не прямоугольной.
Также должен оставаться "шлейф" - путь, по которому идет обрезание, пока оно не завершено.
- Добавить функционал смерти. 
Игрок должен погибать (можно перманентно всё останавливать или просто удалять представление с иерархии, без разницы) в случае если достигается такое условие (т.е. на этапе обрезания его путь пересекает враг).

## Оценивание

Оценка будет производится в несколько этапов. Каждый участник будет набирать определенное кол-во балов. 
Побеждают первые три места в топе по сумме баллов.

## Критерии оценки

Далее перечислены критерии по которым будет производится оценка.  В порядке убывания важности.

- Оценка зрителей. Каждый зритель выбирает свои топ-3, оценки суммируются
*Шкала*: 0 - 100
*Коэффициент составляющей*:  `35%`

- Оценка жюри - визуальная составляющая
*Шкала*: 0 - 100
*Коэффициент составляющей*:  `35%`

- Оценка жюри - функциональная составляющая 
*Шкала*: 0 - 100
*Коэффициент составляющей*:  `20%`

- Оценка жюри - аудит кода
*Шкала*: 0 - 100
*Коэффициент составляющей*:  `10%`


Такое кол-во критериев необходимо для того, чтобы две визуально схожие работы всё-таки можно было сравнить.

Но, как видно из списка выше, самое главное это **симпатии зрителей и жюри**, которые основываются на визуальной составляющей,
Так что если у вас есть время добавьте интерфейс (например, жизни), либо сделайте какие-то эффекты (например, смерть). То, что может отличить вашу работу от других участников.

## Участие

На старте будет доступна ссылка на репозиторий.
В этом репозитории будет находится проект на начальной стадии.

Для анонимизации работы, вам необходимо выбрать **число в диапазоне 0...10_000** и создать ветку вида *user_NUMBER*

Создавайте ветку прямо в гитхабе перед пулом проекта, чтобы не было коллизий имен.

Также, большая просьба не оставлять имена в хедера файлов, если вы будете их создавать. Создание совсем не требуется, т.к. все файлы уже есть, но если создаёте - подчищайте. Оценка должна быть **независимой**.

## Отправка

По истечению 2х часов **репозиторий закрывается** на пуши и стартует проверка. Кто не успел тот опоздал

