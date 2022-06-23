# flutter_calendar_expense_tracker

This is a Flutter version of an Angular App that I created to help me track my budget/expenses and to help me estimate how much money I'll have in the future. I used this as a way to learn cross-platform developmenet specically for mobile.

This app requires users to have a Google account as well as a Google Calendar.

In order to track budget/expenses, the app uses the users Google Calendar Events to calculate/estimate money. The app looks at the color that was assigned to the Event and the monetary value in the description to start calculcations. The app then creates an Event at the end of the week (Saturday) that has the amount of money that a user should have at the end of the week given all of the events leading up to the end of the week.


## Getting Started

Before you start tracking budget/expenses, you need to create Events in the Google Calendar that the app can recognize. There are two kinds of events that can be created:
1) `Income Event`-  Created by creating an event in the calendar, assigning the color "Sage" to the event, and having a description that has a "$" symbol followed by a number. 
  <br> `Example Event Description: "I get paid today $100000"`</br>

2) `Expense Event`- Created by creating an event in the calendar, assigning the color "Tomato" to the event, and having a description that has a "$" symbol followed by a number. 
   <br>`Example Event Description: "Pay Rent $100000"`</br>

Once you have all events in place in the calender, you can start tracking budget/expenses
To start tracking budget/expenses do the following:

1) Sign into the app
2) Put how many weeks you want to estimate/buget for. This will load all events that are in the calender for the specified amount of weeks.
3) Put how much money you currently have
4) Press the insert button

This will then create events that show how much money you should have at the end of the week.

If you have less money, then you've spent too much
<br>If you have more money, then you have some money to spare</br>

## Showing only events at the end of the week

Sometimes it can get tedious scrolling through all of the events for the specified amount of weeks. So you can Toggle between showing all Events or only Events created at the end of the week by the app by pressing the Toggle Button
