/*
	DELIMITER &&
    DROP TRIGGER IF EXISTS [triggerName];
	CREATE TRIGGER [triggername] [EventTime] [Event] ON [TableName] FOR EACH ROW
    BEGIN
		Block statement;
    END &&
    DELIMITER &&
    
    EventTime: AFTER | BEFORE
    Event: INSERT | UPDATE | DELETE
*/
-- Tạo trigger before insert để kiểm tra giá sản phẩm: Giá sp phải lớn 100
DELIMITER &&
CREATE TRIGGER before_insert_Product BEFORE INSERT ON Product FOR EACH ROW
BEGIN
	-- Lay ra gia san pham them moi
    Declare price float default 0;
    select NEW.price into price;
    -- Kiem tra dieu kien gia san pham
    IF price <=100 THEN
		SIGNAL sqlstate '45000' set message_text = 'Price <=100, trigger dung insert';
    END IF;
END &&
DELIMITER &&
select * from product;
insert into Product(productname,price,catalogid)
values('Java 08 - 1',150,3);
insert into Product(productname,price,catalogid)
values('Java 08 - 2',60,3);
update product
set price = 80
where Productid = 9;
