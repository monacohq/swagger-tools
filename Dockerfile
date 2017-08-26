FROM ruby:2.4.1
RUN gem install sinatra
RUN mkdir /app
RUN mkdir /app/data
WORKDIR /app
ENV PORT 8888
EXPOSE 8888
CMD ["ruby", "swagger-tools.rb"]
VOLUME ["/app/data"]

ADD swagger-tools.rb /app/swagger-tools.rb
