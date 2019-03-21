FROM ruby:2.6
MAINTAINER gugutz@gmail.com

RUN apt-get update && apt-get -y install build-essential nodejs postgresql-client 

RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install 
# the RubyGems. This is a separate step so the dependencies 
# will be cached unless changes to one of those two files 
# are made.
COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler && bundle install --jobs 20 --retry 5

# copy the main app to the container
COPY . ./

EXPOSE 3000
# Configure an entry point, so we don't need to specify 
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

CMD ["rails", "server", "-b", "0.0.0.0"]
