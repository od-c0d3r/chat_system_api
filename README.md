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

ChatSystemAPI, a RESTful API Rails application designed to facilitate communication between different applications. This solution addresses the need for managing various chats, each containing multiple messages. The API enables reading, creating, and updating resources, and features a dedicated search endpoint for querying message bodies within specific chats. This project emerged as my response to a take-home assignment as part of a company's hiring process. To ensure progress and organization, I utilized a Kanban board, managing tasks and activities efficiently. The Trello board, accessible at this [Link](https://trello.com/invite/b/PSA83cvF/ATTIe159ef77c4be4720bd8e03877c85be9e3D019952/chatsystemapi), served as a tool for smart and organized project management.

## Instructions video<a name="video"></a>
I'm also a visualizer, and in this short video, I demonstrate how to install, start, and run tests in our application using Docker and Postman.

[Watch the video here](https://www.youtube.com/watch?v=9Ue7FtRXvUQ)

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
		- Using the `-f` formatting flag along with the `d` documentation option to print our tests in a neat, nice coloring look.

### API Testing
- After making sure that our containers are up and running
- Open `Postman` desktop and import `ChatSystemAPI.postman_collection.json` file, which will bring the APIs at your fingertips to start using right away.

## Future Improvements
- Implementing Pagination in the response.
- Enhancing the error handling mechanism.

## Challanges
- Testing Elasticearch & background jobs.
