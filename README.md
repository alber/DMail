# DMail
Drone Mail - 21st Century Carrier Pigeon Protocol. A first implementation using an IoT Traveling Mesh composed of Stations and UAV-Drones called PALs that physically and autonomously carry the payload over 7 Miles to exchange messages...

## Structure of this Repository
* __station_files__ - Raspberry PI files to use if the node is to behave as a Station in the DMail Network 
* __pal_files__ - Raspberry PI files to use if the node is to behave as a PAL/Carrier/UAV-Drone in the DMail Network
* A barebones Ruby on Rails app exists inside each _files_ folder as "palstation" 

## Requirements and Preparations
1. At least two Stock RaspberryPI 3b with RaspbianOS 4.19
1. Install Ruby On Rails framework.  Following this guide is recommended: https://computers.tutsplus.com/tutorials/how-to-install-ruby-on-rails-on-raspberry-pi--cms-21421
1. Install nodejs, batctl and all the other MESH requirements. Following this guide is required: https://developer.ibm.com/tutorials/create-iot-mesh-network/
1. Register at api.weather.com found in IBM Cloud Catalog for an authorization Key
1. Update the get-forecast.sh to use your new api.weather.com authorization key
1. Until it is configured at boot-time, please run ./start-rails-srv.sh upon first login on both devices
1. Be sure to run all migrations (rake db:migrate) so that your app is functional... and then 
1. Hit those local addresses, Station default 192.168.199.1 to start creating and sending those Messages.

