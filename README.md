# banking_application

An exercise in Object Oriented Programming, worked on at the Greenwich School of Management, Software Development Coursework. 

## Task
Create a basic command line interface for a banking clerk. The system should have the following functionality/features:
* Create and Store Accounts
* Deposit, Withdraw, Transfer, Show Balance
* Create and Store Holders
* Overdrafts
* Loans
* Failsafe rollback facility
* Automated Interest Payments

## Key Learning areas
* [Rufus Task Managing Gem](https://github.com/jmettraux/rufus-scheduler)
  Used to schedule interest payments and account limit rollbacks
* [Sinatra](https://github.com/sinatra/sinatra)
  Used to create graphical representation of the application
* [Timecop](https://github.com/travisjeffery/timecop)
  Used to test time scheduled events
* [Rspec](https://github.com/rspec/rspec)
  Used for unit testing

## Design Patterns

### Singleton Pattern
The singleton pattern, as the name suggests, ensures only a single instance of a class can be created. It also gives a global reference point to the class.
It was used in the program on each of the controllers to ensure that the entire program had access to the same data set, for storing/updating accounts, loans and holders.

### Memento Pattern
The memento pattern provides the ability to restore an object to its previous state.
It was used in the program to store the state of a donar account before a transfer was initiated, then if the recipitent account was found to not exist, the state of the donar account could be reverted.

## UML Diagrams

### Class Diagram
![ScreenShot](https://github.com/robertpulson/banking_application/blob/master/screenshots/Main.png)

The repo also contains a sequence diagram for each of the use cases, they can be found [here](https://github.com/robertpulson/banking_application/tree/master/screenshots).

## Getting Started

Open up a terminal window

Clone the repo with `git clone git@github.com:robertpulson/banking_application.git`

Navigate into the directory with `cd banking`.

Run the program with `ruby lib/boundary.rb` or the test suite using `rspec`.
