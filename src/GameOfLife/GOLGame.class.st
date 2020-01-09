"
I reprensent the game of life display, and main entry point of the game.

|game|
game := GOLGame rows: 3 columns: 3.
game patternBlinker.
game openInWindow.

or 

|game|
game := (GOLGame rows: 9 columns: 16) patternPentadecathlon.
game openInWindow extent: 300@200; setLabel: 'game of life'.

Idea taken from blog post: http://langexplr.blogspot.com/2015/08/game-of-life-and-pharo.html, with code updated to match Pharo 7.0
"
Class {
	#name : #GOLGame,
	#superclass : #Morph,
	#instVars : [
		'cells',
		'rows',
		'columns'
	],
	#category : #GameOfLife
}

{ #category : #examples }
GOLGame class >> blinker [
	<example>
	| game |
	game := GOLGame rows: 3 columns: 3.
	game patternBlinker.
	game openInWindow
]

{ #category : #examples }
GOLGame class >> pentathlon [
<example>
|game|
game := (GOLGame rows: 9 columns: 16) patternPentadecathlon.
game openInWindow extent: 300@200; setLabel: 'game of life'.
]

{ #category : #'instance creation' }
GOLGame class >> rows: rowNumber columns: columnNumber [ 
	^self new rows: rowNumber columns: columnNumber.
]

{ #category : #drawing }
GOLGame >> drawOn: canvas [
	| cellWidth cellHeight cell |
	cellWidth := self width / columns.
	cellHeight := self height / rows.
	1 to: rows do: [ :row | 
		1 to: columns do: [ :column | 
			cell := Rectangle
				left: self bounds left + ((column - 1) * cellWidth)
				right: self bounds left + ((column - 1) * cellWidth) + cellWidth
				top: self bounds top + ((row - 1) * cellHeight)
				bottom: self bounds top + ((row - 1) * cellHeight) + cellHeight.
			(cells isAliveAt: row at: column)
				ifTrue: [ canvas
						frameAndFillRectangle: cell
						fillColor: Color black
						borderWidth: 1
						borderColor: Color black ]
				ifFalse: [ canvas
						frameAndFillRectangle: cell
						fillColor: Color white
						borderWidth: 1
						borderColor: Color blue ] ] ].
	^ self
]

{ #category : #'accessing pattern' }
GOLGame >> patternBlinker [
"require at least a 3x3 game array"
	cells turnAliveAt: 1 at: 2.
	cells turnAliveAt: 2 at: 2.
	cells turnAliveAt: 3 at: 2.
]

{ #category : #'accessing pattern' }
GOLGame >> patternPentadecathlon [
"require at least a 9x16 game array"
	cells turnAliveAt: 4 at: 6.
	cells turnAliveAt: 4 at: 11.
	
	cells turnAliveAt: 5 at: 4.
	cells turnAliveAt: 5 at: 5.
	
	cells turnAliveAt: 5 at: 7.
	cells turnAliveAt: 5 at: 8.
	cells turnAliveAt: 5 at: 9.
	cells turnAliveAt: 5 at: 10.
	
	cells turnAliveAt: 5 at: 12.
	cells turnAliveAt: 5 at: 13.
	
	cells turnAliveAt: 6 at: 6.
	cells turnAliveAt: 6 at: 11.
]

{ #category : #'instance creation' }
GOLGame >> rows: rowNumber columns: columnNumber [
	rows := rowNumber.
	columns := columnNumber.
	cells := GOLModel rows: rowNumber columns: columnNumber.
	^self.
]

{ #category : #'stepping and presenter' }
GOLGame >> step [
	cells getNextGeneration.
	self changed
]

{ #category : #'stepping and presenter' }
GOLGame >> stepTime [
    ^ 500.
]
