Class {
	#name : #GOLGameModelTest,
	#superclass : #TestCase,
	#category : #GameOfLife
}

{ #category : #tests }
GOLGameModelTest >> testBecomeAlive [
	| model cell|
	model := GOLGameModel rows: 3 columns: 3.
	model turnAliveAt: 1 at:1.
	model turnAliveAt: 1 at:2.
	model turnAliveAt: 1 at:3.
	cell := model getNextGenerationAt: 2 at: 2.
	self assert: cell equals: true.
]

{ #category : #tests }
GOLGameModelTest >> testCellAccess [
	| model game|
	model := GOLGameModel rows: 3 columns: 3.
	game := model game.
	game indicesDo: [ :i :j | self assert: (game at: i at:j) equals: false. ].
	model turnAliveAt: 2 at:2.
	self assert: (model isAliveAt: 2 at:2) equals: true.
	self assert: (model isAliveAt: 1 at:1) equals: false.
]

{ #category : #tests }
GOLGameModelTest >> testOverPopulation [
	| model cell|
	model := GOLGameModel rows: 3 columns: 3.
	model turnAliveAt: 2 at:2.
	model turnAliveAt: 1 at:1.
	model turnAliveAt: 1 at:2.
	model turnAliveAt: 1 at:3.
	model turnAliveAt: 2 at:1.
	cell := model getNextGenerationAt: 2 at: 2.
	self assert: cell equals: false.
]

{ #category : #tests }
GOLGameModelTest >> testPatternBlinker [
	| model|
	model := GOLGameModel rows: 3 columns: 3.
	model turnAliveAt: 1 at:2.
	model turnAliveAt: 2 at:2.
	model turnAliveAt: 3 at:2.
	model getNextGeneration.
	self assert: (model isAliveAt: 2 at:2) equals: true.
	self assert: (model isAliveAt: 1 at:2) equals: false.
	self assert: (model isAliveAt: 3 at:2) equals: false.
	self assert: (model isAliveAt: 2 at:1) equals: true.
	self assert: (model isAliveAt: 2 at:3) equals: true.
	model getNextGeneration.
	self assert: (model isAliveAt: 2 at:2) equals: true.
	self assert: (model isAliveAt: 1 at:2) equals: true.
	self assert: (model isAliveAt: 3 at:2) equals: true.
	self assert: (model isAliveAt: 2 at:1) equals: false.
	self assert: (model isAliveAt: 2 at:3) equals: false.
	
]

{ #category : #tests }
GOLGameModelTest >> testUnderPopulation [
	| model cell|
	model := GOLGameModel rows: 3 columns: 3.
	model turnAliveAt: 2 at:2.
	cell := model getNextGenerationAt: 2 at: 2.
	self assert: cell equals: false.
]
