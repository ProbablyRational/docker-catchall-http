# docker-catchall-http
A simple docker image to serve index.php to all inbound requests

- PAGE_TITLE = "Service unavailable"
- PAGE_BODY = "#domain# is currently unavailable"
- PAGE_HOMELINK = "https://probablyrational.com/about"
- PAGE_HOMETEXT = "About us"

`docker run -d -p 80:80 probablyrational/catchall-http`
