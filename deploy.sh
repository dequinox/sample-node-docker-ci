#!/bin/bash
sudo docker build -t alnair/sample-node .
sudo docker push alnair/sample-node

ssh alikhil@35.187.72.88 << EOF
sudo docker pull alnair/sample-node:latest
sudo docker stop web || true
sudo docker rm web || true
sudo docker rmi alnair/sample-node:current || true
sudo docker tag alnair/sample-node:latest alnair/sample-node:current
sudo docker run -d --restart always --name web -p 80:80 alnair/sample-node:current
EOF
