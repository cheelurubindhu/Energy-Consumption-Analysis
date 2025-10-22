📘 Project Overview

This project explores the relationship between global energy consumption, GDP, and CO₂ emissions using SQL-based data analysis. The goal is to understand how energy usage patterns influence economic growth and environmental sustainability across countries.

🎯 Objectives

Analyze correlations between GDP, energy consumption, and CO₂ emissions.

Study year-over-year trends in emissions, GDP, and energy consumption.

Calculate efficiency ratios such as Emission-to-GDP and per capita metrics.

Identify top emission sources and most energy-intensive economies.

Provide data-driven recommendations for sustainable energy policies.

Evaluate the environmental efficiency of countries using ratio-based metrics.

ER Diagram

The project uses a star schema model consisting of six interconnected tables:

Country – Base reference table (country name, country ID).

Emission – Tracks total and per capita emissions by energy type and year.

Population – Records population per country per year.

Production – Captures energy production data by type and year.

GDP_dd – Contains GDP data by country and year.

Consum – Holds energy consumption data by country, energy type, and year.

Each table is linked via the country attribute to maintain referential integrity.


🔍 Key Analysis Questions

Total emissions per country for the most recent year

Top 5 countries by GDP

Comparison of energy production vs. consumption by country and year

Energy types contributing most to emissions

Global emissions change year-over-year

GDP trends over time

Impact of population growth on emissions

Energy consumption trends for major economies

Average yearly change in emissions per capita

Emission-to-GDP ratio by year

Energy consumption per capita for each country

Energy production per capita comparison

Countries with highest consumption-to-GDP ratio

Correlation between GDP growth and energy production growth

Top 10 countries by population vs. their emissions

Global share (%) of emissions by country

Global average GDP, emissions, and population by year


🧮 Tools & Technologies

SQL (for querying and analysis)

MySQL / PostgreSQL (database)

PowerPoint (for presentation of findings)

Excel / CSV (for data source integration)


📊 Business Insights

🌏 Rich countries use more energy: Nations with higher GDP (e.g., USA, China, India) have higher energy consumption and emissions.

⚡ Energy dependence: Some countries rely on imports, while others export excess energy.

👥 Population growth → higher energy demand and emissions.

🌱 Positive trend: Global emissions are slowly stabilizing due to renewable energy adoption and awareness.


💡 Recommendations

Increase renewable energy usage.

Focus on energy efficiency improvements.

Establish emission reduction goals.

Raise public awareness about sustainable practices.

Encourage international cooperation for climate-friendly energy transitions

