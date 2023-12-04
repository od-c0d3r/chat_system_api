FROM ruby:3.0.4
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
