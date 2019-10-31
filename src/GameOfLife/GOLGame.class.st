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

game := GOLGame rows: 3 columns: 3.
game patternBlinker.
game openInWindow 

or 

|game|

game := GOLGame rows: 9 columns: 16.
game patternPentadecathlon .
game openInWindow 



Idea taken from blog post: http://langexplr.blogspot.com/2015/08/game-of-life-and-pharo.html, with code updated to match Pharo 7.0
"
Class {
	#name : #GOLGame,
	#superclass : #BorderedMorph,
	#instVars : [
		'cells',
		'display'
	],
	#category : #GameOfLife
}

{ #category : #'instance creation' }
GOLGame class >> rows: rowNumber columns: columnNumber [ 
	^self new rows: rowNumber columns: columnNumber.
]

{ #category : #'instance creation' }
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
	| sampleCell width height |
	sampleCell := GOLCell new.
	width := sampleCell width.
	height := sampleCell height.
	self
		bounds:
			(5 @ 5
				extent: (width * rowNumber) @ (height * columnNumber) + (2 * self borderWidth)).
	display := Array2D rows: rowNumber columns: columnNumber tabulate: [ :i :j | self newCellAt: i at: j ].
	cells := GOLGameModel  rows: rowNumber columns: columnNumber
]

{ #category : #'model - stepping' }
GOLGame >> step [
	"Verifies the rules of the Game Of Life"
	cells getNextGeneration.
	display indicesDo: [ :i :j | self updateCellAt: i at: j ].
	self changed
]

{ #category : #'model - stepping' }
GOLGame >> stepTime [
    ^ 500.
]

{ #category : #accessing }
GOLGame >> updateCellAt: i at: j [
	(cells isAliveAt: i at: j)
		ifTrue: [ (display at: i at: j) turnOn ]
		ifFalse: [ (display at: i at: j) turnOff ]
]
