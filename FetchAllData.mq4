//+------------------------------------------------------------------+
//|                                      ExportXAUUSDMultiTF_AllData.mq4 |
//|  This script exports XAUUSD data from January 1, 2004 onward for   |
//|  nine different timeframes:                                        |
//|    - XAU_1m_data.csv    => 1-minute                               |
//|    - XAU_15m_data.csv   => 15-minute                              |
//|    - XAU_1Month_data.csv=> 1-month                                |
//|    - XAU_1d_data.csv    => Daily                                  |
//|    - XAU_1h_data.csv    => Hourly                                 |
//|    - XAU_1w_data.csv    => Weekly                                 |
//|    - XAU_30m_data.csv   => 30-minute                              |
//|    - XAU_4h_data.csv    => 4-hour                                 |
//|    - XAU_5m_data.csv    => 5-minute                               |
//+------------------------------------------------------------------+
#property strict
#property script_show_inputs

// Helper function to export data for a given symbol, timeframe, and file name
void ExportData(string symbol, int timeframe, string fileName, datetime startTime)
{
   // Retrieve the total number of bars available for the given symbol/timeframe
   int totalBars = Bars(symbol, timeframe);
   if(totalBars < 1)
   {
      Print("No bars found for ", symbol, " on timeframe ", timeframe);
      return;
   }
   
   // Open the CSV file (located in the MQL4/Files folder)
   int fileHandle = FileOpen(fileName, FILE_WRITE|FILE_CSV);
   if(fileHandle < 0)
   {
      Print("Error opening file: ", fileName, ". Check your permissions.");
      return;
   }
   
   // Write the header row
   FileWrite(fileHandle, "Date", "Open", "High", "Low", "Close", "Volume");
   
   // Loop through all bars in chronological order (oldest first)
   for(int i = totalBars - 1; i >= 0; i--)
   {
      datetime timeStamp = iTime(symbol, timeframe, i);
      
      // Only process bars on or after the specified startTime (January 1, 2004)
      if(timeStamp < startTime)
         continue;
      
      // Format the date string to include date and time (hours:minutes)
      string dateStr = TimeToString(timeStamp, TIME_DATE|TIME_MINUTES);
      
      // Retrieve the OHLC and Volume data
      double openPrice  = iOpen(symbol, timeframe, i);
      double highPrice  = iHigh(symbol, timeframe, i);
      double lowPrice   = iLow(symbol, timeframe, i);
      double closePrice = iClose(symbol, timeframe, i);
      long volume       = iVolume(symbol, timeframe, i);
      
      // Write the row to the CSV file
      FileWrite(fileHandle, dateStr, openPrice, highPrice, lowPrice, closePrice, volume);
   }
   
   // Close the file to finalize the data write
   FileClose(fileHandle);
   Print("Data successfully saved to ", fileName);
}

//+------------------------------------------------------------------+
//| Script entry point                                               |
//+------------------------------------------------------------------+
void OnStart()
{
   // Define the symbol (adjust if needed) and the start date (January 1, 2004)
   string symbol = "XAUUSD";
   datetime startTime = StrToTime("2004.01.01 00:00");
   
   // Define file names for each timeframe (now including 1-minute)
   string fileNames[9] = {
      "XAU_1m_data.csv",     // 1-minute
      "XAU_15m_data.csv",    // 15-minute
      "XAU_1Month_data.csv", // 1-month
      "XAU_1d_data.csv",     // Daily
      "XAU_1h_data.csv",     // Hourly
      "XAU_1w_data.csv",     // Weekly
      "XAU_30m_data.csv",    // 30-minute
      "XAU_4h_data.csv",     // 4-hour
      "XAU_5m_data.csv"      // 5-minute
   };
   
   // Define the corresponding timeframes
   int timeframes[9] = {
      PERIOD_M1,   // 1-minute
      PERIOD_M15,  // 15-minute
      PERIOD_MN1,  // 1-month
      PERIOD_D1,   // Daily
      PERIOD_H1,   // Hourly
      PERIOD_W1,   // Weekly
      PERIOD_M30,  // 30-minute
      PERIOD_H4,   // 4-hour
      PERIOD_M5    // 5-minute
   };
   
   // Loop through each timeframe and export its data from 2004 onward
   for (int i = 0; i < 9; i++)
   {
      ExportData(symbol, timeframes[i], fileNames[i], startTime);
   }
}
