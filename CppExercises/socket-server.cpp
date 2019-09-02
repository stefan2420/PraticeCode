// 18-05-2019 Matthijs Reyers
// 
// Mingw64 compiler args:
// -std=gnu++11 -lws2_32

// These headers are used for windows socket communications over TCP/IP.
#include <winsock2.h> 
#include <ws2tcpip.h>

// Cause strings are easy to work with.
#include <string>
using string = std::string;

// Needed for logging messages to the terminal.
#include <iostream>

// Needed for threading.
#include <thread>

// Function for getting user input
// -------------------------------------------------------------------------------------------
string input()
{
    std::cout << "(MESSAGE): ";
    string message;
    std::getline(std::cin, message);
    message.append("\n");
    return message;
}

// 
// -------------------------------------------------------------------------------------------
void SendingThread(SOCKET AcceptingSocket)
{
    // Now we can actually send stuff to the client using the new socket.
    string message;
    while (1)
    {
        // Get the user input.
        message = input();

        // Check if the user gave a command, otherwise send message.
        if (message.at(0) == '/'){
            if (message == "/exit\n") exit(0);
        }
        else {
            send(AcceptingSocket, message.c_str(), strlen(message.c_str()), 0);
        }
    }
}

// 
// -------------------------------------------------------------------------------------------
void RecievingThread(SOCKET AcceptingSocket)
{
    char RecievingBuffer[1024];

    while(1)
    {
        recv(AcceptingSocket, RecievingBuffer, sizeof(RecievingBuffer), MSG_PEEK);
        std::cout << RecievingBuffer;
    }
}

// Main function
// -------------------------------------------------------------------------------------------
int main(int argc, char* argv[])
{
// WSAStartup function initiates use of the Winsock DLL needed for comunication over TCP/IP sockets.
    WSADATA WSAData;
    int WSAstart = WSAStartup(MAKEWORD(2,0), &WSAData);
    if (WSAstart != 0) {printf("The WSAStartup failed.\n");exit(1);}

    // Creating a socket object to listen for incomming connections on. And checking if the creation of socket was successfull
    SOCKET ServerSocket = socket(AF_INET, SOCK_STREAM, 0);
    if (ServerSocket == INVALID_SOCKET) {printf("Unable to create socket.\n");exit(1);}

    // Creating and filling the address structure for the socket.
    struct sockaddr_in ListeningStructure;
    ListeningStructure.sin_family = AF_INET;         // Replace with AF_INET6 for IPv6 adresses.
    ListeningStructure.sin_addr.s_addr = INADDR_ANY; // Automatically fill in the connecting PC's address.
    ListeningStructure.sin_port = htons(888);       // The htons() function will format the port number properly. (See wikipedia 'Endianness')

    // Binding the socket to the address structure. (Note that the output of bind() doesn't have to be saved and is only used for the check).
    int BindSuccess = bind(ServerSocket, (struct sockaddr *) &ListeningStructure, sizeof(ListeningStructure));
    if (BindSuccess < 0) {printf("Unable to bind socket.\n");exit(1);}

    // Tell the socket to listen, maximum size of backlog queue = 5. The listen() function places all incoming connections into a backlog queue until an accept() function actually accepts the connections.
    listen(ServerSocket, 5);

    // The accept function needs a pointer to a variable to store the addres structure in.
    struct sockaddr IncommingAddr;
    int IncommingAddrLength = sizeof(IncommingAddr);

    // In order to actually do something with the incomming connection a new socket needs to be created to comunicate over, this is done with the accept() function. 
    SOCKET AcceptingSocket = accept(ServerSocket, &IncommingAddr, &IncommingAddrLength);
    if (AcceptingSocket < 0) {printf("Unable to accept incomming connection.\n");exit(1);}

    // Creating threads for sending and recieving.
    std::thread SendThread(SendingThread, AcceptingSocket);
    std::thread RecvThread(RecievingThread, AcceptingSocket);
    SendThread.join();
    RecvThread.join();

    // End program by closing the connection/destroying the socket.
    closesocket(ServerSocket);
    closesocket(AcceptingSocket);
    WSACleanup();
    return 0;
}
