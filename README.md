# pkk-monitor
## update.sh
```
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

```
## prettyprint.py
```
import json
import codecs
import urllib2
# just open the file...
input_file  = urllib2.urlopen("http://maps.rosreestr.ru/arcgis/rest/services/Cadastre/CadastreOriginal/MapServer/5/query?where=1%3D1&outFields=*&returnGeometry=false&f=json").read()
# need to use codecs for output to avoid error in json.dump
output_file = codecs.open("pkk.json", "w", encoding="utf-8")

# read the file and decode possible UTF-8 signature at the beginning
# which can be the case in some files.
j = json.loads(input_file.decode("utf-8-sig"))

# then output it, indenting, sorting keys and ensuring representation as it was originally
json.dump(j, output_file, indent=4, sort_keys=True, ensure_ascii=False)
```
