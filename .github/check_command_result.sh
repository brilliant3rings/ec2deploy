#!/bin/bash

function succeeded () {
  status=$(aws ssm get-command-invocation --command-id $1 --instance-id "i-06e30b2f56c1146b3" | jq .Status)
  if [ $status = "Success" ]; then
    echo true
  else
    echo false
  fi
}

commandId=$1
i=1

while [ $i -le 10 ];
do
  succeeded=$(succeeded $commandId)
  if [ $succeeded ]; then
    exit 0
  fi
  i=$($i + 1 )
  sleep 3
done

exit 1
