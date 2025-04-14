# Twitch to Power BI Streaming Dashboard

This project streams real-time Twitch data (top 10 streams) to a Power BI dataset using R, and visualizes it in a Power BI dashboard.

## Files

- `twitch_powerbi.R`: R script to fetch Twitch stream data and push it to Power BI.
- `.env`: Configuration file for sensitive credentials (not included in repository).

## Setup

1. Install R and required packages:
   ```R
   install.packages(c("httr", "jsonlite", "dotenv"))
   ```
