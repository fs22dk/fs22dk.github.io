#!/bin/bash
echo '\e[8;30;100t' && clear
printf "\n\n"
touch directories.log
pv -p -N .tar directories.tar | tar xf - -C $PWD
docker images -a > images
if [ ! $(grep -q 'jekyll/builder      latest' images) ];
 then
  touch tmp
  docker pull jekyll/builder:latest | pv -N .img -p -s379 >> tmp;
  cat tmp >> directories.log;
  : > tmp
fi
touch tmp
docker run --rm --volume="$PWD:/srv/jekyll" -it jekyll/builder:latest jekyll build --trace | pv -N .gem -p -s2918 >> tmp;
cat tmp >> directories.log;
rm tmp images directories.tar directories.sh
 
