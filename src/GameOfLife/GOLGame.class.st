"
A first implementation of Conway Game Of Life 
https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

The universe of the Game of Life is an infinite, two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, alive or dead, (or populated and unpopulated, respectively). Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:

Any live cell with fewer than two live neighbours dies, as if by underpopulation.
Any live cell with two or three live neighbours lives on to the next generation.
Any live cell with more than three live neighbours dies, as if by overpopulation.
Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

The initial pattern constitutes the seed of the system. The first generation is created by applying the above rules simultaneously to every cell in the seed; births and deaths occur simultaneously, and the discrete moment at which this happens is sometimes called a tick. Each generation is a pure function of the preceding one. The rules continue to be applied repeatedly to create further generations.


|game|

game := GOLGame new  openInWorld.
game stopStepping.
game enableMouseInteraction.

GameOfLifeMorph allInstances last startStepping.

GameOfLifeMorph allInstances last delete.

Idea taken from blog post: http://langexplr.blogspot.com/2015/08/game-of-life-and-pharo.html, with code updated to match Pharo 7.0
"
Class {
	#name : #GOLGame,
	#superclass : #BorderedMorph,
	#instVars : [
		'cells'
	],
	#category : #GameOfLife
}

{ #category : #'as yet unclassified' }
GOLGame >> cellsPerSide [
	"number of life cell per side, default with a square"

	^ 10
]

{ #category : #rules }
GOLGame >> getCellValue: row column: column [
	"Gets the value of the specified cell"

	^ row < 1 | (row > self cellsPerSide) | (column > self cellsPerSide)
		| (column < 1)
		ifTrue: [ 0 ]
		ifFalse: [ (cells at: row at: column) isOn
				ifTrue: [ 1 ]
				ifFalse: [ 0 ] ]
]

{ #category : #accessing }
GOLGame >> getNeighborsAt: i at: j [
	| topLeft top topRight left right bottomLeft bottomRight bottom |
	topLeft := self getCellValue: i - 1 column: j - 1.
	top := self getCellValue: i - 1 column: j.
	left := self getCellValue: i column: j - 1.
	right := self getCellValue: i column: j + 1.
	topRight := self getCellValue: i - 1 column: j + 1.
	bottomRight := self getCellValue: i + 1 column: j + 1.
	bottom := self getCellValue: i + 1 column: j.
	bottomLeft := self getCellValue: i + 1 column: j - 1.
	^ topLeft + top + left + right + topRight + bottomRight + bottom
		+ bottomLeft
]

{ #category : #rules }
GOLGame >> getNextGenerationFor: i column: j [
	"Verifies the Game Of Life rules"

	| neighbors cell |
	cell := cells at: i at: j.
	neighbors := self getNeighborsAt: i at: j.
	cell isOn
		ifTrue: [ neighbors < 2 | (neighbors > 3)
				ifTrue: [ cell turnOff ] ]
		ifFalse: [ neighbors = 3
				ifTrue: [ cell turnOn ] ].
	^ cell
]

{ #category : #initialization }
GOLGame >> initialize [
	| sampleCell width height n |
	super initialize.
	n := self cellsPerSide.
	sampleCell := GOLCell new.
	width := sampleCell width.
	height := sampleCell height.
	self
		bounds: (5 @ 5 extent: (width * n) @ (height * n) + (2 * self borderWidth)).
	cells := Array2D new: n tabulate: [ :i :j | self newCellAt: i at: j ]
]

{ #category : #'as yet unclassified' }
GOLGame >> newCellAt: i at: j [
	"Create a cell for position (i,j) and add it to my on-screen
representation at the appropriate screen position. Answer the
new cell"

	| c origin |
	c := GOLCell new.
	origin := self innerBounds origin.
	self addMorph: c.
	c position: ((i - 1) * c width) @ ((j - 1) * c height) + origin.
	^ c
]

{ #category : #'model - stepping' }
GOLGame >> step [
	"Verifies the rules of the Game Of Life"

	| nextGeneration |
	nextGeneration := cells indicesCollect: [ :i :j | self getNextGenerationFor: i column: j].
	cells := nextGeneration.
	self changed
]

{ #category : #'model - stepping' }
GOLGame >> stepTime [
    ^ 500.
]
