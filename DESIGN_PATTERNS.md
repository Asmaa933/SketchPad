## Used Design Patterns

### **MVVM**:-

I used the MVVM structure to cleanly achieve separation of concern for the user interface from the application logic. By using this architecture it helped in
- Independent of UI: The UI can change easily, without changing the rest of the system as we can substitute the table view with a collection view and we will not have to touch our logic
- Independent of the database and network: I can easily change them without breaking business rules.
- Testable: The business rules can be tested without the UI, database, web server, or any other external element.

### **Coordinator Pattern**:-

I used Coordinator to organize app navigation flow and configure controllers and view models. Instead of pushing and presenting view controllers from other view controllers. All the screens navigation will be managed by coordinators.

### **Observer Pattern**:-

I used Notification Center to notify the edit cycle and passing the sketch data in the info by adding observer in DrawingViewModel and post the notification from HistoryViewModel

### **Delegation Pattern**:-
I used delegation and callbacks to notify actions from subviews to view controllers and communicate between classes, also I used the delegates of UIKit like UITableViewDelegate, UISearchBarDelegate


### **Singlton Pattern**:-

I used Singlton to ensure that I have only one isnstance of CachingManager 


### **State Pattern**:-

I used State to let the view controllers know there is changes in state and they should render or do something


### **Chain of Responsibility**:-

passing chain of handlers from subview -> viewController -> viewModel and then make process in the viewModel.



