


USE cars_tk_db;

-- скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);

select reg.name, sum(price) as 'сумма стоимости авто на балансе по регионам'
from Cars r
         inner join Category c on r.category_id = c.category_id
         inner join Region reg on r.code = reg.code
group by reg.name;

select (select name from Driver where Cars.driver_id = Driver.driver_id) as 'Водитель',
       color,
       numbers,
       model,
       price
from Cars;       


-- Седаны в Москве
CREATE OR REPLACE VIEW
    sedan_in_moscow
as
select c.name, reg.name region, color, model, price
from Cars r
         inner join Category c on r.category_id = c.category_id
         inner join Region reg on r.code = reg.code
where reg.code = 2
  and c.category_id = 1;
;

-- Все авто
CREATE OR REPLACE VIEW
    present_all_cars
as
select c.name, reg.name region, color, model, price
from Cars r
         inner join Category c on r.category_id = c.category_id
         inner join Region reg on r.code = reg.code;
;

select *
from sedan_in_moscow;

select *
from present_all_cars;


-- хранимые процедуры / триггеры;

DELIMITER //

-- Процедура увеличивает счетчик, категория авто, при добавлении авто

CREATE PROCEDURE `increment_count_cars_by_type`(IN type2 INT)
BEGIN
    set @currentCnt = 0;
    select count into @currentCnt from TotalCars where TotalCars.type = type2;
    IF @currentCnt is null then
        insert into TotalCars (count, type) values (1, type2);
    ELSE
        update TotalCars set count = @currentCnt where TotalCars.type = type2;
    END IF;
END//

-- триггер срабатывает при добавлении записи авто и вызывает процедуру increment_count_cars_by_type
DROP TRIGGER IF EXISTS count_cars;
CREATE TRIGGER count_cars after insert ON Cars
    FOR EACH ROW BEGIN
    call increment_count_cars_by_type(new.category_id);
END//