CREATE TABLE IF NOT EXISTS ORDERS (
    ORDER_ID BIGINT NOT NULL,
    CUST_ID BIGINT NOT NULL,
    ORDER_DATE DATE,
    AMOUNT DECIMAL,
    QUANTITY BIGINT CONSTRAINT PK PRIMARY KEY (ORDER_ID,CUST_ID)
) IMMUTABLE_ROWS = true