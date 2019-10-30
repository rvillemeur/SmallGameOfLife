Class {
	#name : #GOLGameCellTest,
	#superclass : #TestCase,
	#category : #GameOfLife
}

{ #category : #tests }
GOLGameCellTest >> testCell [
	| model |
	model := GOLGameCellModel new.
	self assert: model isAlive equals: false.
	model turnAlive.
	self assert: model isAlive equals: true.
	model turnDead.
	self assert: model isAlive equals: false.
	
]
