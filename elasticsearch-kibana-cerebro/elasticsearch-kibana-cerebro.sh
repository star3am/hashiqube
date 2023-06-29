#!/bin/bash
sudo docker stop elasticsearch-kibana
sudo docker rm elasticsearch-kibana
sudo docker stop cerebro
sudo docker rm cerebro
yes | sudo docker system prune -a
yes | sudo docker system prune --volumes
sudo docker run -d -p 9200:9200 -p 5601:5601 --name elasticsearch-kibana nshou/elasticsearch-kibana
sudo docker run -d -p 5602:9000 --name cerebro lmenezes/cerebro:0.8.3
echo -e '\e[38;5;198m'"++++ Elasticsearch: http://localhost:9200"
echo -e '\e[38;5;198m'"++++ Kibana: http://localhost:5601"
echo -e '\e[38;5;198m'"++++ Cerebro: http://localhost:5602 and enter http://10.9.99.10:9200"
