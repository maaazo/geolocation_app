## Overview

The GeolocationApp is responsible for managing geolocation data, providing functionality to add, delete, and retrieve geolocation information. It interfaces with a third-party geolocation provider to gather location details based on an IP address.

## Environment Variables

Note: Environment variables need to be set in order to make the app work. Ensure you have the following variables set:

- **ACCESS_KEY**: Your API access key for the geolocation provider.
- **SECRET_BASE**: Your secret base key for application security.

## Getting Started
Follow these steps to set up and run the geolocation service on your local machine.

## Getting Started
Follow these steps to set up and run the geolocation service on your local machine.

##  Installation

#### Install Dependencies:
```
bundle install
```

####  Run Database Migrations:
```
rails db:migrate
```

#### Seed the Database:
```
rails db:seed
```

#### Start the Rails Server:
```
rails server
```

### Quick Setup (All in One):
Run the follwing command to install dependencies, migrate the database, seed the database, and start the Rails server in one go.

```
bundle install && rails db:migrate && rails db:seed && rails server
```

### Run with Docker:

#### Using Environment Variables:
```
ACCESS_KEY=<value> SECRET_BASE=<value> docker-compose up
```

#### Using Export:

```
export ACCESS_KEY=<value>
export SECRET_BASE=<value>
docker-compose up
```

Note: Replace <value> with your actual API access key and secret base values. These commands will start the Rails application using Docker, ensuring the necessary environment variables are set.

# Endpoints

#### Add Geolocation
- **HTTP Method:** POST
- **Endpoint:** /geolocation/add

Parameters:
- **ip** (string): The IP address for which to add geolocation data.

Response:
- **Status:** 201 Created
- **Body:** { message: 'Geolocation saved', geolocation: { /* geolocation data */ } }

------------


#### Delete Geolocation
- **HTTP Method:** DELETE
- **Endpoint:** /geolocation/delete

Parameters:
- **ip** (string): The IP address for which to delete geolocation data.

Response:
- **Status:** 200 OK
- **Body:** { message: "IP '/* IP address */' successfully deleted" }

------------


#### Retrieve Geolocation
**HTTP Method:** GET
**Endpoint:** /geolocation/retrieve

Parameters:
- **ip** (string): The IP address for which to retrieve geolocation data.

Response:
- **Status:** 200 OK
- **Body:** { ip: /* IP address */, location: { /* geolocation data */ } }

## Usage

#### Add New Geolocation
```
curl --location 'http://127.0.0.1:3000/geolocation/add' \
--header 'Authorization: <your-authorization-token>' \
--header 'Content-Type: application/json' \
--data '{
    "ip": "134.201.250.171"
}'
```

#### Delete Geolocation
```
curl --location --request DELETE 'http://127.0.0.1:3000/geolocation/delete' \
--header 'Authorization: <your-authorization-token>' \
--header 'Content-Type: application/json' \
--data '{
    "ip": "134.201.250.231"
}'
```

#### Retrieve Geolocation
```
curl --location 'http://127.0.0.1:3000/geolocation/retrieve?ip=134.201.250.157' \
--header 'Authorization: <your-authorization-token>'
```

Note: When using Docker, the application is accessible at the address 0.0.0.0:3000 instead of the default 127.0.0.1:3000.
