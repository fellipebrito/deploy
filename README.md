Deploy
======

A Capistrano basic structure to deploy using unicorn and nginx

Installing
---

- **Add it as a submodule** in vendor/deploy: 
<code>git submodule add git://YOUR-REPO vendor/deploy</code>


- Inside vendor/deploy **run rake install** so you create the correct aliases: <code>cd vendor/deploy && rake install</code>

- Change app/config/deploy/***.rb with your **server info**
- Change app/config/deploy.rb with your **gitrepo address** (_It will be moved to another file in next version_)

- Create an alias from your id_rsa to config/id_rsa: <code>ln -s ~/.ssh/YOUR-PROJECT.pem app/config/id_rsa</code>

Deploying
---

After follow the installing instructions you may be able to execute: <code>cap deploy</code>

Server Needs
---

- The project will be installed into your /var/www folder;
- The folder /var/www must be empty and with correct permissions
- You should have nginx running in this server;

Customization
---

If you need to change anything, change or extend the aliases
