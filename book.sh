#!/bin/bash

# Validate required utilities
if ! command -v curl &> /dev/null; then
  echo "Error: curl is not installed."
  exit 1
fi

# Validate parameters
if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <Name> <Email> <Date> <Time>"
  exit 1
fi

NAME=$1
EMAIL=$2
DATE=$3
TIME=$4

# Validate email
if ! [[ "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
  echo "Error: Invalid email format."
  exit 1
fi

# Validate date (dd/mm/yyyy)
if ! [[ "$DATE" =~ ^[0-9]{2}/[0-9]{2}/[0-9]{4}$ ]]; then
  echo "Error: Invalid date format. Use dd/mm/yyyy."
  exit 1
fi

# Validate time (hh:mm)
if ! [[ "$TIME" =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
  echo "Error: Invalid time format. Use hh:mm."
  exit 1
fi

# URLs
FIRST_URL="https://www.electrogym.be/booking/chatelain/electrogym-ems-chatelain-3/electrogym-ems-chatelain-69-rue-du-chatelain-1/chatelain-7/ems-chatelain-6"
SECOND_URL="https://www.electrogym.be/booking/chatelain/checkout/category-electrogym-ems-chatelain/venue/employee-chatelain/$DATE"
POST_URL="https://www.electrogym.be/index.php"
GET_URL="https://www.electrogym.be/index.php?option=com_osservicesbooking&task=default_orderDetailsForm&order_id=349&ref=0bb4aec1710521c12ee76289d9440817&Itemid=224"

# Generate a unique cookie file name
COOKIE_FILE="cookie_$(date +%s).txt"

# cURL command for the first page
curl -k -X GET "$FIRST_URL" -c $COOKIE_FILE

# cURL command for the second page
curl -k -X GET "$SECOND_URL" -b $COOKIE_FILE -c $COOKIE_FILE

# cURL command for the POST request
curl -k -X POST "$POST_URL" -b $COOKIE_FILE -c $COOKIE_FILE \
     -F "option=com_osservicesbooking" \
     -F "task=default_completeorder" \
     -F "Itemid=224" \
     -F "date=$DATE" \
     -F "time=$TIME" \
     -F "name=$NAME" \
     -F "email=$EMAIL"

# cURL command for the GET request
curl -k -X GET "$GET_URL" -b $COOKIE_FILE -c $COOKIE_FILE
