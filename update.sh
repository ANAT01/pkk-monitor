#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

cd $SCRIPTPATH

DATE=`date +%Y-%m-%d\ %H:%M`

echo "# pkk-monitor" > README.md
echo "## update.sh" >> README.md
echo '```' >> README.md
cat update.sh >> README.md
echo '```' >> README.md
echo "## prettyprint.py" >> README.md
echo '```' >> README.md
cat prettyprint.py >> README.md
echo '```' >> README.md

python ./prettyprint.py
sed -i 's/"ONLINE_ACTUAL_DATE":\ [0-9]\{13\},//' pkk.json
sed -i '/^ *$/d' pkk.json
git add-commit -m "$DATE automatic update"
git push origin master

