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

# Next...
* Refactor controller testing
* Rework Interest Controller to receive interest from negative balances
* Add rollback facility
* Add id verification back into controllers and test
* Raise errors from accounts and catch in controller
* Create interest and overdrafts module
* Add try statements to controller
* Add message colours
* Refactor new loan procedure
