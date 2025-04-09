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
	#name : 'GOLModel',
	#superclass : 'Object',
	#instVars : [
		'game',
		'nextGeneration'
	],
	#category : 'GameOfLife-Model',
	#package : 'GameOfLife',
	#tag : 'Model'
}

{ #category : 'creation' }
GOLModel class >> rows: rowNumber columns: columnNumber pattern: aGamePattern [
	^self new rows: rowNumber columns: columnNumber pattern: aGamePattern 
]

{ #category : 'private' }
GOLModel >> getCellValueAtX: col atY: row [
	"Gets the value of the specified cell. If the cell is out of bound, return 1"

	| alive |
	alive := 0.
	col < 1 | (row > game numberOfRows) | (col > game numberOfColumns) | (row < 1)
		ifFalse: [ (game atX: col atY: row) ifTrue: [ alive := 1 ] ].
	^ alive
]

{ #category : 'private' }
GOLModel >> getNeighborsAtX: col atY: row [

	| topLeft top topRight left right bottomLeft bottomRight bottom |
	topLeft := self getCellValueAtX: col - 1 atY: row - 1.
	top := self getCellValueAtX: col - 1 atY: row.
	left := self getCellValueAtX: col atY: row - 1.
	right := self getCellValueAtX: col atY: row + 1.
	topRight := self getCellValueAtX: col - 1 atY: row + 1.
	bottomRight := self getCellValueAtX: col + 1 atY: row + 1.
	bottom := self getCellValueAtX: col + 1 atY: row.
	bottomLeft := self getCellValueAtX: col + 1 atY: row - 1.
	^ topLeft + top + left + right + topRight + bottomRight + bottom
	  + bottomLeft
]

{ #category : 'model protocol' }
GOLModel >> getNextGeneration [

	nextGeneration := CTArray2D width: game width height: game height.
	nextGeneration rowsAndColumnsPut: [ :col :row |
		self getNextGenerationAtX: col atY: row ].
	game := nextGeneration
]

{ #category : 'model protocol' }
GOLModel >> getNextGenerationAtX: col atY: row [
	| neighbors cell |
	"self haltIf: [ col = 2 and: [row = 2]]."
	neighbors := self getNeighborsAtX: col atY: row.
	cell := game atX: col atY: row.
	cell ifTrue: [ neighbors < 2 | (neighbors > 3)
				ifTrue: [ ^ false ]
				ifFalse: [ ^ true ] ]
		ifFalse: [ neighbors = 3
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'model protocol' }
GOLModel >> isAliveAtX: i atY: j [
	^ game atX: i atY: j
]

{ #category : 'initializing' }
GOLModel >> rows: rowNumber columns: columnNumber pattern: aGamePattern [

	game := (CTArray2D width: columnNumber height: rowNumber)
		        setContents: aGamePattern.

]
