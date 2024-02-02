"
I implement the logic of the game of life
https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

The universe of the Game of Life is an infinite, two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, alive or dead, (or populated and unpopulated, respectively). Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:

Any live cell with fewer than two live neighbours dies, as if by underpopulation.
Any live cell with two or three live neighbours lives on to the next generation.
Any live cell with more than three live neighbours dies, as if by overpopulation.
Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

The initial pattern constitutes the seed of the system. The first generation is created by applying the above rules simultaneously to every cell in the seed; births and deaths occur simultaneously, and the discrete moment at which this happens is sometimes called a tick. Each generation is a pure function of the preceding one. The rules continue to be applied repeatedly to create further generations.
"
Class {
	#name : #GOLModel,
	#superclass : #Object,
	#instVars : [
		'game'
	],
	#category : #'GameOfLife-Model'
}

{ #category : #creation }
GOLModel class >> rows: rowNumber columns: columnNumber pattern: aGamePattern [
	^self new rows: rowNumber columns: columnNumber pattern: aGamePattern 
]

{ #category : #accessing }
GOLModel >> game [
	^ game
]

{ #category : #accessing }
GOLModel >> game: anArray [
	game := anArray
]

{ #category : #private }
GOLModel >> getCellValueAt: i at: j [
	"Gets the value of the specified cell"

	| alive |
	alive := 0.
	i < 1 | (i > game rowCount) | (j > game columnCount) | (j < 1)
		ifFalse: [ (game at: i at: j) ifTrue: [ alive := 1 ] ].
	^ alive
]

{ #category : #private }
GOLModel >> getNeighborsAt: i at: j [

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

{ #category : #'model protocol' }
GOLModel >> getNextGeneration [
	| nextGeneration |
	nextGeneration := game  indicesCollect:  [ :i :j | self getNextGenerationAt: i at: j ].
	game := nextGeneration.
]

{ #category : #'model protocol' }
GOLModel >> getNextGenerationAt: i at: j [
	| neighbors cell |
	neighbors := self getNeighborsAt: i at: j.
	cell := game at: i at: j.
	cell ifTrue: [ neighbors < 2 | (neighbors > 3)
				ifTrue: [ ^ false ]
				ifFalse: [ ^ true ] ]
		ifFalse: [ neighbors = 3
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'model protocol' }
GOLModel >> isAliveAt: i at: j [
	^ game at: i at: j
]

{ #category : #initializing }
GOLModel >> rows: rowNumber columns: columnNumber pattern: aGamePattern [
	game := Array2D
		rows: rowNumber
		columns: columnNumber
		contents: aGamePattern
]

{ #category : #'model protocol' }
GOLModel >> turnAliveAt: i at: j [ 
	game at: i at:j put: true.
]
