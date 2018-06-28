#!/bin/bash

function workstation_setting(){
	echo ############ Packages updates ############
	cd ~
	sudo apt-get update
	
	echo ############ Language Variables export ############
	export LANG="en_US.UTF-8"
	export LC_ALL="en_US.UTF-8"
	export LC_CTYPE="en_US.UTF-8"

	echo ############ Setting app environment ############
	sudo apt-get update
	sudo apt-get install git
	sudo apt-get install -y python3-pip
	sudo apt-get install -y npm

	echo ############ Install Nodejs with NPM ###########
	echo -----Step 1 – Installing Prerequisites-----
	sudo apt-get install curl
	sudo apt-get install python-software-properties
	echo -----Step 2 – Adding NodeJs PPA-----
	curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
	echo -----Step 3 – Installing Node.js and NPM-----
	sudo apt-get update
	sudo apt-get install nodejs

}

function app_project(){
	echo ############ Set local repository ############
	cd ~
	mkdir App
	cd App

	echo ############ Clone_Github_repository ############
	sudo git clone https://github.com/J-Lmb/nginx_aws.git
	cd nginx_aws
}

function nginx_installation(){
	echo ############ Get NGINX installed ############
	sudo apt-get install -y nginx
	
	echo ############ delete default configuration file ############
    	sudo rm -rf /etc/nginx/sites-available/default
    	sudo rm -rf /etc/nginx/sites-enabled/default
    	echo ############ change nginx configuration file ############
    	sudo bash -c 'cat <<EOF > /etc/nginx/sites-available/default
    	server {
        	listen 80 default_server;
            	listen [::]:80 default_server;
            	server_name _;
            	location / {
                    	proxy_pass http://127.0.0.1:3000/;
                    	proxy_set_header HOST \$host;
                    	proxy_set_header X-Forwarded-Proto \$scheme;
                    	proxy_set_header X-Real-IP \$remote_addr;
                    	proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        	}
    	}
EOF'

	echo ############ Symbolic link creation to allow file to take affect after nginx reload ############
    	sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

	echo ############ Check nginx status ############
    	sudo systemctl restart nginx
    	sudo nginx -t
}

function start_app(){
	echo ############ Restart nginx ############
	sudo systemctl restart nginx

	echo ############ Launch application ############
        node app.js
}

function run(){

	workstation_setting
	app_project
	nginx_installation
	start_app
}

run
