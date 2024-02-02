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
	#name : #GOLGameMorphic,
	#superclass : #Morph,
	#instVars : [
		'cells',
		'rows',
		'columns'
	],
	#category : #'GameOfLife-UI'
}

{ #category : #'instance creation' }
GOLGameMorphic class >> rows: rowNumber columns: columnNumber pattern: aGamePattern [
	^self new rows: rowNumber columns: columnNumber pattern: aGamePattern.
]

{ #category : #drawing }
GOLGameMorphic >> drawOn: canvas [
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

{ #category : #'instance creation' }
GOLGameMorphic >> rows: rowNumber columns: columnNumber pattern: aGamePattern [

	rows := rowNumber.
	columns := columnNumber.
	cells := GOLModel
		         rows: rowNumber
		         columns: columnNumber
		         pattern: aGamePattern.
	^ self
]

{ #category : #'stepping and presenter' }
GOLGameMorphic >> step [
	cells getNextGeneration.
	self changed
]

{ #category : #'stepping and presenter' }
GOLGameMorphic >> stepTime [
    ^ 500.
]
