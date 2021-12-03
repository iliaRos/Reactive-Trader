Feature: Blotter section
  This section shows a table of all the executed trades.
  It allows filter records and export them in CSV.
  # 2.2
  Rule: Blotter table displays executed trade
    Scenario: Update Trades table
      Given a last trade ID is 'n'
      And table filters are disabled
      And blotter status displays 'x' numbers of rows shown on the table
      When click on buy/sell tile buttons
      Then blotter flashes to highlight new transaction
      And a last trade ID becomes 'n+1'
      And the last entry is relevant to the last operation
      And blotter status displays 'x+1' numbers of rows shown on the table
  # 2.3
  Rule: Observing Blotter table filters
    Scenario: Showcase table filters
      Given blotter table
      When mouse over the column title
      Then filter icon will appear

    Scenario: Showcase numeric filters
      Given columns with numeric data (Trade ID, Trade Date, Notional, Rate, Value Date)
      When click on the drop-down list of filter options in one of these columns
      Then a list of numeric filter options shown (i.e. Equals, Not equal, Greater etc.)

    Scenario: Showcase text filters
      Given columns with text data (Status, Direction, CCYCCY, Deal CCY, Trader)
      When click on the drop-down filters list in one of these columns
      Then a list of text filters shown (i.e. Done, Rejected, Buy, Sell etc.)

  Rule: Enable/disable blotter table filters
    Scenario: Enable numeric filter
      Given blotter table with some entries
      When enable filter in one of the columns with numeric data
      Then only those items shown that met filter condition
      And the blotter status displays the number of these items
      And the column title appears in the blotter header

    Scenario: Enable text filter
      Given blotter table with some entries
      When enable filter in one of the columns with text data
      Then only those items shown that met filter condition
      And the blotter status displays the number of these items
      And the column title appears in the blotter header

    Scenario: Enable multiple filters
      Given blotter table with some entries
      When enable filters in several columns at once
      Then only those items shown that met filters conditions
      And the blotter status displays the number of these items
      And the columns titles appear in the blotter header

    Scenario: Using search filter
      Given blotter table with some entries
      When enter any number or text in search filter
      Then only those items shown that met searching condition at least in one column
      And the blotter status displays the number of these items

    Scenario: Disable column filter
      Given a blotter table filter enabled
      And only those items shown that met filter condition
      And the blotter status displays the number of these items
      And column title where the filter applying showed in the blotter header
      And close button is right to it
      When click on the close button
      Then the blotter table filter disabled
      And all items shown on the table
      And blotter status displays the number of all items
      And there is no column title showed in the blotter header
 Rule: sorting entries
    Scenario: Sorting entries
      Given blotter table with some entries
      When click on a column title
      Then arrows showing the order of sorting appears right to the title
      And entries become ordered ascending or descending
 Rule: export entries
    Scenario: Export all entries in CSV
      Given blotter table with some entries
      And filters are disabled
      When click on Excel button
      Then a .csv is downloaded containing all the blotter content

    Scenario: Export paricular entries in CSV
      Given blotter table with some entries
      And a filter is set
      When click on Excel button
      Then a .csv is downloaded containing only the filtered content
 Rule: Moving blotter section
    Scenario: Undocking blotter section
      Given blotter section shown on the main page
      When hover over and click on Pop Out button
      Then blotter will undock and appear in a separate window
      And this window will have a corresponding URN (/blotter)

    Scenario: Re-docking blotter window
      Given blotter section shown in a separate window
      When click on Close or Pop In button of the window
      Then blotter will back on a main page
