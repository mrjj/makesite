BRANCH={{ branch }}
PROJECT={{ project }}
GIT_USER={{ user }}
GIT_GROUP={{ group }}

PROJECT_SOURCEDIR={{ project_sourcedir }}
GIT_PROJECT_TEMP_DIR="/tmp/$BRANCH.$PROJECT-$USER"

which git 1>/dev/null || { echo "ERROR: * I require git but it's not installed."; exit 0; }

echo "  * Copy $PROJECT_SOURCEDIR to $GIT_PROJECT_TEMP_DIR."
rm -rf $GIT_PROJECT_TEMP_DIR
cp -r $PROJECT_SOURCEDIR $GIT_PROJECT_TEMP_DIR

cd $GIT_PROJECT_TEMP_DIR && git reset --hard HEAD && git clean -df && git pull

echo "  * Move $GIT_PROJECT_TEMP_DIR to $PROJECT_SOURCEDIR"
sudo rm -rf $PROJECT_SOURCEDIR
sudo mv $GIT_PROJECT_TEMP_DIR $PROJECT_SOURCEDIR
sudo chown -R $GIT_USER:$GIT_GROUP $PROJECT_SOURCEDIR
