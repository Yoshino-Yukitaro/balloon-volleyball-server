FROM ruby:3.1.4-alpine AS builder
ENV LANG ja-JP.UTF-8
ENV TZ=Asia/Tokyo

RUN apk update && apk upgrade && \
    apk add --no-cache linux-headers libxml2-dev make gcc libc-dev nodejs yarn tzdata bash mysql-dev && \
    apk add --no-cache -t .build-packages --no-cache build-base curl-dev mysql-client

RUN mkdir /app

RUN gem install bundler:2.3.7

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .

COPY config.ru .
COPY Rakefile .

COPY /app ./app
COPY /bin ./bin
COPY /config ./config
COPY /db ./db
COPY /lib ./lib 
COPY /public ./public
COPY /storage ./storage
COPY /test ./test
COPY /tmp ./tmp
COPY /vendor ./vendor

# j4をつけることで並列で実行することができる
RUN bundle install -j4

FROM ruby:3.1.4-alpine AS release
ENV LANG ja-JP.UTF-8
ENV TZ=Asia/Tokyo

RUN apk update && apk upgrade && \
    apk add --no-cache linux-headers libxml2-dev make gcc libc-dev nodejs yarn tzdata bash mysql-dev && \
    apk add --no-cache -t .build-packages --no-cache build-base curl-dev mysql-client

RUN mkdir /app

WORKDIR /app

COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY config.ru .
COPY Rakefile .

COPY /app ./app
COPY /bin ./bin
COPY /config ./config
COPY /db ./db
COPY /lib ./lib 
COPY /public ./public
COPY /storage ./storage
COPY /tmp ./tmp
COPY /vendor ./vendor

RUN if [ "${RAILS_ENV}" = "staging" ]; then \
        cp config/credentials_stg.yml.enc config/credentials.yml.enc; \
    elif [ "${RAILS_ENV}" = "production" ]; then \
        cp config/credentials_prod.yml.enc config/credentials.yml.enc; \
    else \
        echo "おいそこのお前！これはリリース用ビルドだぞ！？"; \
fi

EXPOSE 3000
CMD ["rails", "db:migrate", "db:seed", "server", "-b", "0.0.0.0"]