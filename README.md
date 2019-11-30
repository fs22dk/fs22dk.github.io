docker run --rm --volume="$PWD:/srv/jekyll" --env JEKYLL_ENV=dev -p 4000:4000 jekyll/builder:latest jekyll serve

