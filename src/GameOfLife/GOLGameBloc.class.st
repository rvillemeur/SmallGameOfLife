Class {
	#name : #GOLGameBloc,
	#superclass : #BlElement,
	#instVars : [
		'cells',
		'rows',
		'columns'
	],
	#category : #'GameOfLife-UI'
}

{ #category : #'instance creation' }
GOLGameBloc class >> rows: rowNumber columns: columnNumber pattern: aGamePattern [
	^self new rows: rowNumber columns: columnNumber pattern: aGamePattern.
]

{ #category : #initialization }
GOLGameBloc >> initGraphics [

	| grid animation |
	grid := Array2D rows: rows columns: columns tabulate: [ :i :j |
		        BlElement new
			        background: Color white;
			        border: (BlBorder paint: Color black width: 1);
			        constraintsDo: [ :c |
				        c horizontal matchParent.
				        c vertical matchParent ] ].

	animation := BlNumberTransition new
		             from: 0;
		             to: 1;
		             by: 0.7;
		             beInfinite;
		             duration: 0.5 seconds;
		             onStepDo: [ :aValue :anElement |
			             aValue > 0.5 ifTrue: [ cells getNextGeneration ].

			             1 to: rows do: [ :row |
					             1 to: columns do: [ :column |
							             (grid at: row at: column) background:
									             ((cells isAliveAt: row at: column)
										              ifTrue: [ Color black ]
										              ifFalse: [ Color white ]) ] ] ].

	self layout: (BlGridLayout new
			 rowCount: rows;
			 columnCount: columns).

	1 to: rows do: [ :row |
		1 to: columns do: [ :column |
		self addChild: (grid at: row at: column) ] ].

	self addAnimation: animation
]

{ #category : #initialization }
GOLGameBloc >> initialize [

	super initialize.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self border: (BlBorder paint: Color black width: 3).
	self openInNewSpace
]

{ #category : #'instance creation' }
GOLGameBloc >> rows: rowNumber columns: columnNumber pattern: aGamePattern [

	rows := rowNumber.
	columns := columnNumber.
	cells := GOLModel
		         rows: rowNumber
		         columns: columnNumber
		         pattern: aGamePattern.
	self initGraphics.
	^ self
]
