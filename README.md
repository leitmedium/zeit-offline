# zeit-offline

Wie auf [zeit.de](https://www.zeit.de/hilfe/rss-hilfe) beschrieben, gibt
es für jeden Artikel eine XML-Version, die durch einfache Veränderung
erreicht werden kann. Es muss lediglich das "http://www.zeit.de"
durch "http://xml.zeit.de" ersetzt werden.

Beispiel:

Aus

https://www.zeit.de/2009/29/Pooh

wird

http://xml.zeit.de/2009/29/Pooh

Der Inhalt der ausgelieferten XML-Datei kann mit folgendem Befehl in
Browser-lesbares HTML umgewandelt werden:

```
$ wget http://xml.zeit.de/2009/29/Pooh -O artikel.xml
$ xsltproc zeitoffline.xslt artikel.xml > artikel.html
```


