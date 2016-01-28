FROM ruby:2.3

WORKDIR /rubot

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . /rubot

CMD ["bundle", "exec", "bin/rubot"]
