Feature: Workspace
  This is where user can execute all trade operations
  Background:
    Given app URL is https://reactivetrader.com/
    And release is 3.0.1
    And Chrome Version is 96.0.4664.45
    And Windows 10 Home

  Rule: Basic trade operations
    # 1.1, 1.6
    Scenario Outline: Valid purchase with notional value shortcuts
      Given a single <currency pair> tile
      And buy and sell buttons enabled
      And a notional input has a <valid value>
      When click on the <trade operation button>
      Then an Execution screen appears until transaction is performed
      And tile displays green confirmation screen on success for a few seconds
      And the confirmation screen details transaction ID, notional, rate settling date, success message

      Examples:
        | currency pair |  valid value   | trade operation button |
        |    EUR/USD    |      1,200     |         buy            |
        |    EUR/JPY    |      20,300    |         sell           |
        |    EUR/CAD    |      450k      |         buy            |
        |    EUR/AUD    |      700k      |         sell           |
        |    USD/JPY    |      800k      |         buy            |
        |    GBP/USD    |      1,2m      |         buy            |
        |    AUD/USD    |      2,5m      |         sell           |
        |    NZD/USD    |      9,999,999 |         buy            |

  Rule: Demonstration of scenarios different from successful operations
    # 1.2
    Scenario: Rejected purchase confirmation
      Given GBP/JPY spot tile
      And buy and sell buttons enabled
      And a notional input is between 1 and 9,999,999
      When click on sell button
      Then an Execution screen appears until transaction is performed
      And the tile displays red negative screen with message “Trade was rejected” for a few seconds
    # 1.3
    Scenario: Timed out transaction
      Given EUR/JPY spot tile
      And buy and sell buttons enabled
      And a notional input is between 1 and 9,999,999
      When click on buy button
      Then an Execution screen appears until transaction is performed
      And the tile displays yellow aware screen with message “Trade taking longer than expected”

  Rule: RFQ operations
    # 1.4
    Scenario: High notional RFQ
      Given NZD/USD spot tile
      And a notional input is greater than or equal to 10m
      And streaming prices are shown
      And buy and sell buttons unabled
      And Initiate RFQ button is shown
      When click Initiate RFQ
      Then Cancel RFQ button is shown (for a brief second)
      And Awaiting price loader is shown in place of Sell/Buy buttons (for a brief second)
      And RFQ sell price shown (red color fades as timer runs out)
      And RFQ buy price shown (blue color fades as timer runs out)
      And display fixed prices for buy / sell, with a higher margin
      And a 10-second countdown scale with a Reject button is shown
      And after 10 second countdown, buy / sell values will be greyed out
      And a requote button appears
    # 1.5
    Scenario: RFQ mode
      Given USD/JPY spot tile
      And a notional input is greater than or equal to 10m
      And streaming prices are shown
      And buy and sell buttons unabled
      And Initiate RFQ button is shown
      When click Initiate RFQ
      And click on reject RFQ
      Then values are greyed out to
      And Requote button will appear
      And after 60 seconds the quoted prices will disappear
      And the Initiate RFQ button will reappear with streaming prices in the background

  Rule: Warning notification
    # 1.7
    Scenario Outline: Value is too large
      Given a single <currency pair> tile
      When a notional input has a <too large value>
      Then an error will appear ‘Max exceeded’

      Examples:
        | currency pair | too large value |
        |    EUR/USD    |   2,000m        |
        |    EUR/JPY    |   1,000,000,001 |
        |    EUR/CAD    |   3,000,000,000 |
        |    EUR/AUD    |   40,000m       |
        |    USD/JPY    |   500,000m      |
        |    GBP/USD    |   700,000m      |
        |    GBP/JPY    |   6,500,000,000 |
        |    AUD/USD    |   800,000m      |
        |    NZD/USD    |   9,000m        |

  Rule: Moving spot tiles
    # 1.8
    Scenario Outline: Undocking tile windows
      Given currency tiles are on the main mage
      When hover over a <tile> and click Pop Out button
      Then the <tile> will undock and appear in a separate window
      And this window will have a corresponding URN (/spot/CCYCCY)

      Examples:
        | the tile |
        |  EUR/USD |
        |  EUR/JPY |
        |  EUR/CAD |
        |  EUR/AUD |
        |  USD/JPY |
        |  GBP/USD |
        |  GBP/JPY |
        |  AUD/USD |
        |  NZD/USD |
    # 1.9
    Scenario Outline: Re-docking tile windows
      Given undocked currency pair tiles windows
      When click on Close or Pop In button of the <undocked tile> window
      Then tile will back to its original undocked location

      Examples:
        | undocked tile |
        |    EUR/USD    |
        |    EUR/JPY    |
        |    EUR/CAD    |
        |    EUR/AUD    |
        |    USD/JPY    |
        |    GBP/USD    |
        |    GBP/JPY    |
        |    AUD/USD    |
        |    NZD/USD    |

  Rule: Adjusting Workspace views
    # 1.10
    Scenario: Toggle between prices and graph views
      Given a Tile view button is in <state>
      And tiles are in <view>
      When click on Tile view button
      Then a Tile view button is in alter <state>
      And tiles are in the alter <view>

      Examples:
        |  state   |   view    |
        | enabled  | analytics |
        | disabled | normal    |
    # 1.11
    Scenario Outline: Toggle between tile filters
      Given a <number of tiles> is displayed
      When click on a currency <filter>
      Then a <number of tiles> changes
      And currencies are shown according to the chosen <filter>

      Examples:
        | filter | number of tiles |
        |   ALL  |       9         |
        |   EUR  |       4         |
        |   USD  |       5         |
        |   GBP  |       2         |
        |   AUD  |       2         |
        |   NZD  |       1         |
    # 1.12
    Scenario: Undocking Workspace section
      Given Workspace section shown on the main page
      When hover over and click on Pop Out button
      Then Workspace will undock and appear in a separate window
      And this window will have a corresponding URN (/liverates)
    # 1.13
    Scenario: Re-docking Workspace window
      Given Workspace section shown in a separate window
      When click on Close or Pop In button of the window
      Then Workspace will back on a main page

  Rule: Manipulations with Notional value
    # 1.14
    Scenario: Delete Notional input value
      Given a Notional value greater than 0
      When click on the Notional value
      And press "Backspace" or "Delete" button
      Then  Notional value becomes 0
    # 1.15
    Scenario: Reset Notional input value
      Given a Notional value greater or less than default value
      When click on the Reset button
      Then a Notional value back to the default value
