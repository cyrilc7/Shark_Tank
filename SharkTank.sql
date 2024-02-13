        -- **DATA CLEANING AND PREPROCESSING** --

-- Clean columns to change data type properly --
UPDATE SharkTank.dbo.sharktank
SET Original_Offered_Equity = REPLACE(Original_Offered_Equity, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Total_Deal_Equity = REPLACE(Total_Deal_Equity, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Equity_Per_Shark = REPLACE(Equity_Per_Shark, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Barbara_Corcoran_Investment_Equity = REPLACE(Barbara_Corcoran_Investment_Equity, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Kevin_O_Leary_Investment_Equity = REPLACE(Kevin_O_Leary_Investment_Equity, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Mark_Cuban_Investment_Equity = REPLACE(Mark_Cuban_Investment_Equity, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Lori_Greiner_Investment_Equity = REPLACE(Lori_Greiner_Investment_Equity, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Daymond_John_Investment_Equity = REPLACE(Daymond_John_Investment_Equity, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Robert_Herjavec_Investment_Equity = REPLACE(Robert_Herjavec_Investment_Equity, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Investment_Amount_Per_Shark = REPLACE(Investment_Amount_Per_Shark, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Mark_Cuban_Investment_Amount = REPLACE(Mark_Cuban_Investment_Amount, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Lori_Greiner_Investment_Amount = REPLACE(Lori_Greiner_Investment_Amount, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Robert_Herjavec_Investment_Amount = REPLACE(Robert_Herjavec_Investment_Amount, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Daymond_John_Investment_Amount = REPLACE(Daymond_John_Investment_Amount, ',', '.')
UPDATE SharkTank.dbo.sharktank
SET Kevin_O_Leary_Investment_Amount = REPLACE(Kevin_O_Leary_Investment_Amount, ',', '.')

-- Change data types of relevant columns --
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Season_Number TINYINT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Original_Ask_Amount INT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Original_Offered_Equity FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Valuation_Requested INT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Got_Deal TINYINT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Total_Deal_Amount INT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Total_Deal_Equity FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Deal_Valuation INT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Number_of_sharks_in_deal TINYINT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Investment_Amount_Per_Shark FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Equity_Per_Shark FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Royalty_Deal TINYINT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Loan INT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Barbara_Corcoran_Investment_Amount INT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Barbara_Corcoran_Investment_Equity FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Mark_Cuban_Investment_Amount FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Mark_Cuban_Investment_Equity FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Lori_Greiner_Investment_Amount FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Lori_Greiner_Investment_Equity FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Robert_Herjavec_Investment_Amount FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Robert_Herjavec_Investment_Equity FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Daymond_John_Investment_Amount FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Daymond_John_Investment_Equity FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Kevin_O_Leary_Investment_Amount FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Kevin_O_Leary_Investment_Equity FLOAT;
ALTER TABLE SharkTank.dbo.sharktank
ALTER COLUMN Multiple_Entrepreneurs TINYINT;

-- Seperate Product from 'Business Description' Column --
SELECT 
    SUBSTRING(Business_Description, CHARINDEX('-', Business_Description) + 2, LEN(Business_Description)) AS Product
FROM 
    [SharkTank].[dbo].[sharktank]

-- Seperate into several tables for more clarity --
SELECT Season_Number, Startup_Name, Industry, SUBSTRING(Business_Description, CHARINDEX('-', Business_Description) + 2, LEN(Business_Description)) AS Product
INTO SharkTank.dbo.BusinessInfo
FROM SharkTank.dbo.sharktank

SELECT Season_Number, Startup_Name, Original_Ask_Amount, Original_Offered_Equity, Valuation_Requested, Got_Deal, Total_Deal_Amount, Total_Deal_Equity, Deal_Valuation
INTO SharkTank.dbo.DealInfo
FROM SharkTank.dbo.sharktank

SELECT Season_Number, Startup_Name, Number_of_sharks_in_deal, Investment_Amount_Per_Shark, Equity_Per_Shark, Royalty_Deal, Barbara_Corcoran_Investment_Amount, Barbara_Corcoran_Investment_Equity, Mark_Cuban_Investment_Amount, Mark_Cuban_Investment_Equity, Lori_Greiner_Investment_Amount, Lori_Greiner_Investment_Equity, Robert_Herjavec_Investment_Amount, Robert_Herjavec_Investment_Equity, Daymond_John_Investment_Amount, Daymond_John_Investment_Equity, Kevin_O_Leary_Investment_Amount, Kevin_O_Leary_Investment_Equity
INTO SharkTank.dbo.InvesterInfo
FROM SharkTank.dbo.sharktank

-- Add few columns to relevant data
ALTER TABLE SharkTank.dbo.InvesterInfo
ADD Mark_Cuban_Present INT,
    Barbara_Corcoran_Present INT,
    Kevin_O_Leary_Present INT,
    Daymond_John_Present INT,
    Lori_Greiner_Present INT,
    Robert_Herjavec_Present INT
UPDATE InvesterInfo
SET Mark_Cuban_Present = SharkTank.Mark_Cuban_Present,
    Barbara_Corcoran_Present = SharkTank.Barbara_Corcoran_Present,
    Kevin_O_Leary_Present = SharkTank.Kevin_O_Leary_Present,
    Daymond_John_Present = SharkTank.Daymond_John_Present,
    Lori_Greiner_Present = SharkTank.Lori_Greiner_Present,
    Robert_Herjavec_Present = SharkTank.Robert_Herjavec_Present
FROM SharkTank.dbo.InvesterInfo
INNER JOIN SharkTank.dbo.sharktank
ON InvesterInfo.Startup_Name = sharkTank.Startup_Name;


SELECT Season_Number, Startup_Name, Pitchers_Gender, Multiple_Entrepreneurs
INTO SharkTank.dbo.PitchersInfo
FROM SharkTank.dbo.sharktank

        -- **DATA ANALYSIS** --

-- Q1. How many deals have been made total? --
SELECT COUNT(*) AS Total_Number_of_Pitches
FROM SharkTank.dbo.DealInfo;
SELECT COUNT(*) AS Total_Number_of_Deals
FROM SharkTank.dbo.DealInfo
WHERE Got_Deal = 1;
SELECT ROUND(COUNT(CASE WHEN Got_Deal = 1 THEN 1 END) * 100.0 / COUNT(*), 2) AS Deal_Percentage
FROM SharkTank.dbo.DealInfo;
    -- Out of the Total_Number_of_Pitches = 1290 Pitches, 
    -- Total_Number_of_Deals = 775 have gotten a deal
    -- Which means a Deal_Percentage of 60.08%


-- Q2. What are the smallest, biggest, and average deals? --
SELECT 
    (
        SELECT TOP 1 Startup_Name
        FROM SharkTank.dbo.DealInfo 
        ORDER BY Total_Deal_Amount ASC
    ) AS Smallest_Deal,
    ROUND(MIN(Total_Deal_Amount), 0) AS Smallest_Deal,
    (
        SELECT TOP 1 Startup_Name
        FROM SharkTank.dbo.DealInfo 
        ORDER BY Total_Deal_Amount DESC
    ) AS Biggest_Deal,
    ROUND(MAX(Total_Deal_Amount), 0) AS Biggest_Deal,
    ROUND(AVG(Total_Deal_Amount), 0) AS Average_Deal
FROM 
    SharkTank.dbo.DealInfo;
    -- Smallest_Deal = $10,000.00 - Wispots
    -- Biggest_Deal = $5,000,000.00 - AirCar
    -- Average_Deal = $294,952.00

-- Q3. What is the biggest industry? --
WITH IndustryDealAmount AS (
    SELECT 
        bus.Industry,
        SUM(deal.Total_Deal_Amount) AS Total_Deal_Amount
    FROM 
        BusinessInfo AS bus
    JOIN 
        DealInfo AS deal ON bus.Startup_Name = deal.Startup_Name
    WHERE 
        deal.Got_Deal = 1
    GROUP BY 
        bus.Industry
)
SELECT 
    Industry,
    Total_Deal_Amount
FROM 
    IndustryDealAmount
ORDER BY 
    Total_Deal_Amount DESC;
    -- The biggest Industry is 'Food and Beverage' with $52.401.000

-- Q4. What is the biggest valuation difference? --
SELECT 
    (SELECT COUNT(*) FROM SharkTank.dbo.DealInfo) AS Total_Number_Of_Startups,
    (SELECT COUNT(*) 
     FROM (
         SELECT Deal_Valuation - Valuation_Requested AS Valuation_Difference
         FROM SharkTank.dbo.DealInfo
     ) AS SubQuery
     WHERE Valuation_Difference != 0) AS Total_Startups_With_Valuation_Change;
    -- Out of the 1290 startups, 675 of them seem to have misevaluated their company
SELECT 
    (
        SELECT TOP 1 Startup_Name
        FROM SharkTank.dbo.DealInfo 
        ORDER BY Deal_Valuation - Valuation_Requested DESC
    ) AS Startup_Biggest_Increase,
    MAX(Deal_Valuation - Valuation_Requested) AS Biggest_Increase,
    (
        SELECT TOP 1 Startup_Name 
        FROM SharkTank.dbo.DealInfo 
        ORDER BY Deal_Valuation - Valuation_Requested ASC
    ) AS Startup_Biggest_Decrease,
    MIN(Deal_Valuation - Valuation_Requested) AS Biggest_Decrease
FROM 
    SharkTank.dbo.DealInfo;
    -- 'OatMeals' underestimated its company the most by $12.500.000 and 'Wispots' has overestimated its company the most by $25.000.000

-- Q5. Which industry has got the best success rate? --
SELECT 
    bus.Industry,
    COUNT(*) AS Number_of_Industry,
    COUNT(CASE WHEN deal.Got_Deal = 1 THEN 1 END) AS Number_of_Successful_Pitches,
    FORMAT((COUNT(CASE WHEN deal.Got_Deal = 1 THEN 1 END) * 100.0 / COUNT(*)), 'N2') AS Success_Rate
FROM 
    BusinessInfo AS bus
JOIN 
    DealInfo AS deal ON bus.Startup_Name = deal.Startup_Name
GROUP BY 
    bus.Industry
ORDER BY 
    Success_Rate DESC;
    -- The 'Automotive ' industry has the highest success rate with 76.47% while 'Electronics' is the lowest with 40%


-- Q6. How does the gender of pitchers influence the succes rate of the deal? --
SELECT *
FROM SharkTank.dbo.PitchersInfo
WHERE Pitchers_Gender IS NULL
    -- We have 7 Null Values so we are gonna fill them in (by researching on the internet)
UPDATE SharkTank.dbo.PitchersInfo
SET Pitchers_Gender = 'Male'
WHERE Startup_Name = 'Rumpl'
UPDATE SharkTank.dbo.PitchersInfo
SET Pitchers_Gender = 'Male'
WHERE Startup_Name = 'PNuffCrunch'
UPDATE SharkTank.dbo.PitchersInfo
SET Pitchers_Gender = 'Male'
WHERE Startup_Name = 'AnimatedLure'
UPDATE SharkTank.dbo.PitchersInfo
SET Pitchers_Gender = 'Mixed Team'
WHERE Startup_Name = 'SurpriseCake'
UPDATE SharkTank.dbo.PitchersInfo
SET Pitchers_Gender = 'Male'
WHERE Startup_Name = 'FurZapper'
UPDATE SharkTank.dbo.PitchersInfo
SET Pitchers_Gender = 'Male'
WHERE Startup_Name = 'Sparketh'
UPDATE SharkTank.dbo.PitchersInfo
SET Pitchers_Gender = 'Male'
WHERE Startup_Name = 'TheRealElf'
    -- Now we can efficiently run the query
SELECT 
    pit.Pitchers_Gender,
    COUNT(*) AS Gender,
    COUNT(CASE WHEN deal.Got_Deal = 1 THEN 1 END) AS Number_of_Successful_Pitches,
    (COUNT(CASE WHEN deal.Got_Deal = 1 THEN 1 END) * 100.0 / COUNT(*)) AS Success_Rate
FROM 
    PitchersInfo AS pit
JOIN 
    DealInfo AS deal ON pit.Startup_Name = deal.Startup_Name
GROUP BY 
    pit.Pitchers_Gender
ORDER BY 
    Success_Rate DESC;
    -- Having a mixed team of pitchers seems to be the most efficient (64.85% success rate), followed by female (63.31%) and Male (56.61%)

-- Q7. How much has each shark invested in 'Shark Tank'? --

-- Create a new table to store the next results for later visualization
CREATE TABLE SharkTank.dbo.InvestorData (
    Investor VARCHAR(50),
    Total_Investment INT,
    Pitches_Present INT,
    Investment_Rate DECIMAL(5, 2),
    Avg_Investment INT
);

-- Total investment per investor
WITH TotalInvestment AS (
    SELECT
        'Barbara Corcoran' AS Investor,
        ROUND(SUM(Barbara_Corcoran_Investment_Amount), 0) AS Total_Investment
    FROM
        InvesterInfo

    UNION ALL

    SELECT
        'Mark Cuban' AS Investor,
        ROUND(SUM(Mark_Cuban_Investment_Amount), 0) AS Total_Investment
    FROM
        InvesterInfo

    UNION ALL

    SELECT
        'Lori Greiner' AS Investor,
        ROUND(SUM(Lori_Greiner_Investment_Amount), 0) AS Total_Investment
    FROM
        InvesterInfo

    UNION ALL

    SELECT
        'Robert Herjavec' AS Investor,
        ROUND(SUM(Robert_Herjavec_Investment_Amount), 0) AS Total_Investment
    FROM
        InvesterInfo

    UNION ALL

    SELECT
        'Daymond John' AS Investor,
        ROUND(SUM(Daymond_John_Investment_Amount), 0) AS Total_Investment
    FROM
        InvesterInfo

    UNION ALL

    SELECT
        'Kevin O Leary' AS Investor,
        ROUND(SUM(Kevin_O_Leary_Investment_Amount), 0) AS Total_Investment
    FROM
        InvesterInfo
),
    -- Barbara has invested the least with $17.790.000,
    -- while Mark has invested most with $60.174.333
    -- !Important to note that they haven't been present all at the same frequency!

-- Pitches present per investor
PitchesPresent AS (
    SELECT
        'Barbara Corcoran' AS Investor,
        SUM(CASE WHEN [Barbara_Corcoran_Present] = 1 THEN 1 ELSE 0 END) AS Pitches_Present
    FROM
        Sharktank.dbo.sharktank

    UNION ALL

    SELECT
        'Mark Cuban' AS Investor,
        SUM(CASE WHEN [Mark_Cuban_Present] = 1 THEN 1 ELSE 0 END) AS Pitches_Present
    FROM
        Sharktank.dbo.sharktank

    UNION ALL

    SELECT
        'Lori Greiner' AS Investor,
        SUM(CASE WHEN [Lori_Greiner_Present] = 1 THEN 1 ELSE 0 END) AS Pitches_Present
    FROM
        Sharktank.dbo.sharktank

    UNION ALL

    SELECT
        'Robert Herjavec' AS Investor,
        SUM(CASE WHEN [Robert_Herjavec_Present] = 1 THEN 1 ELSE 0 END) AS Pitches_Present
    FROM
        Sharktank.dbo.sharktank

    UNION ALL

    SELECT
        'Daymond John' AS Investor,
        SUM(CASE WHEN [Daymond_John_Present] = 1 THEN 1 ELSE 0 END) AS Pitches_Present
    FROM
        Sharktank.dbo.sharktank

    UNION ALL

    SELECT
        'Kevin O Leary' AS Investor,
        SUM(CASE WHEN [Kevin_O_Leary_Present] = 1 THEN 1 ELSE 0 END) AS Pitches_Present
    FROM
        Sharktank.dbo.sharktank
),
        -- Kevin has been present for 875 pitches, Mark for 830, Robert for 790,
        -- Lori for 694, Daymond for 602 and Barbara for 516

    -- Investment rates per investor
InvestmentRates AS (
    SELECT 
        'Barbara Corcoran' AS Investor,
        COUNT(CASE WHEN Barbara_Corcoran_Investment_Amount > 0 THEN 1 END) * 100.0 / 
        COUNT(CASE WHEN Barbara_Corcoran_Present = 1 THEN 1 END) AS Investment_Rate
    FROM 
        Sharktank.dbo.sharktank

    UNION ALL

SELECT
    'Mark Cuban' AS Investor,
    COUNT(CASE WHEN Mark_Cuban_Investment_Amount > 0 THEN 1 END) * 100.0 / 
     COUNT(CASE WHEN Mark_Cuban_Present = 1 THEN 1 END) AS Investment_Rate
FROM 
    Sharktank.dbo.sharktank

    UNION ALL

    SELECT
        'Lori Greiner' AS Investor,
        COUNT(CASE WHEN Lori_Greiner_Investment_Amount > 0 THEN 1 END) * 100.0 / 
        COUNT(CASE WHEN Lori_Greiner_Present = 1 THEN 1 END) AS Investment_Rate
    FROM 
        Sharktank.dbo.sharktank

    UNION ALL

    SELECT
        'Robert Herjavec' AS Investor,
        COUNT(CASE WHEN Robert_Herjavec_Investment_Amount > 0 THEN 1 END) * 100.0 / 
        COUNT(CASE WHEN Robert_Herjavec_Present = 1 THEN 1 END) AS Investment_Rate
    FROM 
        Sharktank.dbo.sharktank

    UNION ALL

    SELECT
        'Daymond John' AS Investor,
        COUNT(CASE WHEN Daymond_John_Investment_Amount > 0 THEN 1 END) * 100.0 / 
        COUNT(CASE WHEN Daymond_John_Present = 1 THEN 1 END) AS Investment_Rate
    FROM 
        Sharktank.dbo.sharktank

    UNION ALL

    SELECT
        'Kevin O Leary' AS Investor,
        COUNT(CASE WHEN Kevin_O_Leary_Investment_Amount > 0 THEN 1 END) * 100.0 / 
        COUNT(CASE WHEN Kevin_O_Leary_Present = 1 THEN 1 END) AS Investment_Rate
    FROM 
        Sharktank.dbo.sharktank
),
        -- If we consider the number of pitches each investor was present for, 
        -- Lori has the highest investment rate with 29.00%, Mark is second with 28.46%, 
        -- Barbara third with 23.49%, then Daymond with 18.43%, Robert with 15.59% 
        -- and Kevin has the lowest investment rate with only 13.39%

    -- Average investment per investor
AverageInvestments AS (
    SELECT 
        'Barbara Corcoran' AS Investor,
        AVG(Barbara_Corcoran_Investment_Amount) AS Avg_Investment
    FROM 
        InvesterInfo

    UNION ALL

    SELECT 
        'Mark Cuban' AS Investor,
        AVG(Mark_Cuban_Investment_Amount) AS Avg_Investment
    FROM 
        InvesterInfo

    UNION ALL

    SELECT 
        'Lori Greiner' AS Investor,
        AVG(Lori_Greiner_Investment_Amount) AS Avg_Investment
    FROM 
        InvesterInfo

    UNION ALL

    SELECT 
        'Robert Herjavec' AS Investor,
        AVG(Robert_Herjavec_Investment_Amount) AS Avg_Investment
    FROM 
        InvesterInfo

    UNION ALL

    SELECT 
        'Daymond John' AS Investor,
        AVG(Daymond_John_Investment_Amount) AS Avg_Investment
    FROM 
        InvesterInfo

    UNION ALL

    SELECT 
        'Kevin O Leary' AS Investor,
        AVG(Kevin_O_Leary_Investment_Amount) AS Avg_Investment
    FROM 
        InvesterInfo
)
        -- On average Robert has the biggest investment with an average $292.051, $254.976 for Mark,
        -- $240.748 for Kevin, $216.882 for Lori, $182.431 for Daymond and $147.024 for Barbara 


    -- Insert data into the newly created table
INSERT INTO SharkTank.dbo.InvestorData
SELECT
    TI.Investor,
    TI.Total_Investment,
    PP.Pitches_Present,
    IR.Investment_Rate,
    AI.Avg_Investment
FROM
    TotalInvestment TI
JOIN PitchesPresent PP ON TI.Investor = PP.Investor
JOIN InvestmentRates IR ON TI.Investor = IR.Investor
JOIN AverageInvestments AI ON TI.Investor = AI.Investor;

SELECT * FROM SharkTank.dbo.InvestorData