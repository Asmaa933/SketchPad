## Used Design Patterns

### **MVVM**:-

I used the MVVM structure to cleanly achieve separation of concern for the user interface from the application logic. By using this architecture it helped in
- Independent of UI: The UI can change easily, without changing the rest of the system as we can substitute the table view with a collection view and we will not have to touch our logic
- Independent of the database and network: I can easily change them without breaking business rules.
- Testable: The business rules can be tested without the UI, database, web server, or any other external element.

### **Coordinator Pattern**:-

I used Coordinator to organize app navigation flow and configure controllers and view models. Instead of pushing and presenting view controllers from other view controllers. All the screens navigation will be managed by coordinators.

### **Delegate Pattern**:-




