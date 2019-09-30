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

game := GameOfLifeMorph rows: 10 columns: 10.
game width: 100; height: 100; openInWorld.
game stopStepping.
game enableMouseInteraction.

GameOfLifeMorph allInstances last startStepping.

GameOfLifeMorph allInstances last delete.

Idea taken from blog post: http://langexplr.blogspot.com/2015/08/game-of-life-and-pharo.html, with code updated to match Pharo 7.0
"
Class {
	#name : #GameOfLifeMorph,
	#superclass : #Morph,
	#instVars : [
		'mouseInteraction',
		'columns',
		'rows',
		'currentGeneration'
	],
	#category : #GameOfLife
}

{ #category : #'instance creation' }
GameOfLifeMorph class >> rows: rowCount columns: columnCount [
	^ self new
		rows: rowCount columns: columnCount;
		yourself
]

{ #category : #accessing }
GameOfLifeMorph >> columns [
	^ columns
]

{ #category : #accessing }
GameOfLifeMorph >> columns: anObject [
	columns := anObject
]

{ #category : #'event handling' }
GameOfLifeMorph >> disableMouseInteraction [
	"Disables modifying the grid using a mouse click"
     mouseInteraction := false.
]

{ #category : #drawing }
GameOfLifeMorph >> drawOn: canvas [
	"Draws the game of life widget with the current state"

	| cellWidth cellHeight rectangle cellColor cellValue |
	cellWidth := self width / columns.
	cellHeight := self height / rows.
	1 to: rows do: [ :row | 
		1 to: columns do: [ :column | 
			cellValue := currentGeneration  at: row at: column.
			cellColor := cellValue = 1
				ifTrue: [ Color black ]
				ifFalse: [ Color white ].
			rectangle := Rectangle
				left: self bounds left + ((column - 1) * cellWidth)
				right: self bounds left + ((column - 1) * cellWidth) + cellWidth
				top: self bounds top + ((row - 1) * cellHeight)
				bottom: self bounds top + ((row - 1) * cellHeight) + cellHeight.
			cellValue = 1
				ifTrue: [ canvas fillRectangle: rectangle color: cellColor ]
				ifFalse: [ canvas
						frameAndFillRectangle: rectangle
						fillColor: Color white
						borderWidth: 1
						borderColor: Color black ] ] ].
	^ self
]

{ #category : #'event handling' }
GameOfLifeMorph >> enableMouseInteraction [
     mouseInteraction := true.
]

{ #category : #rules }
GameOfLifeMorph >> getCellValue: row column: column [
	"Gets the value of the specified cell"

	^ row < 1 | (row > rows) | (column > columns) | (column < 1)
		ifTrue: [ 0 ]
		ifFalse: [ currentGeneration  at: row at: column ]
]

{ #category : #rules }
GameOfLifeMorph >> getNextGenerationFor: row column: column [
	"Verifies the Game Of Life rules"

	| topLeft top topRight left right bottomLeft bottomRight bottom neighbors |
	topLeft := self getCellValue: row - 1 column: column - 1.
	top := self getCellValue: row - 1 column: column.
	left := self getCellValue: row column: column - 1.
	right := self getCellValue: row column: column + 1.
	topRight := self getCellValue: row - 1 column: column + 1.
	bottomRight := self getCellValue: row + 1 column: column + 1.
	bottom := self getCellValue: row + 1 column: column.
	bottomLeft := self getCellValue: row + 1 column: column - 1.
	neighbors := topLeft + top + left + right + topRight + bottomRight
		+ bottom + bottomLeft.
	^ (currentGeneration  at: row at: column) = 1
		ifTrue: [ neighbors < 2 | (neighbors > 3)
				ifTrue: [ 0 ]
				ifFalse: [ 1 ] ]
		ifFalse: [ neighbors = 3
				ifTrue: [ 1 ]
				ifFalse: [ 0 ] ]
]

{ #category : #'event handling' }
GameOfLifeMorph >> handlesMouseDown: aEvent [
     ^mouseInteraction.
]

{ #category : #'event handling' }
GameOfLifeMorph >> mouseDown: anEvent [
	| cellRow cellColumn valueToSet |
	cellRow := ((anEvent cursorPoint y - bounds top) / self height)
		asFloat * rows.
	cellRow := cellRow truncated.
	cellColumn := ((anEvent cursorPoint x - bounds left) / self width)
		asFloat * columns.
	cellColumn := cellColumn truncated.
	valueToSet := (currentGeneration  at: cellRow + 1 at: cellColumn + 1) = 0
		ifTrue: [ 1 ]
		ifFalse: [ 0 ].
	currentGeneration at: cellRow + 1 at: cellColumn + 1 put: valueToSet.
	self changed
]

{ #category : #accessing }
GameOfLifeMorph >> mouseInteraction [
	^ mouseInteraction
]

{ #category : #accessing }
GameOfLifeMorph >> mouseInteraction: anObject [
	mouseInteraction := anObject
]

{ #category : #accessing }
GameOfLifeMorph >> rows [
	^ rows
]

{ #category : #accessing }
GameOfLifeMorph >> rows: anObject [
	rows := anObject
]

{ #category : #initialization }
GameOfLifeMorph >> rows: rowCount columns: columnCount [
       rows := rowCount.
       columns := columnCount.
       currentGeneration := (Array2D rows: rows columns: columns) atAllPut: 0.
       mouseInteraction := false.
       self stopStepping.
       ^self.
]

{ #category : #rules }
GameOfLifeMorph >> step [
	"Verifies the rules of the Game Of Life"

	| nextGeneration |
	nextGeneration := Array2D rows: rows columns: columns.
	1 to: rows do: [ :row | 
		1 to: columns do: [ :column | 
			nextGeneration
				at: row
				at: column
				put: (self getNextGenerationFor: row column: column) ] ].
	currentGeneration := nextGeneration.
	self changed
]

{ #category : #stepping }
GameOfLifeMorph >> stepTime [
    ^ 500.
]
