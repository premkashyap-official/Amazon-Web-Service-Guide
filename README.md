## Linux Commands 

1) Root user : `sudo su`

2) Update all packages : `sudo yum update`.

3) Update all packages but remove obstacles : `sudo yum upgrade`.

5) File commands :
	1) Creation or edit of a file : `sudo nano file_name` in root directories or `nano file_name` in normal directories.
	2) View a file : `sudo cat file_name` in root directories or `cat file_name` in normal directories.

4) Service creation: 
	1) Go to the directory /etc/systemd/system using command  : `cd /etc/systemd/system`.
	2) Create a service file 'service_name.service' using command : `sudo nano service_name.service`.
	3) Save the file : `ctrl+s`.
	4) Exit the file : `ctrl+x`.
	5) To apply changes after a new service creation.
		1) Reload all the services : `sudo systemctl daemon-reload`. This command has to be run after a service file is edited.
		2) Enable the service for multi users : `sudo systemctl enable service_name`.
		3) Start the service : `sudo systemctl start service_name`.
	
	6) other service commands : 
		1) Restart the service : `sudo systemctl restart service_name`.
		2) Stop the service : `sudo systemctl stop service_name`.
		3) Disable the service : `sudo systemctl disable service_name`.
  		4) Check the status : `sudo systemctl status service_name`.

5) Nginx: 
	1) Install nginx : `sudo yum install nginx`.
	2) Create a configuration file : 
		1) Go to directory : `cd /etc/nginx/conf.d`.
		2) create a configuration file using nano : `sudo nano file_name.conf`.
		3) After giving the content save the file and exit the file using ctrl-s and ctrl-x.
  	3) Test the new nginx configuration without changing the working nginx : `sudo nginx -t`.	
	4) Restart the nginx service using service restart command.
 	5) To check the status use service status command.
     Note : For more check this link : https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/ 
6) PM2:
   	1) Installation : `npm i pm2`.
   	2) Go to the directory where node.js file is present.
   	3) To start pm2 as a service : `pm2 startup`.
   	4) Start the pm2 service for node : `pm2 start file_name.js --name `.
   	5) Save the pm2 service : `pm2 save`.
   	6) List all pm2 services : `pm2 list`.
	7) To check the logs: `pm2 logs` or `pm2 logs service-name`.
 	8) Delete a pm2 service : `pm2 delete service-name`.
     Note : For more commands check this link : https://devhints.io/pm2



## Ubuntu Commands : 

**IMPORTANT** : Use the same commands as linux but use `apt` instead of `yum`.
