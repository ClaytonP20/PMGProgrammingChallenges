-- Clayton Perona // PMG Technical Assessment // September 29, 2023

-- Write a query to get the sum of impressions by day.
SELECT SUM(impressions), DATE(date) AS day
FROM marketing_data
GROUP BY date;


-- Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?
SELECT SUM(revenue) AS SumRevenue, state
FROM website_revenue
GROUP BY state
ORDER BY SumRevenue DESC
LIMIT 3; 
-- Ohio was the third best state and generated $37,577 in revenue.


-- Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.
SELECT campaign_info.name, marketing_data.cost, marketing_data.impressions, marketing_data.clicks, website_revenue.revenue
FROM campaign_info
JOIN marketing_data ON campaign_info.id=marketing_data.campaign_id
JOIN website_revenue ON campaign_info.id=website_revenue.campaign_id
GROUP BY name;

-- Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?


-- In your opinion, which campaign was the most efficient, and why?


-- Bonus Question: Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
