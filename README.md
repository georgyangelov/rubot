# Installation

1. Register a bot at `http://slack.com/services/new/bot`
2. Copy `config/secrets.yml.example` to `config/secrets.yml` and edit
3. Run `bundle exec bin/rubot`

`docker build -t rubot .`
`docker run -d --restart=on-failure:3 -v /home/astea/rubot/data:/rubot/data rubot`
