#!/bin/bash
chmod -R 0777 ./app;
IFS=","
set -- $BOLT_EXT
for element in $@
do
    eval "./vendor/bin/nut config:set extensions/stability dev";
    echo "Installing extestion $element";
    eval "./vendor/bin/nut extensions:install $element";
done

if [ -n "$BOLT_THEME" ]
then
    echo "Installing theme $BOLT_THEME";
    eval "./vendor/bin/nut config:set theme demo";
    eval "cp -prf extensions/vendor/$BOLT_THEME public/theme/demo"
    eval "cp -prf extensions/vendor/$BOLT_THEME public/theme/`basename $BOLT_THEME`"
else
  echo -e "BOLT_THEME not set\n"
fi

if [ -n "$BOLT_TITLE" ]
then
    eval "./vendor/bin/nut config:set sitename '$BOLT_TITLE'";
fi