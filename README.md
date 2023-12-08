# ChatSystemAPI 💬

1.  👋 [Introduction](#intro)
2.  🎥 [Instructions Video](#instructions-video)
3.  🏗️ [Installation](#installation)
    -   [Prerequisites](#prerequisites)
    -   [Getting Started](#getting-started)
4. 🧪 [Testing](#testing)
5. 🛝 [API Testing](#api-testing)
6. ⭐️ [Future Improvements](#future-improvements)
7. 💪 [Challenges](#challenges)

ChatSystemAPI is a full RESTful API application to handle chats between your different applications, where you could have different chat and each chat has many messages. the API allows you to Read, create and Update on all resources. along with a dedicated search Endpoint to search certain chat for messages bodies, it's my solution to a take home assignment from a company hiring process.

## Instructions video<a name="video"></a>
I'm a visulaiser guy too, in this short video I demonstrate how to install, start and run tests in our application, using docker and postman.



## Installation
### Prerequisites

| Tool | Download link |
|--|--|
| Git | [Link](https://git-scm.com/downloads) |
| Docker compose | [Link](https://docs.docker.com/compose/install/)  |
| Postman | [Link](https://www.postman.com/downloads/) |


### Getting Started
- Clone the current repository
	- `git clone git@github.com:od-c0d3r/chat_system_api.git`
- Run command to start docker containers
	- `docker-compose up --build`
- Now you can do two things

### Testing
- To run the tests first open up the rails container bash in your terminal
	- `docker-compose exec web bash`
- Run the following to run the tests
	- `RAILS_ENV=test rspec -f d`
		- `-f` formatting flag along with the `d` documentation option, to print our tests in a neat nice coloring look.

### API Testing
- After making sure that our containers are up and running
- Open `Postman` desktop and import `InstaChat.postman_collection.json` file, that will bring the APIs at your finger prints to start use right away.

## Future Improvements
- Using Pagination in response.
- Enhance error handling mechanism.

## Challanges
- Testing Elasticearch & background workers
