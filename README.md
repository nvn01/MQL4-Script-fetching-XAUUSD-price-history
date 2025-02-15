# MQL4 Data Export Scripts

This repository contains two MQL4 scripts for exporting XAUUSD historical data to CSV files.

# How to Add and Use a Script in MetaTrader 4 (MT4)

Open **MetaTrader 4 (MT4)** → Click **New Document** → Choose **Script** → Enter the **script name** → Click **Finish** → Paste the **code** → **Compile** the code → The script should appear in the **Navigator** panel → **Double-click** or **drag and drop** it onto the chart → Open **File** (top-left corner) → Open **Data Folder** → Go to **MQL4 > Files** → Place the **dataset** inside the **Files** folder to restore it.

## Scripts

- **FetchAllData.mq4**  
  Exports all available XAUUSD historical data (starting from January 1, 2004) for eight timeframes (15m, 1Month, 1d, 1h, 1w, 30m, 4h, and 5m). The CSV files are automatically saved to the local MQL4/Files folder.

- **Jan_2025_to_present.mq4**  
  Exports XAUUSD historical data from January 1, 2025 to the present for selected timeframes (daily and 15-minute). The CSV files are automatically saved to the local MQL4/Files folder.

## Usage

Simply drag and drop the desired script onto a chart in MetaTrader 4, and the data will be exported automatically.
