
-- Update price in shopping_cart when INSERT new item
create  TRIGGER Calculate_Price_Insert
ON shopping_cart
FOR INSERT
	AS
	BEGIN
		-- Calculate Price by quantity
		DECLARE @Price bigint;
		SELECT @Price = p.price * sc.quantity
		FROM shopping_cart sc JOIN product p
			ON sc.pro_id = p.id
		WHERE cus_us IN (SELECT cus_us FROM inserted) AND pro_id IN (SELECT pro_id FROM inserted)
		-- Update the Price to Shopping Cart
		UPDATE shopping_cart
		SET price = @Price
		WHERE cus_us IN (SELECT cus_us FROM inserted) AND pro_id IN (SELECT pro_id FROM inserted)
END

-- -- Update price in shopping_cart when UPDATE quantity of item
create TRIGGER Calculate_Price_Update
ON shopping_cart
FOR UPDATE
	AS
	BEGIN
		-- Calculate Price by quantity
		DECLARE @Price bigint;
		SELECT @Price = p.price * sc.quantity
		FROM shopping_cart sc JOIN product p
			ON sc.pro_id = p.id
		WHERE cus_us IN (SELECT cus_us FROM deleted) AND pro_id IN (SELECT pro_id FROM deleted)
		-- Update the Price to Shopping Cart
		UPDATE shopping_cart
		SET price = @Price
		WHERE cus_us IN (SELECT cus_us FROM deleted) AND pro_id IN (SELECT pro_id FROM deleted)
END

-- Calculate total bill
create TRIGGER Calculate_Total_Bill
ON bill
FOR INSERT
	AS
	BEGIN
		-- Calculate Total of the bill
		DECLARE @Total bigint;
		SELECT @Total = SUM(price)
		FROM shopping_cart
        WHERE cus_us IN (SELECT cus_us FROM inserted)
		-- Update the total
		UPDATE bill
		SET total = @Total
		WHERE id IN (SELECT id FROM inserted) 
END