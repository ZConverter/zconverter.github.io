#!/bin/bash
cd /project/gitpage/zconverter.github.io
rm -rf _site .jekyll-cache && bundle exec jekyll serve --host 0.0.0.0 --port 4040 