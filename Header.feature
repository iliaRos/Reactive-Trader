Feature: Header

  Background:
    Given app URL is https://web.uat.reactivetrader.com/
    And Chrome Version is 96.0.4664.45
    And Windows 10 Home

  Scenario Outline: A theme control button availability
    Given <init> theme is activated
    When a cursor hover on theme <icon> symbol
    Then a theme control button appears
    And a cursor type changes

    Examples:
      | init  | icon      |
      | light | sun       |
      | dark  | half-moon |

  Scenario Outline: Toggling page theme
    Given <init> theme is activated
    When toggle theme control button
    Then <alter> theme is activated

    Examples:
      | init  | alter |
      | light | dark  |
      | dark  | light |

  Scenario Outline: Synchro toggling page theme in the separate windows
    Given <init> theme is activated
    And <section> is in a separate window
    When toggle theme control button
    Then <alter> theme is activated

    Examples:
      | init  | alter |
      | light | dark  |
      | dark  | light |

    Scenario: refreshing page
    Scenario: duplicate window
