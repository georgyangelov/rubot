FROM ruby:2.3

WORKDIR /rubot

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --without=test

COPY . /rubot

ENV RACK_ENV production

CMD ["bundle", "exec", "bin/rubot"]
