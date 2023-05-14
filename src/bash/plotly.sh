#!/bin/bash
cd /home/tweet/
{
echo "<!DOCTYPE html>"
echo "<html lang="en">"
echo "<head>"
echo "<script src=\"https://cdn.plot.ly/plotly-2.18.2.min.js\"></script>"
echo "</head>"
echo "<body>"
} > plotly.html
sqlite3 birds.db ".param set :prefix lo" ".param set :low 0" ".param set :high 100" ".param set :year $1" ".read plotly-js.sql" >> plotly.html
sqlite3 birds.db ".param set :prefix mid" ".param set :low 100" ".param set :high 1000" ".param set :year $1" ".read plotly-js.sql" >> plotly.html
sqlite3 birds.db ".param set :prefix hi" ".param set :low 1000" ".param set :high 100000" ".param set :year $1" ".read plotly-js.sql" >> plotly.html
{
echo "</body>"
echo "</html>"
} >> plotly.html
cat plotly.html
