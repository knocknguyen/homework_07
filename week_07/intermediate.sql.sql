Write a query to count the number of non-null rows in the low column.
pretty straightfoward to do this query
SELECT COUNT(low)
  FROM tutorial.aapl_historical_stock_price

Write a query that determines 
counts of every single column. Which column has the most null values?
SELECT COUNT(year) AS year,
       COUNT(month) AS month,
       COUNT(open) AS open,
       COUNT(high) AS high,
       COUNT(low) AS low,
       COUNT(close) AS close,
       COUNT(volume) AS volume, 
       COUNT(id) AS id
  FROM tutorial.aapl_historical_stock_price

Write a query to calculate the average opening price 
(hint: you will need to use both COUNT and SUM, as well as some simple 
arithmetic.).
SELECT AVG(open) AS avg_open_price -- YOUTUBE video just use AVG() operation to find the average. 
  FROM tutorial.aapl_historical_stock_price

SELECT SUM(open)/COUNT(open) AS avg_open_price
  FROM tutorial.aapl_historical_stock_price

What was Apple's lowest stock price
 (at the time of this data collection)?
SELECT MIN(low) AS lowest_price
       FROM tutorial.aapl_historical_stock_price

What was the highest single-day 
increase in Apple's share value?
This one is confusing to me because I did 
SELECT MAX(open - close) -- got 30.12 but answer is 32.58
  FROM tutorial.aapl_historical_stock_price
SELECT MAX(close - open)
  FROM tutorial.aapl_historical_stock_price

Write a query that calculates the average daily 
trade volume for Apple stock.
SELECT AVG(volume)
  FROM tutorial.aapl_historical_stock_price

Calculate the total number of shares traded each month. 
Order your results chronologically.
SELECT year,
       month,
       sum(volume) AS vol_total
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month
 ORDER BY year,month

SELECT year,
       month,
       sum(volume) AS vol_total
  FROM tutorial.aapl_historical_stock_price
 GROUP BY 1 , 2
 ORDER BY 1, 2

Write a query to calculate the average daily 
price change in Apple stock, grouped by year.
SELECT year,
    AVG(close-open) AS avg_daily_change
  FROM tutorial.aapl_historical_stock_price
 GROUP BY 1 
 ORDER BY 1

SELECT year,
    AVG(close-open) AS avg_daily_change
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year
 ORDER BY year

Write a query that calculates the lowest and highest prices that 
Apple stock achieved each month.
SELECT year, 
       month,
       MIN(low) AS lowest_price,
       MAX(high) AS highest_price
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month -- or type in colum 1,2  
 ORDER BY year, month -- 1 for year and 2 for month

Write a query that includes a column that is flagged "yes" when a player is from California, and sort 
the results with those players first.

SELECT player_name,
       state,
       CASE WHEN state = 'CA' THEN 'yes'
            ELSE NULL END AS from_california
  FROM benn.college_football_players
 ORDER BY player_name  ---- correct answer is 3, previous lesson it didn't make a different 
                         -- wherther I put the colunm number or colunm name??

Write a query that includes players' names and a 
column that classifies them into four categories based on height.
 Keep in mind that the answer we provide is only one of many possible answers, since you could divide 
players' heights in many ways.

    height,
       CASE WHEN height > 80 THEN 'over 80'
            WHEN height > 75 THEN '76-79'
            WHEN height > 65 THEN '64-74'
            ELSE '65 or under' END AS height_group
  FROM benn.college_football_players
  
Write a query that selects all columns from 
benn.college_football_players and adds an additional 
column that displays the player's name if that player is a 
junior or senior.
 SELECT player_name,
       CASE WHEN year = 'JR' AND year = 'SR' THEN player_name ELSE NULL END AS Junior_Senior
  FROM benn.college_football_players

