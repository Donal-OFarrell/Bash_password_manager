
Overview:
This project is an implementation of a password management system written entirely in the bash scripting language designed to run on Ubuntu.

What is the system supposed to do?

The system is supposed to be a password manager for multiple users. Users can store passwords for multiple services.
Scripts carry out the main operations of the program such as initializing users and inserting, removing and inspecting services and their respective payloads (logins and passwords).
These scripts interact with a server which carries out these operations in response to that case being called in a case loop structure.
The client side of the application allows a user to input requests which are sent to the server and are processed accordingly. Communication goes back and forth between the server and the client side via named pipes.
The scripts must also protect against two critical processes being accessed simultaneously. This is achieved by putting semaphore locks in the critical sections of the respective scripts that require them (init,insert,rm).
Users are stored as a directory/folder which can contain the sub-folders and files which contain the logins and password details. After a user has been initialized, they can add services to this directory. They have the option to either add a sub folder such as bank/aib.ie or just bank.ie which is just a file. Then thereafter the payload which contains the login and password can be written to the file in question. Services can be removed. Services can viewed via show. A tree directory can be viewed using the ls script.
The main scripts are hosted in the server as cases. If a correct series of arguments is passed from the client side, the server will process these args and carry out the correct case.

