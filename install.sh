#!/bin/bash

echo '\e[8;30;100t' && clear
printf "\n\t\t     Jekyll Directory Structure Installer\n\n"
printf "\t\t\tversion: 1.0\n"
printf "\t\t\tlicense: GPL 3.0\n"
printf "\t\t\t author: Federico Sanders\n"
printf "\t\t\t  email: fs22dk@student.lnu.se\n\n"

if [ ! -x "$(command -v pv)" ]; then
  sudo apt install -y pv doc-base >/dev/null 2>&1
fi

touch install.log
pv -p -N .tar dirs.tar | tar xf - -C $PWD
docker images -a > images

touch tmp
if [ ! $(grep -q 'jekyll/builder      latest' images) ];
 then
  docker pull jekyll/builder:latest | pv -N .img -p -s982 >> tmp;
  cat tmp >> install.log;
  : > tmp
 else
  if [ $(grep -q 'jekyll/builder      latest' images) ];
   then
   docker pull jekyll/builder:latest | pv -N .img -p -s202 >> tmp;
   cat tmp >> install.log; 
   : > tmp 
  fi
fi

docker run --rm --volume="$PWD:/srv/jekyll" -it jekyll/builder:latest jekyll build --trace | pv -N .gem -p -s3004  >> tmp;
cat tmp >> install.log;
rm tmp images dirs.tar install.sh

 
