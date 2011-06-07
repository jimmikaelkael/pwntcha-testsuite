#!/bin/sh

rm -f index.html && echo > index.html
echo '<html><body bgcolor="#aaddff"><h1>CAPTCHA samples</h1><table>' >> index.html

find -maxdepth 2 -name '*_000.*' | cut -b3- | sed 's,/[^.]*., ,' | sort | uniq | while read DIRNAME EXTENSION; do
  echo -n "${DIRNAME}"
  INDEX="${DIRNAME}.html"
  rm -f "${INDEX}" && echo > "${INDEX}"
  echo '<html><body bgcolor="#aaddff"><table>' >> "${INDEX}"
  N=0
  for x in `seq -w 0 999`; do
    if [ ! -f "${DIRNAME}/${DIRNAME}_$x.${EXTENSION}" ]; then
        break
    fi
    echo '<tr>' >> "${INDEX}"
    echo '<td><h1><tt>#'"$x"'</tt></h1></td>' >> "${INDEX}"
    echo '<td><img src="'"${DIRNAME}/${DIRNAME}_$x.${EXTENSION}"'" /></td>' >> "${INDEX}"
    TEXT="[untranslated]"
    N=$((${N} + 1))
    if [ -r "${DIRNAME}/control.txt" ]; then
        TEXT="`sed -ne ${N}p "${DIRNAME}/control.txt"`"
    fi
    echo '<td><h1><tt>'"$TEXT"'</tt></h1></td>' >> "${INDEX}"
    echo '</tr>' >> "${INDEX}"
  done
  echo " - ${N} images"
  echo '</table></body></html>' >> "${INDEX}"

  convert "${DIRNAME}/${DIRNAME}_000.${EXTENSION}" -geometry '150x50>' "${DIRNAME}.jpeg"
  echo '<tr><td align="right"><a href="'"${INDEX}"'"><img align="middle" src="'"${DIRNAME}"'.jpeg"></a></td><td><h2>'"${DIRNAME} (${N})"'</h2></td></tr>' >> index.html
done

echo '</table></body></html>' >> index.html

