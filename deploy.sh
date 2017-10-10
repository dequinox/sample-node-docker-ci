#!/bin/bash
docker push alnair/sample-node

ssh alikhil@35.187.72.88 << EOF
docker pull alnair/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi alnair/sample-node:current || true
docker tag alnair/sample-node:latest alnair/sample-node:current
docker run -d --net app --restart always --name web -p 80:80 alnair/sample-node:current
EOF
