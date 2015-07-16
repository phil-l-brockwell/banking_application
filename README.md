# banking_application

An exercise in Object Oriented Programming, worked on at the Greenwich School of Management, Software Development Coursework.

# So Far...
* Now has all functionality of original program
* Used rspec to test most functionality; 137 tests passing
* Added Gemfile with Rspec, Timecop and Rufus
* Added message classes: Error/Success.
* Added Boundary class
* Added automated interest payments using Rufus
* Added Holder, Interest and Loans controllers
* Added Holder storage module
* Used singleton pattern on Account, Holder and Loan Controllers
* Added overdraft controller and facility
* Used memento pattern to rollback account transfers
* Built basic web ui and deployed with Heroku

# Next...
* Raise error on islamic account if overdraft switched on
* Write readme
* Ensure all money is output in correct format
* Ensure command line version runs on Windows
