"
Game of life display using Bloc graphical stack
Look at example to launch specific game of life pattern
"
Class {
	#name : #GOLGameBloc,
	#superclass : #BlElement,
	#instVars : [
		'rows',
		'columns',
		'model',
		'cells'
	],
	#category : #'GameOfLife-UI'
}

{ #category : #'instance creation' }
GOLGameBloc class >> rows: rowNumber columns: columnNumber pattern: aGamePattern [
	^self new rows: rowNumber columns: columnNumber pattern: aGamePattern.
]

{ #category : #initialization }
GOLGameBloc >> animation [

	| animation |
	animation := BlAnimation new
		             beInfinite;
		             duration: 0.6 seconds.

	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :anEvent | model getNextGeneration. self updateCells ]).

	^ animation
]

{ #category : #initialization }
GOLGameBloc >> initCells [

	cells := Array2D
		               rows: rows
		               columns: columns
		               tabulate: [ :i :j |
			               BlElement new
				               background: Color white;
				               border: (BlBorder paint: Color black width: 1);
				               constraintsDo: [ :c |
					               c horizontal matchParent.
					               c vertical matchParent ] ]
]

{ #category : #initialization }
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

	cells indicesDo: [ :row :column |
		self addChild: (cells at: row at: column) ]
]

{ #category : #'instance creation' }
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

{ #category : #'update cycle' }
GOLGameBloc >> updateCells [

	cells withIndicesDo: [ :elt :row :column |
		elt background: ((model isAliveAt: row at: column)
				 ifTrue: [ Color black ]
				 ifFalse: [ Color white ]) ]
]
