Class {
	#name : #GOLGameCellModel,
	#superclass : #Object,
	#instVars : [
		'alive'
	],
	#category : #GameOfLife
}

{ #category : #initialization }
GOLGameCellModel >> initialize [
	alive := false
]

{ #category : #'as yet unclassified' }
GOLGameCellModel >> isAlive [
	^ alive
]

{ #category : #'as yet unclassified' }
GOLGameCellModel >> turnAlive [
	alive := true.
]

{ #category : #'as yet unclassified' }
GOLGameCellModel >> turnDead [
	alive := false.
]
