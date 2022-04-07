### Скрипт для сборки проекта
```bash
export GOPATH=$WORKSPACE/go
export PATH="$PATH:$(go env GOPATH)/bin"

go get github.com/tools/godep
go get github.com/smartystreets/goconvey
go get github.com/GeertJohan/go.rice/rice
go get github.com/wickett/word-cloud-generator/wordyapi
go get github.com/gorilla/mux


sed -i "s/1.DEVELOPMENT/1.$BUILD_NUMBER/g" static/version

GOOS=linux GOARCH=amd64 go build -o ./artifacts/word-cloud-generator -v .

gzip artifacts/word-cloud-generator
mv artifacts/word-cloud-generator.gz artifacts/word-cloud-generator

ls -l artifacts/
```

### Скрипт для развертывания приложения на сервере
```bash
sudo service wordcloud stop

curl -X GET "http://192.168.33.90:8081/repository/word-cloud-build/1/word-cloud-generator/1.$BUILD_NUMBER/word-cloud-generator-1.$BUILD_NUMBER.gz" -o /opt/wordcloud/word-cloud-generator.gz
ls -l /opt/wordcloud
gunzip -f /opt/wordcloud/word-cloud-generator.gz
chmod +x /opt/wordcloud/word-cloud-generator

sudo service wordcloud start
```

systemd servie  /etc/systemd/system/wordcloud.service
```bash
[Unit]
Description=Word Cloud Generator

[Service]
WorkingDirectory=/opt/wordcloud
ExecStart=/opt/wordcloud/word-cloud-generator
Restart=always

[Install]
WantedBy=multi-user.target

```

### Интеграционные тесты
```bash
res=`curl -s -H "Content-Type: application/json" -d '{"text":"ths is a really really really important thing this is"}' http://192.168.33.80:8888/version | jq '. | length'`
if [ "1" != "$res" ]; then
  exit 99
fi

res=`curl -s -H "Content-Type: application/json" -d '{"text":"ths is a really really really important thing this is"}' http://192.168.33.80:8888/api | jq '. | length'`
if [ "7" != "$res" ]; then
  exit 99
fi
```
