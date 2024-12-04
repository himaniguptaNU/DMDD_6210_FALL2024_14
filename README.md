INSTRUCTIONS TO EXECUTE – ORACLE (Version 23.1.1)
1.	Script 1(create_supervisor.sql)- We create an application admin name SUPERVISOR and grant permissions.
2.	You need to login as SUPERVISOR with the credentials (username: Supervisor, password: Sup3rv1s0r@123) for next step.
3.	For all the below scripts use supervisor as the connection.
4.	Script 2(create_table.sql)- Create tables with appropriate constraints.
5.	Script 3(create_dml.sql)- Inserting values inside the created tables.
6.	Script 4(create_views.sql)- Run the script for creating views.
7.	Script 5(create_user_roles.sql)- Creating different user roles and grant privileges to each roles.
8.	Script 6(Functions.sql)- Run the script for creating the functions.
9.	Script 7(Triggers.sql)- Run the script.
10.	Script 8(Pkg_Utility.sql)- This package will centralize the logic and provide a shared interface for all roles.
11.	Script 9- Can run any packages in the package folder except User_Grant_Package and Script 8.
12. Run the User_Grant package in the package folder.
