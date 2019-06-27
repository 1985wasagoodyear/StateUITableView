
## StateUITableView

Created: October 22, 2018

Updated: June 27, 2019

Inspired by this article here:
https://www.raywenderlich.com/5542-enum-driven-tableview-development

## Idea:
-   A custom TableView class to handle the various states of a tableView with loading,
    error, empty, and normal properties.
-   Avoids the issues of multiple decision trees in each of a TableViewDataSource's
    delegate methods (which can become a mess)
-   Easily adoptable


## Concept of connections:
-   some ViewController/DataSource/etc with a TableView
-   some manager that handles networking/loading data/etc
-   some TableView (that this subclasses)

## How it works:
-   VC sets delegates for protocol and errorProtocol
-   StateTableView is the TableViewDataSource for the tableView but if there is data,
    it asks the VC's TableViewDataSource methods via delegate chaining
-   Shows different errors otherwise, via ErrorProtocol or by default

## Installation

### CocoaPods

StateUITableView is available through [CocoaPods](https://cocoapods.org):

```ruby
pod 'Disintegrate'
```

## Concerns / Areas to Improve:
-   sideeffects are uncertain
-   framework is called StateUITableView but the class is just StateTableView
