#!/bin/bash
# Wordpress installation Script.

echo "================================================================="
echo "Quick Wordpress Installer"
echo "================================================================="


echo -e "Please enter DATABASE: "
read db
echo -e "Please enter USER Database: "
read userdb
echo -e "Please enter PASSWORD Database: "
read pass
echo -e "Please enter URL: "
read url
echo -e "Please enter WEBSITE Title: "
read title
echo -e "Please enter WEBSITE Admin (Email): "
read admin
echo -e "Please enter WEBSITE Password: "
read wordpass
echo -e "Please enter website's tagline: "
read tagline

# add a simple yes/no confirmation before we proceed
echo "Run Install? (y/n)"
read -e run

# if the user didn't say no, then go ahead an install
if [ "$run" == n ] ; then
exit
else

#Downloads Wordpress
wp core download

#Set the Configuration file
wp core config --dbname="$db" --dbuser="$userdb" --dbpass="$pass"

# Create Admin User
wp core install --url="$url" --title="$title" --admin_user="$admin" --admin_password="$wordpass" --admin_email="$admin"

# Delete plugins hello and akismet
wp plugin delete hello akismet

# Install and Activate maintenance and wordfence
wp plugin install maintenance wordfence --activate 

# Delete the Hello Post
wp post delete $(wp post list --post_type='post' --format=ids)

# Delete the Sample Page
wp post delete $(wp post list --post_type='page' --format=ids)

# Set Tagline
wp option update blogdescription "$tagline"

# Close Comments
wp option set default_comment_status closed

# Set permalinks as postname
wp rewrite structure '/%postname%/' --hard

echo "================================================================="
echo "Installation is complete. Your username/password is listed below."
echo ""
echo "Username: $admin"
echo "Password: $wordpass"
echo ""
echo "================================================================="
