-- Clayton Perona // PMG Technical Assessment // September 29, 2023

-- Write a query to get the sum of impressions by day.
SELECT SUM(impressions), DATE(date) AS day
FROM marketing_data
GROUP BY date;

-- Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?
SELECT state, SUM(revenue) AS Revenue
FROM website_revenue
GROUP BY state
ORDER BY Revenue DESC
LIMIT 3; -- Ohio was the third best state and generated $37,577 in revenue.

-- Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.
SELECT 
  campaign_info.name AS "Campaign Name", 
  ROUND(SUM(marketing_data.cost), 2) AS Cost, 
  SUM(marketing_data.impressions) AS Impressions, 
  SUM(marketing_data.clicks) AS Clicks, 
  SUM(website_revenue.revenue) AS Revenue
FROM campaign_info
JOIN marketing_data ON campaign_info.id=marketing_data.campaign_id
JOIN website_revenue ON campaign_info.id=website_revenue.campaign_id
GROUP BY name;

-- Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?
SELECT 
  campaign_info.name AS Campaign,
  website_revenue.state AS State,
  SUM(marketing_data.conversions) AS Conversions
FROM website_revenue
JOIN marketing_data ON website_revenue.campaign_id=marketing_data.campaign_id
JOIN campaign_info ON website_revenue.campaign_id=campaign_info.id
WHERE campaign_info.name = "Campaign5"
GROUP BY Campaign, State; -- Georgia generated the most conversions with 3342.

-- In your opinion, which campaign was the most efficient, and why?
--   Campaign 1 was the most efficient since it had the best results per dollar spent.
--   It had more impressions per dollar spent (1.102), conversions per dollar spent (0.338), and clicks per dollar spent (1.229) than any other campaign.
--   However, if this is intented to be a nationwide marketing campaign, the first one might not be the best since it only occurred in the state of Ohio.
--   Of campaigns that took place in at least three different states, Campaign 4 is the most efficient. 
--   It leads the campaigns in impressions per dollar spent (0.622) and conversions per dollar spent (0.126) and was second in clicks per dollar spent (.407).
--   Campaign 4 also was the best campaign when revenue is taken into account, leading all campaigns in impressions per dollar profit (0.837), conversions per dollar profit (0.169), and clicks per dollar profit (0.548).
SELECT 
  campaign_info.name AS Campaign,
  website_revenue.revenue AS Revenue,
  SUM(marketing_data.conversions) AS Conversions,
  ROUND(SUM(marketing_data.cost), 2) AS Cost,
  SUM(marketing_data.impressions) AS Impressions,
  SUM(marketing_data.clicks) AS Clicks,
  ROUND(website_revenue.revenue - SUM(marketing_data.cost), 2) AS Profit,
  ROUND(marketing_data.impressions / (website_revenue.revenue - SUM(marketing_data.cost)), 3) AS IPP,
  ROUND(marketing_data.conversions / (website_revenue.revenue - SUM(marketing_data.cost)), 3) AS CPP,
  ROUND(marketing_data.clicks / (website_revenue.revenue - SUM(marketing_data.cost)), 3) AS CLPP,
  ROUND(marketing_data.impressions / SUM(marketing_data.cost), 3) AS IPC,
  ROUND(marketing_data.conversions / SUM(marketing_data.cost), 3) AS CPC,
  ROUND(marketing_data.clicks / SUM(marketing_data.cost), 3) AS CLPC
FROM website_revenue
JOIN marketing_data ON website_revenue.campaign_id=marketing_data.campaign_id
JOIN campaign_info ON website_revenue.campaign_id=campaign_info.id
GROUP BY Campaign;

-- Bonus Question: Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
ALTER TABLE marketing_data
ADD DayOfWeek VARCHAR(50);

UPDATE marketing_data
SET DayOfWeek = DAYOFWEEK(date);

SELECT 
  marketing_data.dayofweek AS DayOfWeek,
  website_revenue.revenue AS Revenue,
  SUM(marketing_data.conversions) AS Conversions,
  ROUND(SUM(marketing_data.cost), 2) AS Cost,
  SUM(marketing_data.impressions) AS Impressions,
  SUM(marketing_data.clicks) AS Clicks,
  ROUND(website_revenue.revenue - SUM(marketing_data.cost), 2) AS Profit,
  ROUND(marketing_data.impressions / (website_revenue.revenue - SUM(marketing_data.cost)), 3) AS IPP,
  ROUND(marketing_data.conversions / (website_revenue.revenue - SUM(marketing_data.cost)), 3) AS CPP,
  ROUND(marketing_data.clicks / (website_revenue.revenue - SUM(marketing_data.cost)), 3) AS CLPP,
  ROUND(marketing_data.impressions / SUM(marketing_data.cost), 3) AS IPC,
  ROUND(marketing_data.conversions / SUM(marketing_data.cost), 3) AS CPC,
  ROUND(marketing_data.clicks / SUM(marketing_data.cost), 3) AS CLPC
FROM marketing_data
JOIN website_revenue ON marketing_data.campaign_id=website_revenue.campaign_id
GROUP BY DayOfWeek;

