Deploy
======

A Capistrano basic structure to deploy using unicorn and nginx

- **Add it as a submodule** in vendor/deploy
<code>git submodule add git://<your_repo> vendor/deploy</code>


- Inside vendor/deploy **run rake install** so you create the correct aliases
<code>cd vendor/deploy && rake install</code>

- Change app/config/deploy/***.rb with your **server info**
- Change app/config/deploy.rb with your **gitrepo address** (_It will be moved to another file in next version_)

- Create an alias from your id_rsa to config/id_rsa
<code>ln -s ~/.ssh/<your_project>.pem app/config/id_rsa</code>
