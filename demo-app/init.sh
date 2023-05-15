#!/bin/bash

# Initialize Demo App

curl -X PUT "http://18.237.166.164:4040/v1/demoAdmin/preferences" \
-H "accept: application/json" -H "Content-Type: application/json" \
-u purchaser:password \
-d '{
    "industryType":"OUTDOOR",
    "webServiceMode":"REST_API",
    "graphQLEndpoint":"http://demo-app:8080/graphql",
    "advertisingEnabled":true,
    "demoBugs":["INCORRECT_NUMBER_OF_ITEMS_IN_SUMMARY_OF_PENDING_ORDER","INCORRECT_LOCATION_FOR_APPROVED_ORDERS"],
    "categoriesRestEndpoint":"http://demo-app:8080/v1/assets/categories",
    "itemsRestEndpoint":"http://demo-app:8080/v1/assets/items",
    "cartItemsRestEndpoint":"http://demo-app:8080/v1/cartItems",
    "ordersRestEndpoint":"http://demo-app:8080/v1/orders",
    "locationsRestEndpoint":"http://soavirt-server:9080/v1/locations",
    "useParasoftJDBCProxy":false,
    "mqType":"ACTIVE_MQ",
    "orderServiceSendTo":"inventory.request",
    "orderServiceListenOn":"inventory.response"
    }'