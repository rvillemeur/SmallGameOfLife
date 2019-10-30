Class {
	#name : #GOLGameModel,
	#superclass : #Object,
	#instVars : [
		'game'
	],
	#category : #GameOfLife
}

{ #category : #'as yet unclassified' }
GOLGameModel class >> rows: rowNumber columns: columnNumber [ 
	^self new rows: rowNumber columns: columnNumber.
]

{ #category : #accessing }
GOLGameModel >> game [
	^ game
]

{ #category : #accessing }
GOLGameModel >> game: anObject [
	game := anObject
]

{ #category : #'as yet unclassified' }
GOLGameModel >> getCellValueAt: i at: j [
	"Gets the value of the specified cell"
|alive|
alive := 0.
 i < 1 | (i > game rowCount ) | (j > game columnCount ) | (j < 1)
		ifFalse: [ (game at: i at: j) isAlive
				ifTrue: [ alive := 1 ]].
		^alive
]

{ #category : #'as yet unclassified' }
GOLGameModel >> getNeighborsAt: i at: j [ 
	| topLeft top topRight left right bottomLeft bottomRight bottom |
	topLeft := self getCellValueAt: i - 1 at: j - 1.
	top := self getCellValueAt: i - 1 at: j.
	left := self getCellValueAt: i at: j - 1.
	right := self getCellValueAt: i at: j + 1.
	topRight := self getCellValueAt: i - 1 at: j + 1.
	bottomRight := self getCellValueAt: i + 1 at: j + 1.
	bottom := self getCellValueAt: i + 1 at: j.
	bottomLeft := self getCellValueAt: i + 1 at: j - 1.
	^ topLeft + top + left + right + topRight + bottomRight + bottom
		+ bottomLeft
]

{ #category : #'as yet unclassified' }
GOLGameModel >> getNextGeneration [
	| nextGeneration |
	nextGeneration := Array2D rows: game numberOfRows  columns: game numberOfColumns .
	nextGeneration indicesDo:  [ :i :j | game getNextGeneration at: i at: j put: (self getNextGenerationAt: i at: j)].
	game := nextGeneration.
]

{ #category : #'as yet unclassified' }
GOLGameModel >> getNextGenerationAt: i at: j [ 
|neighbors cell|
	neighbors := self getNeighborsAt: i at: j.
	cell := game at: i at: j.
	cell isAlive
		ifTrue: [ neighbors < 2 | (neighbors > 3)	ifTrue: [ cell turnDead ] ]
			ifFalse: [ neighbors = 3	ifTrue: [ cell turnAlive  ] ]
]

{ #category : #'as yet unclassified' }
GOLGameModel >> rows: rowNumber columns: columnNumber [ 
	game := Array2D rows: rowNumber columns: columnNumber.
	game indicesDo: [:i :j | game at: i at: j put: (GOLGameCellModel new)].
]
