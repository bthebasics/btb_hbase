CREATE TABLE IF NOT EXISTS CUSTOMER (
    CUST_ID BIGINT NOT NULL,
    FNAME VARCHAR(50),
    LNAME VARCHAR(50),
    DOB DATE,
    CITY VARCHAR(30),
    STATE VARCHAR(50) CONSTRAINT PK PRIMARY KEY (CUST_ID)
)
