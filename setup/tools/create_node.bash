#!/bin/bash
## Input parameters:
##	$1 -> directory name
##	$2 -> class name
##	$1 -> new repository name
##	$3 -> username
##	$4 -> password

## Run example
## 	bash create_node.bash test_created_repository TestClass USER PASSWORD

## Remove repository
##  python create_github_repository.py -d -r test_created_repository -u USER -p PASSWORD
echo "=== Getting tools path"
HOME_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "=== Creating repository $2"
python $HOME_DIR/github_repository.py --create -r $1 -u $3 -p $4

echo "=== Creating SRC path"
if [ ! -d "$DIRECTORY" ]; then
  mkdir src
fi
cd src

echo "=== Cloning ROS template"
git clone git@github.com:$3/ros_template.git

echo "=== Changing template names"
mv ros_template $1
sed "s/ros_template/$1/g" $1/CMakeLists.txt >> $1/CMakeLists.txt.new
mv $1/CMakeLists.txt.new $1/CMakeLists.txt
sed "s/ros_template/$1/g" $1/package.xml >> $1/package.xml.new
mv $1/package.xml.new $1/package.xml

echo "=== Creating template node"
sed "s/Sample/$2/g" $1/src/sample_node.py >> $1/src/sample_node.py.new
##TODO: Test the node name
sed "s/sample/$1/g" $1/src/sample_node.py.new >> $1/src/sample_node.py.new
mv $1/src/sample_node.py.new $1/src/sample_node.py
mv $1/src/sample_node.py $1/src/$1.py

echo "=== Changing template URL"
cd $1
git remote set-url origin git@github.com:$3/$1.git

echo "=== Updating ROS files in branch: $(git branch)"
echo "=== Needs $1 Github credentials"
git config --global user.email "renatosamperio@gmail.com"
git config --global user.name "Renato Samperio"

git add CMakeLists.txt package.xml
git commit -m "ROS_PACKAGE: Updating ROS files for $1"

git rm src/sample_node.py
git commit -m "TEMPLATE: Removed old templated"

git add src/$1.py
git commit -m "ROS_NODE: Added $1 ROS node"
git push -u origin develop

git log --graph --full-history --all --pretty=format:"%Cred%h%Creset%x09%C(yellow)%d%Creset%x20%s %Cgreen(%cr)%Creset" --date=relative
