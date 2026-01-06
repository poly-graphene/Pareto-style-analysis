# Project Background
Poly's Home Decor is a global e-commerce company that sells vintage items and home decor products worldwide.

The company has valuable data on sales, customer spending habits, global performance and product offerings that this project analyzes in order to uncover critical insights that will improve Poly's Home Decor's success.

Insights and recommendations are provided on the following key areas:
- Sales Trend Analysis: Evaluation of historical sales pattern, focusing on global revenue.
- Product Level Performance: An analysis on product performance based on 80/20 Pareto principle.
- Concentration Ratio: Evaluation of core revenue products' contribution to total revenue for risk evaluation.

An interactive Tableau dashboard can be downloaded [here.](https://public.tableau.com/views/PortfolioProjectDashboard_17674032940670/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

The SQL queries used to clean, organize and prepare data for excel and tableau can be found [here.](https://github.com/poly-graphene/Pareto-style-analysis/blob/main/MySQL%20cleaning%20and%20aggregation%20script.sql)

The Excel spreadsheet for evaluating product type based on Pareto principle can be found [here.](https://docs.google.com/spreadsheets/d/1pv3j8eqFQWqfaSDDzA-kwFTNFf2A6EMBXSL6-ZG0XJY/edit?usp=sharing)

# Data Structure

Poly's Home Decor's database consists of one table with a total row count of 527943 records and time range from 01/12/2010 to 09/12/2011. 4335+ customers and 19789 transactions among 38 countries. 
A sample data of 100k rows is added to the repository due to Github's file size limitations. Full dataset can be downloaded [here.](https://drive.google.com/file/d/1a_z-tYYrL4zS2ieDg24DDeWiyJmAHQS-/view?usp=drive_link)

<img width="174" height="190" alt="image" src="https://github.com/user-attachments/assets/dba226b3-36e8-4610-97ec-7c429c406e5c" />

# Executive Summary

## Overview of Findings

- The company's revenue has steadily increased in the past year (2010 - 2011), with the best month being November of 2011 with almost $1.5M in revenue.
- But the revenue is highly concentrated, with 21.44% of products contributing for 80% of total revenue, indicating strong Pareto pattern.
- The concentration ratio has been rising through out the year, demonstrating increasing dependency on a small subset of products for revenue growth.    
- In the latest month (december of 2011), the concentration ratio peaked, with core products responsible for 85% of company's total revenue.

Below is the overview page from the Tableau dashboard. The interactive Tableau dashboard can be downloaded [here.](https://public.tableau.com/views/PortfolioProjectDashboard_17674032940670/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

<img width="1149" height="549" alt="Dashboard Image" src="https://github.com/user-attachments/assets/5a12a392-353a-46fb-8f50-42e94ceb1109" />

Below is a sample spreadsheet used to apply Pareto logic and identify core revenue drivers. Full Excel spreadsheet can be found [here.](https://docs.google.com/spreadsheets/d/1pv3j8eqFQWqfaSDDzA-kwFTNFf2A6EMBXSL6-ZG0XJY/edit?usp=sharing)

<img width="904" height="247" alt="Screenshot 2026-01-05 175110" src="https://github.com/user-attachments/assets/ee23d239-8284-457c-a9fa-706bbc1f737a" />

# Recommendations

Based on the uncovered insights and analysis, the following recommendations has been provided:

- With 21.44% products driving 80% revenue, its crucial to reduce volatility through revenue diversification. Product variants can be introduced like premium and budget options. Different sizes, colors and bundle options can also help diversify the products portfolio.
- Consistently low performing products can be sold with promotions and bundles, or their inventory stocks can be reduced to increase shelf space for high-potential products.
- Inventory availability for top products can be prioritized to avoid stockouts since they drive majority of company revenue.














