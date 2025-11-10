drop table FactTransaction, DimMerchantCategory, DimDate, DimCard, DimCustomer;
-- Dimentions tables
use transactions_warehouse;
CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    Gender NVARCHAR(10), 
    CurrentAge INT,
    YearlyIncome DECIMAL(18,2),
    CreditScore INT,
    NumberOfCreditCards INT,
    CreatedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE DimCard (
    CardKey INT IDENTITY(1,1) PRIMARY KEY,
    CardID INT NOT NULL,
    CardType NVARCHAR(60),
    CardLimit DECIMAL(18,2),
    ActivationDate DATE,
    ExpiryDate DATE,
    Status NVARCHAR(20)
);

CREATE TABLE DimMerchantCategory (
    MerchantKey INT IDENTITY(1,1) PRIMARY KEY,
    MCCCode NVARCHAR(10) NOT NULL,
    MCCDescription NVARCHAR(255),
    CategoryType NVARCHAR(100)
);

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    Year INT NOT NULL,
    Month INT NOT NULL,
    Day INT NOT NULL
);

-- Fact Table
CREATE TABLE FactTransaction (
    TransactionKey INT IDENTITY(1,1) PRIMARY KEY,
    TransactionID NVARCHAR(50) NOT NULL,
    CustomerKey INT NOT NULL,
    CardKey INT NOT NULL,
    MerchantKey INT NOT NULL,
    DateKey INT NOT NULL,
    Amount DECIMAL(18,2),
    TransactionType NVARCHAR(50),
    MCCCode NVARCHAR(10),
    Timestamp DATETIME,
    FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),
    FOREIGN KEY (CardKey) REFERENCES DimCard(CardKey),
    FOREIGN KEY (MerchantKey) REFERENCES DimMerchantCategory(MerchantKey),
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey)
);

SELECT * FROM DimCard;
SELECT * FROM DimCustomer;
SELECT * FROM DimMerchantCategory;
SELECT * FROM DimDate;
SELECT * FROM FactTransaction;

-- DimDate
INSERT INTO DimDate (DateKey, FullDate, Year, Month, Day)
SELECT
    CONVERT(INT, CONVERT(VARCHAR, DateValue, 112)) as DateKey,
    DateValue as FullDate,
    YEAR(DateValue) as Year,
    MONTH(DateValue) as Month,
    DAY(DateValue) as Day
FROM (
    SELECT DATEADD(DAY, number, '2010-01-01') as DateValue
    FROM master..spt_values 
    WHERE type = 'P' 
    AND DATEADD(DAY, number, '2010-01-01') <= '2019-12-31'
) dates
ORDER BY DateValue;


