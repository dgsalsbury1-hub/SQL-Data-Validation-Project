/*
 * SQL Data Validation Queries - VentureInsight Analytics
 * Purpose: Verify data integrity following database upgrade
 * Database: VentureInsight venture capital analytics platform
 * 
 * This file contains 9 data validation queries designed to ensure
 * accurate data synchronization between web application and database.
 * 
 * TABLE OF CONTENTS:
 * 1. Startup Landscape Analysis
 * 2. Sector Analysis for US Investors
 * 3. Analyzing Cash Acquisitions
 * 4. Identifying Industry Influencers
 * 5. Finding Finance Influencers
 * 6. Geographic Investments Analysis
 * 7. Funding Round Volatility Analysis
 * 8. Fund Activity Classification
 * 9. Investment Strategy by Fund Activity
 */

-- ============================================
-- QUERY 1: Startup Landscape Analysis
-- ============================================
-- Business Purpose: Verify closed startup status in database
-- Data Validation: Count companies with status = 'closed'
-- Expected Use: Validate app changes reflected post-upgrade
-- Test Scenario: Confirm closed companies show in database

SELECT COUNT(*) AS closed_startups
FROM company
WHERE status = 'closed';


-- ============================================
-- QUERY 2: Sector Analysis for US Investors
-- ============================================
-- Business Purpose: Analyze funding by country and industry sector
-- Data Validation: Fund amounts for news industry in USA
-- Expected Use: Support investment sector analysis reporting
-- Test Scenario: Verify country_code and category_code data accuracy

SELECT funding_total
FROM company
WHERE country_code = 'USA' 
    AND category_code = 'news'
ORDER BY funding_total DESC;


-- ============================================
-- QUERY 3: Analyzing Cash Acquisitions
-- ============================================
-- Business Purpose: Track cash-based M&A activity
-- Data Validation: Total acquisition amounts in post-recession period
-- Expected Use: Quarterly acquisition trend reporting
-- Test Scenario: Verify cash deals from 2011-2013 inclusive

SELECT SUM(price_amount) AS total_acquisitions
FROM acquisition
WHERE term_code = 'cash'
    AND EXTRACT(YEAR FROM acquired_at) BETWEEN 2011 AND 2013;


-- ============================================
-- QUERY 4: Identifying Industry Influencers
-- ============================================
-- Business Purpose: Support marketing outreach to social media influencers
-- Data Validation: Identify individuals with "Silver" brand in Twitter handles
-- Expected Use: Influencer contact list for marketing campaign
-- Test Scenario: Pattern matching validation for Twitter usernames

SELECT 
    first_name,
    last_name,
    twitter_username
FROM people
WHERE twitter_username LIKE 'Silver%';


-- ============================================
-- QUERY 5: Finding Finance Influencers
-- ============================================
-- Business Purpose: Target finance-focused influencers for FinTech campaign
-- Data Validation: Find influencers with "money" in handle + last name K
-- Expected Use: FinTech investment report marketing outreach
-- Test Scenario: Multi-criteria filtering for targeted influencer list

SELECT *
FROM people
WHERE twitter_username LIKE '%money%'
    AND last_name LIKE 'K%';


-- ============================================
-- QUERY 6: Geographic Investments Analysis
-- ============================================
-- Business Purpose: Understand global venture capital distribution
-- Data Validation: Total funding by country for investment strategy
-- Expected Use: Quarterly global trends report by geography
-- Test Scenario: GROUP BY aggregation across multiple countries

SELECT 
    country_code,
    SUM(funding_total) AS total_funding
FROM company
GROUP BY country_code
ORDER BY total_funding DESC;


-- ============================================
-- QUERY 7: Funding Round Volatility Analysis
-- ============================================
-- Business Purpose: Identify unusual market activity in funding patterns
-- Data Validation: Daily funding round min/max for volatility assessment
-- Expected Use: Risk analysis and market activity reporting
-- Test Scenario: MIN/MAX aggregate with HAVING clause filtering

SELECT 
    funded_at,
    MIN(raised_amount) AS lowest_amount,
    MAX(raised_amount) AS highest_amount
FROM funding_round
GROUP BY funded_at
HAVING MIN(raised_amount) != 0 
    AND MIN(raised_amount) != MAX(raised_amount);


-- ============================================
-- QUERY 8: Fund Activity Classification
-- ============================================
-- Business Purpose: Categorize venture funds by investment activity level
-- Data Validation: Classify funds into activity tiers for client analysis
-- Expected Use: Help investment clients find appropriate co-investment partners
-- Test Scenario: CASE statement for data categorization
-- Categories:
--   high_activity: 100+ companies
--   middle_activity: 20-99 companies
--   low_activity: <20 companies

SELECT 
    *,
    CASE 
        WHEN invested_companies >= 100 THEN 'high_activity'
        WHEN invested_companies >= 20 THEN 'middle_activity'
        ELSE 'low_activity'
    END AS activity_level
FROM fund;


-- ============================================
-- QUERY 9: Investment Strategy by Fund Activity
-- ============================================
-- Business Purpose: Understand fund strategy correlation with activity level
-- Data Validation: Compare funding round participation across activity tiers
-- Expected Use: Help clients understand fund engagement strategies
-- Test Scenario: Grouped CASE aggregation with ROUND function

SELECT 
    CASE 
        WHEN invested_companies >= 100 THEN 'high_activity'
        WHEN invested_companies >= 20 THEN 'middle_activity'
        ELSE 'low_activity'
    END AS activity_level,
    ROUND(AVG(investment_rounds)) AS avg_investment_rounds
FROM fund
GROUP BY activity_level
ORDER BY avg_investment_rounds ASC;
