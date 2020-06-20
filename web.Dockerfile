# You can set the Swift version to what you need for your app. Versions can be found here: https://hub.docker.com/_/swift
FROM swift:5.0 as builder

# For local build, add `--build-arg env=docker`
# In your application, you can use `Environment.custom(name: "docker")` to check if you're in this env
ARG env

RUN apt-get -qq update && apt-get install -y \
  libssl-dev zlib1g-dev libgd-dev \
  && rm -r /var/lib/apt/lists/*

WORKDIR /app
COPY . .
RUN mkdir -p /build/lib && cp -R /usr/lib/swift/linux/*.so* /build/lib
RUN swift build -c release && mv `swift build -c release --show-bin-path` /build/bin

# Production image
FROM ubuntu:18.04

ARG ENV=production
ARG DB_URL
ARG PORT=8080

# DEBIAN_FRONTEND=noninteractive for automatic UTC configuration in tzdata
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  libatomic1 libicu60 libxml2 libcurl4 libz-dev libbsd0 tzdata libgd3 jq \
  && rm -r /var/lib/apt/lists/*

WORKDIR /app
COPY --from=builder /build/bin/Run .
COPY --from=builder /build/lib/* /usr/lib/
COPY --from=builder /app/Public ./Public
COPY --from=builder /app/Resources ./Resources

# expose with env variable
ENV ENVIRONMENT $ENV
ENV DATABASE_URL $DB_URL
ENV PORT $PORT
# verify if this is needed
EXPOSE 8080:8080

# Add overwirte Database string to customize the fetch env
# ENTRYPOINT DATABASE_URL="$(echo $VCAP_SERVICES | jq ."aws_aurora_shared"[0]."credentials"."uri" | tr -d '"')" \
#   ./Run serve --env $ENVIRONMENT --hostname 0.0.0.0 --port $PORT
ENTRYPOINT ./Run serve --env $ENVIRONMENT --hostname 0.0.0.0 --port $PORT
