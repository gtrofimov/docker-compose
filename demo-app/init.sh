#!/bin/bash

# Initialize Demo App
curl \
-X PUT \
-u purchaser:password \
--header "Accept: application/json" \
--header "Conetent-Type: application/json" \
-iv --raw "http://localhost:4040/v1/demoAdmin/preferences" \
--data-binary @- << EOF
{
    "industryType" : "OUTDOOR",
    "webServiceMode" : "REST_API",
    "graphQLEndpoint" : "http://localhost:8080/graphql",
    "advertisingEnabled" : true,
    "demoBugs" : [
        "INCORRECT_NUMBER_OF_ITEMS_IN_SUMMARY_OF_PENDING_ORDER",
        "INCORRECT_LOCATION_FOR_APPROVED_ORDERS"
    ],
    "categoriesRestEndpoint" : "http://localhost:8080/v1/assets/categories",
    "itemsRestEndpoint" : "http://localhost:8080/v1/assets/items",
    "cartItemsRestEndpoint" : "http://localhost:8080/v1/cartItems",
    "ordersRestEndpoint" : "http://localhost:8080/v1/orders",
    "locationsRestEndpoint" : "http://soavirt-server:9080/proxy/v1/locations",
    "useParasoftJDBCProxy" : false,
    "mqType" : "ACTIVE_MQ",
    "orderServiceSendTo" : "inventory.request",
    "orderServiceListenOn" : "inventory.response"

}
EOF