docker ps -a -q | xargs -n 1 -I {} docker rm {}
