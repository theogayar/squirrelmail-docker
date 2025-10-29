# 🐿️ SquirrelMail Docker Image

A lightweight and easy-to-deploy Docker image for [SquirrelMail](https://www.squirrelmail.org/index.php).
This image is designed for testing, learning, or local development — not for production use.

---

## ⚠️ Disclaimer

Important:
The PHP version used in this Dockerfile is outdated and should never be used in a production environment.
For secure and stable deployments, please use a modern PHP version and follow current best practices for mail server and web application security.

---

🚀 Quick Start

1. Clone this repository :
`git clone <https://github.com/theogayar/squirrelmail-docker.git>`

2. cd to the directory in which the Dockerfile resides :`cd squirrelmail-docker`

3. Build the Docker image using : `docker build -t squirrelmail .`

4. Run the container
`docker run -d -p 8080:80 squirrelmail`

Then open your browser and visit:

<http://localhost:8080>

You should see the SquirrelMail login page.
