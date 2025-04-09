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
GOLGameBloc >> cellColorAt: row at: column [

	^ (model isAliveAtX: row atY: column)
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
		         width: rows
		         height: columns
		         tabulate: [ :i :j | self buildCellElement ]
]

{ #category : 'initialization' }
GOLGameBloc >> initDisplay [

	self
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		border: (BlBorder paint: Color black width: 3);
		layout: (BlGridLayout new
				 rowCount: rows;
				 columnCount: columns);
		addAnimation: self animation.

	cells rowsAndColumnsDo: [ :row :column |
		self addChild: (cells atX: row atY: column) ]
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
		elt background: (self cellColorAt: row at: column) ]
]
