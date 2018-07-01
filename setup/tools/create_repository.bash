#!/usr/bin/bash
## Input parameters
##	$1 : repository name, should be a different name
##	$2 : user name

echo "=== Creating GitHub repository $1"
echo "===   User <$2> with password <$3>"

expect -c "
spawn curl -u $2 https://api.github.com/user/repos -d '{\"name\":\"$1\"}'
expect \"Enter host password for user \'renatosamperio\':\"
send -- \"$3\r\"  
interact
"
echo ""


# spawn curl -u $2 https://api.github.com/user/repos -d '{\"name\":\"$1\"}'
# expect -exact \"\'$2\':\" {send \"$3\n\"; interact}

# expect -exact "Enter Private Key Password: "
# send "$pass"
# expect -nocase \"\'$1\':\" {send \"$3\r\"; interact}

# Enter host password for user 'renatosamperio':

## touch README.md
## git init
## git add README.md
## git commit -m "Added empty README file"
## git remote add origin git@github.com:renatosamperio/$1.git
## git push -u origin master


