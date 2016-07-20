## Topic
1. event processing pipeline
2. multiple filter are applied in the order of their appearance
3. lines start with '#' is comment
4. input file path only support file globbling

## config file test
./logstash -f <config_path> -t

## debug 
./logstash --debug -f <config>

## config file structure
input
filter
output

## stdout
output {
   stdout { codec => rubydebug }
}



