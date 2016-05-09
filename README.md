# arch-oscam-dockerfile
Dockerfile for archlinux including oscam

create a new image:

  docker build -t oscam .
  
run the container

  docker run --restart=always -d -p 8321:8321 -p 9000:9000 -v /path/to/configfile:/etc/oscam oscam sudo /usr/bin/oscam
