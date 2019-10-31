Class {
	#name : #GOLGameCellModel,
	#superclass : #Object,
	#instVars : [
		'alive'
	],
	#category : #GameOfLife
}

{ #category : #'as yet unclassified' }
GOLGameCellModel class >> alive [
	^self new alive: true.
]

{ #category : #'as yet unclassified' }
GOLGameCellModel class >> dead [
	^self new
]

{ #category : #'accessing - private' }
GOLGameCellModel >> alive: aBoolean [
	alive := aBoolean
]

{ #category : #accessing }
GOLGameCellModel >> initialize [
	alive := false
]

{ #category : #accessing }
GOLGameCellModel >> isAlive [
	^ alive
]
