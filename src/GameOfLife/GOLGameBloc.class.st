"
Game of life display using Bloc graphical stack
Look at example to launch specific game of life pattern
"
Class {
	#name : #GOLGameBloc,
	#superclass : #Object,
	#instVars : [
		'cells',
		'rows',
		'columns',
		'elementList'
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
	animation := BlTransition new
		             from: 0;
		             to: 1;
		             beInfinite;
		             duration: 0.6 seconds;
		             onStepDo: [ :aValue :anElement | self updateElements ].

	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :anEvent | cells getNextGeneration ]).

	^ animation
]

{ #category : #initialization }
GOLGameBloc >> initDisplay [

	| container |
	self initElements.

	container := BlElement new
		             constraintsDo: [ :c |
			             c horizontal matchParent.
			             c vertical matchParent ];
		             border: (BlBorder paint: Color black width: 3);
		             layout: (BlGridLayout new
				              rowCount: rows;
				              columnCount: columns);
		             addAnimation: (self animation).

	1 to: rows do: [ :row |
		1 to: columns do: [ :column |
		container addChild: (elementList at: row at: column) ] ].

	container openInNewSpace
]

{ #category : #initialization }
GOLGameBloc >> initElements [

	elementList := Array2D
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

{ #category : #'instance creation' }
GOLGameBloc >> rows: rowNumber columns: columnNumber pattern: aGamePattern [

	rows := rowNumber.
	columns := columnNumber.
	cells := GOLModel
		         rows: rowNumber
		         columns: columnNumber
		         pattern: aGamePattern.
	self initDisplay.
	^ self
]

{ #category : #'update cycle' }
GOLGameBloc >> updateElements [

	1 to: rows do: [ :row |
		1 to: columns do: [ :column |
			(elementList at: row at: column) background:
				((cells isAliveAt: row at: column)
					 ifTrue: [ Color black ]
					 ifFalse: [ Color white ]) ] ]
]
