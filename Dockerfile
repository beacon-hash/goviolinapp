FROM golang:latest

ENV APP_USER app
ENV APP_HOME /build/goviolin
RUN groupadd $APP_USER && useradd -m -g $APP_USER -l $APP_USER

RUN mkdir -p $APP_HOME && chown -R $APP_USER:$APP_USER $APP_HOME
WORKDIR $APP_HOME

USER $APP_USER 

COPY . /$APP_HOME

RUN go mod init && go build -o violinApp 

EXPOSE 8080

ENTRYPOINT [ "./violinApp" ]
