# Introduction

This JDBC application gives us a simple, user-friendly way to access our database. In terms of technologies, Maven was used to setting up our environment. Docker was also used to run our database. For our java code, we used IntelliJ IDe. PSQL was used as our database. All this was done on my Linux OS.

# Implementaiton
## ER Diagram

![hplussport_ERD.PNG](/home/centos/dev/jarvis_data_eng_Francois/core_java/jdbc/hplussport_ERD.png)


## Design Patterns

Data access objects (DAO) are used to separate low-level data accessing API from operations from high-level business services. It provides abstraction between JDBC and the rest of the code. This is mostly used with data transfer objects (DTO). DAO patterns emphasize the low coupling of different components in an application. Because of this, the View layer has no dependency on the DAO layer and only the service layer depends on it.

As for the repository design pattern, it emulates a collection of objects. It can encapsulate storage, retrieval, and search behavior. It mediates between domain and data mapping layers. Because of this, it uses a collection-like interface for accessing domain objects. Repository deals with data and hides queries, much like DAO, but deals closer to business logic. In other words, the repository becomes very useful in systems where there is a large number of domain classes or heavy querying is done.
#Test
How you test your app against the database? (e.g. database setup, test data set up, query result)

I would frequently change the queries depending on the desired output to see if it worked.