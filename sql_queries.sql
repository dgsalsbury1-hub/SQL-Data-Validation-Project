 Startup Landscape Analysis
Your first task is a simple one. Some changes were made in the app, which should be reflected in the database. If everything went according to plan, several startup companies should now be showing as closed. Generate a table of closed startups.
SELECT COUNT(*) AS closed_startups
FROM company
WHERE status = 'closed';

 Sector Analysis for US Investors
Developers have added two new fields to the database – country_code and category_code in the company table. Your college has a test case that requires data about news from the USA. 
Print the amount of money that news-related companies from the USA have raised. Use data from the company table. Sort the resulting table by the funding_total field in descending order to see the most well-funded companies first.
SELECT funding_total
FROM company
WHERE country_code = 'USA' 
    AND category_code = 'news'
ORDER BY funding_total DESC;

 Analyzing Cash Acquisitions
The quarterly report includes a section on acquisition trends. There is a test case requiring data on cash-based acquisitions (as opposed to stock deals) that occurred during the post-recession period (2011-2013). 
Find the total amount of company acquisitions in US dollars. Select only the deals made in cash from 2011 to 2013, inclusive.
SELECT SUM(price_amount) AS total_acquisitions
FROM acquisition
WHERE term_code = 'cash'
    AND EXTRACT(YEAR FROM acquired_at) BETWEEN 2011 AND 2013;

 Identifying Industry Influencers

The marketing team is preparing an outreach campaign to industry influencers with strong social media presence and it's considered high priority. As a result, your colleague has some test cases to make sure the updated database will provide accurate data when it goes live. They're particularly interested in individuals who brand themselves with "Silver" in their Twitter handles, as this group seems to have significant industry clout. 
Print the first and last names of people whose Twitter usernames start with 'Silver'. Include their Twitter usernames in the results.
SELECT 
    first_name,
    last_name,
    twitter_username
FROM people
WHERE twitter_username LIKE 'Silver%';



 Finding Finance Influencers

Following your initial influencer analysis, the marketing team has refined their focus. They're now looking specifically for finance-focused influencers (those with "money" in their Twitter handles) whose last names start with 'K'. This more targeted approach will help them connect with relevant industry voices for our upcoming FinTech investment report.
Print all information about people whose Twitter usernames include the word 'money' somewhere in their name and whose last names start with 'K'.
SELECT *
FROM people
WHERE twitter_username LIKE '%money%'
    AND last_name LIKE 'K%';

 Geographic Investments Analysis

The firm's global investment clients need to understand funding patterns across different countries. They want to identify which countries attract the most venture capital to help them decide where to focus their international investment strategies. This geographic breakdown will be a key feature in the quarterly global trends report. Again, since this is an important scenario, you have been asked to test the database pulls the right data.
For each country, calculate the total amount of money raised by companies registered there. The country code will tell you where each company is registered. Sort the data by sum in descending order to highlight the countries with the most funding.
SELECT 
    country_code,
    SUM(funding_total) AS total_funding
FROM company
GROUP BY country_code
ORDER BY total_funding DESC;

7.  Funding Round Volatility Analysis

The risk analysis team examines volatility in funding rounds. They're specifically interested in dates where there was significant variation between the smallest and largest rounds. This indicates days when both very small and very large companies were receiving funding, which could signal unusual market activity. They also want to exclude days where some companies received no funding at all, as that skews the analysis. You need to pull this data from the database so that it can be verified in test cases.
Create a table showing the highest and lowest amount of money raised for each date in the funding_round table. Include the dates in your results. The resulting table should only have records where the lowest value is not equal to zero or to the highest value.
SELECT 
    funded_at,
    MIN(raised_amount) AS lowest_amount,
    MAX(raised_amount) AS highest_amount
FROM funding_round
GROUP BY funded_at
HAVING MIN(raised_amount) != 0 
    AND MIN(raised_amount) != MAX(raised_amount);


 Fund Activity Classification

For investor clients, understanding the activity level of different venture funds helps them identify potential co-investment partners. Funds that invest in many companies are often seen as having broader networks, while those with fewer investments might have deeper industry expertise. We need to ensure data can be pulled by the business to categorize funds by their activity level to help clients find appropriate partners.
Create a field with three categories:
high_activity — for funds that invest in a hundred or more companies
middle_activity — for funds that invest in between twenty (inclusive) to a hundred companies (exclusive)
low_activity — for funds that invest in fewer than twenty companies
Print all fields from the fund table and the new field with categories.
SELECT 
    *,
    CASE 
        WHEN invested_companies >= 100 THEN 'high_activity'
        WHEN invested_companies >= 20 THEN 'middle_activity'
        ELSE 'low_activity'
    END AS activity_level
FROM fund;

 Investment Strategy by Fund Activity

Building on our fund activity classification, the research team wants to understand how a fund's investment approach changes based on its activity level. Specifically, they want to know if funds that invest in more companies tend to participate in more funding rounds per company. This will help their clients understand different fund strategies and how broadly or deeply funds typically engage with their portfolio companies.
For each activity category you assigned in the previous task, calculate the average number of funding rounds the fund participated in. Round it to the nearest whole number. Print the categories and the average number of funding rounds. Sort the table by the average in ascending order.
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
