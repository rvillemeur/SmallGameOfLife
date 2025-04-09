"
Game of life display using Bloc graphical stack
Look at example to launch specific game of life pattern
"
Class {
	#name : 'GOLGameBloc',
	#superclass : 'BlElement',
	#instVars : [
		'rows',
		'columns',
		'model',
		'cells'
	],
	#category : 'GameOfLife-UI',
	#package : 'GameOfLife',
	#tag : 'UI'
}

{ #category : 'instance creation' }
GOLGameBloc class >> rows: rowNumber columns: columnNumber pattern: aGamePattern [
	^self new rows: rowNumber columns: columnNumber pattern: aGamePattern.
]

{ #category : 'initialization' }
GOLGameBloc >> animation [

	| animation |
	animation := BlAnimation new
		             beInfinite;
		             duration: 0.6 seconds.

	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :anEvent | self displayNextGeneration ]).

	^ animation
]

{ #category : 'initialization' }
GOLGameBloc >> buildCellElement [

	^ BlElement new
		  background: Color white;
		  border: (BlBorder paint: Color black width: 1);
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ]
]

{ #category : 'accessing' }
GOLGameBloc >> cellColorAtX: column atY: row [

	^ (model isAliveAtX: column atY: row)
		  ifTrue: [ Color black ]
		  ifFalse: [ Color white ]
]

{ #category : 'update cycle' }
GOLGameBloc >> displayNextGeneration [

	model getNextGeneration.
	self updateCells
]

{ #category : 'initialization' }
GOLGameBloc >> initCells [

	cells := CTArray2D 
		         width: columns
		         height: rows
		         tabulate: [ :row :col | self buildCellElement ]
]

{ #category : 'initialization' }
GOLGameBloc >> initDisplay [

	self
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		border: (BlBorder paint: Color black width: 3);
		layout: (BlGridLayout vertical
				 rowCount: rows;
				 columnCount: columns);
	addAnimation: self animation.

	cells rowsAndColumnsDo: [ :row :column |
		self addChild: (cells atX: column atY: row) ]
]

{ #category : 'instance creation' }
GOLGameBloc >> rows: rowNumber columns: columnNumber pattern: aGamePattern [

	rows := rowNumber.
	columns := columnNumber.
	model := GOLModel
		         rows: rowNumber
		         columns: columnNumber
		         pattern: aGamePattern.
	self initCells.
	self initDisplay.
	self openInNewSpace.
	^ self
]

{ #category : 'update cycle' }
GOLGameBloc >> updateCells [

	cells rowAndColumnValuesDo: [ :row :column :elt |
		elt background: (self cellColorAtX: column atY: row) ]
]
