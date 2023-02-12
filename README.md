# igdbTest
This project is an example of an app in SwiftUI with MVVM pattern, including Coordinator to manage the navigation, and Testing

Structure:

- Common

    Supponting classes to the whole app, as extensions, method to resume actions, etc.

- Data

    Data resume all the integration with the server. It has been devided in three areas:
       - Reposotory
            Containt the access to the services
       - Model
            Objects with the struture of the info that has been returned by the server
       - Api
            Class that supports the funtionality to access to the REST services. This class use Moya library.

- Domain

    All the info object used by the client-side of the app
    
       - Model
       
           Contains the translation of the domain's object to client-side objects
           
       - UseCase
       
           Bridges between repository and the result client-side objtain. As example, HomeUseCase has method execute. This method launch two different calling to services REST and merge the info.
         
- Presentation

    Contains all the classes related with the client - side.
    
        - ViewModel
        
        Classes that take the control of the views
        
        - Coordinator
        
        This layer is not specific to the MVVM pattern, maybe to the MVVM-C... it is a very useful layer to manage the navigation between views of the app.
        
        - View
        
        Constains the views
    
- Resources

   Contain all the resources asociated to the project, as localized strings, images, etc...
   
   
   
External libs

  - R.swift. Lib used to codify the resurces. It is very useful to avoid incorrect vanilla references. https://github.com/mac-cain13/R.swift
  
  - Moya. It supports the invocation of the most basic layer REST services. https://github.com/Moya/Moya
  
  - Swinject. It suports the injection of dependencies https://github.com/Swinject/Swinject
  
  
  Testing
  
    Project includes a very simple testing:
       - GameTests. Gives testing to the basic integration of the game service
   
