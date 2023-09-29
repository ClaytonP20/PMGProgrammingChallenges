-- Write a query to get the sum of impressions by day.
SELECT SUM(impressions), date
FROM marketing_data
GROUP BY date;

-- Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?


-- Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.


-- Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?


-- In your opinion, which campaign was the most efficient, and why?


-- Bonus Question: Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
