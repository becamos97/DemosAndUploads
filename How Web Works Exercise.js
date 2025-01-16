//Part 1
1. HTTP is Hypertext Transfer Protocol and its just a set of rules
 on how browsers and servers should communicate with each other

2.URL is a Uniform Resource Locator and its a web address that pinpoint
 to a specific resource in the internet

3. DNS means Domain Name system and its the system that translates domain names into IP addresses

4.Query string is a part of a URL that follows a question mark and its used to pass 
additional information to a web servers in the form of key-value pairs

5.Two HTTP verbs are GET and its used to request data from a resource,
 and POST is used to submit data to be processed

6. Its a message sent by a client to a server to request information or initiate any action

7. A HTTP response is a message sent by a web server to a client after receiving and processing and HTTP request.

8. A HTTP header is a component of an HTTP request or repsonse that provides additional information to the server or client about
the data being sent. Some headers that i remember seeing of the top of my head are something like: 
text/html or application/json or sessionID-456abc

9. When I hit Enter:
 ->The browser read the URL
 ->Browser starts DNS Lookup
 ->The browser establicshes a TCP connection with the server using the resolved IP address
 ->Browser sends an HTTP request to the server
 ->The server processes the request
 ->The server responds with a status ConvolverNode, a header and a Body 
 ->The Browser processes the HTML content
 ->Browser displays a final representation of the page

 ----Part three Key Points-----
 GET vs. POST:

 GET: Data is sent via the URL (query string), which is visible and has size limitations.
 POST: Data is sent in the request body, making it more secure and capable of handling larger payloads.
 Chrome DevTools Insights:
 
 The Headers tab shows metadata about the request (method, URL, etc.).
 The Payload tab (for POST) displays the form data submitted in the body.

 