docker stop rubot
docker rm rubot

docker build -t rubot .
docker run -d --restart=on-failure:3 -v /home/astea/rubot/data:/rubot/data --name rubot rubot