Write a query that counts the number of 300lb+ players for each of the following regions: West Coast (CA, OR, WA), Texas, 
and Other (Everywhere else
I didn't know how to solve this one. 
SELECT CASE WHEN state IN ('CA', 'OR', 'WA') THEN 'West Coast'
            WHEN state = 'TX' THEN 'Texas'
            ELSE 'Other' END AS arbitrary_regional_designation,
            COUNT(1) AS players
  FROM benn.college_football_players
 WHERE weight >= 300
 GROUP BY 1

Write a query that calculates the combined weight 
of all underclass players (FR/SO) in California as well as the combined weight of all upperclass players
(JR/SR) in California.

SELECT CASE WHEN year IN ('FR', 'SO') THEN 'underclass'
            WHEN year IN ('JR', 'SR') THEN 'upperclass'
            ELSE NULL END AS class_year,
       SUM(weight) AS total_player_weight
  FROM benn.college_football_players
 WHERE state = 'CA'
 GROUP BY 1

Write a query that displays the number of players in 
each state, with FR, SO, JR, and SR players in separate 
columns and another column for the total number of players. 
Order results such that states with the most players come first.
SELECT state,
       COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
       COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
       COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
       COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count,
       COUNT(1) AS total_players
  FROM benn.college_football_players
 GROUP BY state
 ORDER BY total_players DESC

Write a query that shows the number of players at schools with names that start with A through M, and the number at schools with names starting with N - Z.
I used the  <= and >= operation to fist find players at schools with names that start with A through M,and  names starting with N - Z.
SELECT CASE WHEN school_name <= 'n' THEN 'A-M'
            WHEN school_name >= 'n' THEN 'N-Z'
            ELSE NULL END AS school_name,
       COUNT(1) AS players
  FROM benn.college_football_players
 GROUP BY 1

  


Write a query that counts the number of unique values in the month column for each year.
 SELECT COUNT(DISTINCT month) AS unique_months,
         COUNT(DISTINCT year) AS unique_years
  FROM tutorial.aapl_historical_stock_price

Write a query that selects the school name, player name, position, and weight for every player in Georgia, 
ordered by weight (heaviest to lightest). Be sure to make an alias for the table, and to reference all
column names in relation to the alias.
I select the rows names wanted then used DESC to have the table displace haviest to lightest.
SELECT players.school_name,
       players.player_name,
       players.position,
       players.weight
  FROM benn.college_football_players players
 WHERE players.state = 'GA'
 ORDER BY players.weight DESC

 
Write a query that displays player names, school names and conferences
 for schools in the "FBS (Division I-A Teams)" division.
SELECT players.player_name,
       players.school_name,
       teams.conference
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
    ON teams.school_name = players.school_name
 WHERE teams.division = 'FBS (Division I-A Teams)'


Write a query that performs an inner join between the tutorial.crunchbase_acquisitions table and the tutorial.crunchbase_companies table, but instead of listing individual rows, count the number of non-null 
rows in each table.
I did this query but it was wrong because I couldn't do the below problem.
checked my answer I didn't add 'count' to my query.
SELECT companies.permalink AS companies_rowcount,
       acquisitions.company_permalink  AS acquisitions_rowcount
  FROM tutorial.crunchbase_companies companies
  JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink

SELECT COUNT(companies.permalink) AS companies_rowcount,
       COUNT(acquisitions.company_permalink) AS acquisitions_rowcount
  FROM tutorial.crunchbase_companies companies
  JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink

Modify the query above to be a LEFT JOIN. Note the difference in 
results.
SELECT COUNT(companies.permalink) AS companies_rowcount,
       COUNT(acquisitions.company_permalink) AS acquisitions_rowcount
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink

Count the number of unique companies (don't double-count companies)
 and unique acquired companies by state. Do not include results for 
which there is no state data, and order by the number of acquired companies from highest to lowest.
I didn't know didn't how to solve this one.
and this one:
Rewrite the previous practice query in which you counted total and acquired companies by state, but with a RIGHT JOIN instead of a LEFT JOIN. The goal is to produce the exact same results.



Write a query that shows a company's name, "status" (found in the Companies table), and the number of unique investors in that company. Order by the number of investors from most to fewest. Limit to only companies in 
the state of New York.
This one is straightforward followed the example and added 3 DESC to order 
from hightest to lowest.
SELECT companies.name AS company_name,
       companies.status,
       COUNT(DISTINCT investments.investor_name) AS unqiue_investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink
 WHERE companies.state_code = 'NY'
 GROUP BY 1,2
 ORDER BY 3 DESC


Write a query that lists investors based on the number of 
companies in which they are invested. Include a row for companies with no investor, and order from most
 companies to least.
I only got this far for this question. Couldn't find out until I look
at the answer.
SELECT CASE WHEN investments.investor_name, 
            ELSE investments.investor_name END AS investor,
       COUNT(DISTINCT companies.permalink) AS companies_invested_in
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1


Write a query that joins tutorial.crunchbase_companies and tutorial.crunchbase_investments_part1 
using a FULL JOIN. Count up the number of rows that are matched/unmatched as 
in the example above.
I just follow the tutorial example
SELECT COUNT(CASE WHEN companies.permalink IS NOT NULL AND investments.company_permalink IS NULL
                      THEN companies.permalink ELSE NULL END) AS companies_only,
           COUNT(CASE WHEN companies.permalink IS NOT NULL AND investments.company_permalink IS NOT NULL
                      THEN companies.permalink ELSE NULL END) AS both_tables,
           COUNT(CASE WHEN companies.permalink IS NULL AND investments.company_permalink IS NOT NULL
                      THEN investments.company_permalink ELSE NULL END) AS investments_only
      FROM tutorial.crunchbase_companies companies
      FULL JOIN tutorial.crunchbase_investments_part1 investments
        ON companies.permalink = investments.company_permalink


Write a query that appends the two crunchbase_investments datasets
 above (including duplicate values). Filter the first dataset to only companies with names that start with the letter "T", and filter the second to companies with names starting with "M" (both not case-sensitive). Only include the company_permalink, company_name, and
 investor_name columns.
I select the row names then use the ILIKE with % to find any company that start with letter 't' and 'm'

SELECT company_permalink,
       company_name,
       investor_name
  FROM tutorial.crunchbase_investments_part1
 WHERE company_name ILIKE 't%'
 
 UNION ALL

SELECT company_permalink,
       company_name,
       investor_name
  FROM tutorial.crunchbase_investments_part2
 WHERE company_name ILIKE 'm%'

Write a query that shows 3 columns. The first indicates which dataset (part 1 or 2) the data comes from, the second shows company status, and the third is a count of the number of investors.
I only got this far in for this problem. I didn't know what to do next
SELECT 'investments_part1' AS dataset_name,
       companies.status,

SELECT 'investments_part2' AS dataset_name,
       companies.status,