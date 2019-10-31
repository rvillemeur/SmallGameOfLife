# SmallGameOfLife
A simple game of life implementation in Pharo


```smalltalk
Metacello new
				baseline: 'SmallGameOfLife';
				repository: 'github://rvillemeur/SmallGameOfLife/src';
				load
```

![](https://github.com/rvillemeur/SmallGameOfLife/blob/master/gol.PNG)

To start it:
```smalltalk
|game|

game := GOLGame rows: 9 columns: 16.
game patternPentadecathlon .
game openInWindow 
```
