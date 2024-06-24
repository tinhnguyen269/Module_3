-- TH3:-----------------------------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE getCusById

(IN cusNum INT(11))

BEGIN

  SELECT * FROM customers WHERE customerNumber = cusNum;

END //

DELIMITER ; 
call getCusById(103);
-- ---------------------------------------------------------------------------------------
