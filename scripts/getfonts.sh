# font-face css from googleapis
FONTFACES="https://fonts.googleapis.com/css?family=Fira+Mono|Fira+Sans"

# IE 11 useragent to force woff format
USERAGENT="Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko"

# local storage paths
STATIC="../static"
CSS="$STATIC/css/fonts.css"
FONTS="$STATIC/fonts"

# download font-face css
curl -L "$FONTFACES" -A "$USERAGENT" -o "$CSS"

# extract font urls and download
FILES=($(cat "$CSS" | sed -n 's/.*url(\([^)]\+\)).*/\1/p'))
mkdir -p "$FONTS"
for font in ${FILES[@]}; do
  (cd "$FONTS" && curl -LO "$font")
done

# modify font-face urls
sed -i 's/url(.*\/\([^\/]\+\))/url(\/fonts\/\1)/' "$CSS"
