CREATE TABLE mcc_codes (
    mcc_code NVARCHAR(10) PRIMARY KEY,
    description NVARCHAR(255)
);

SELECT * FROM mcc_codes;

CREATE TABLE transactions_fraud (
    transaction_id NVARCHAR(20) PRIMARY KEY,
    fraud NVARCHAR(10)
);

SELECT * FROM transactions_fraud;

