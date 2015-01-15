#!/bin/sh

# tcpdump
## -s 0 sets the snaplen to the default of 65535
## -l make stdout line buffered. useful if you wanna see data while capturing it.
## -w Write the raw packets to file rather than parsing and printing them out.
# strings print the strings of printable characters in files.

DIR='/destination/directory'
TIMEOUT='2s'

# extract_select queries out of the TCP stream
extract_select()
{
  # $1 => output file
  timeout $TIMEOUT tcpdump -i any -B 8000 -s 0 -l -w - dst port 3306 | strings | grep -i ^select | grep '/$' > $DIR/$1.buff

  cat $DIR/$1.buff | grep "some regex filter goes here" > $DIR/$1.filtered
  cat $DIR/$1.filtered | wc -l

  rm $DIR/$1.buff
}

extract_select dump.txt

