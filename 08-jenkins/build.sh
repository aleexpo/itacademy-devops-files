export GOPATH=$WORKSPACE
export PATH="$PATH:$(go env GOPATH)/bin"

sed -i 's/1.DEVELOPMENT/1.$BUILD_NUMBER/g' ./rice-box.go

make

md5sum artifacts/*/word-cloud-generator* >artifacts/word-cloud-generator.md5

gzip artifacts/*/word-cloud-generator*
