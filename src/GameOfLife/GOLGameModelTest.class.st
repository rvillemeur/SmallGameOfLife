Class {
	#name : #GOLGameModelTest,
	#superclass : #TestCase,
	#category : #GameOfLife
}

{ #category : #tests }
GOLGameModelTest >> testBecomeAlive [
	| model cell|
	model := GOLGameModel rows: 3 columns: 3.
	model game at: 1 at:1 put: GOLGameCellModel alive.
	model game at: 1 at:2 put: GOLGameCellModel alive.
	model game at: 1 at:3 put: GOLGameCellModel alive.
	cell := model getNextGenerationAt: 2 at: 2.
	self assert: cell isAlive equals: true.
]

{ #category : #tests }
GOLGameModelTest >> testCellAccess [
	| model game|
	model := GOLGameModel rows: 3 columns: 3.
	game := model game.
	game indicesDo: [ :i :j | self assert: (game at: i at:j) isAlive equals: false. ].
	model game at: 2 at:2 put: GOLGameCellModel alive.
	self assert: (model game at: 2 at:2) isAlive equals: true.
	self assert: (model game at: 1 at:1) isAlive equals: false.
]

{ #category : #tests }
GOLGameModelTest >> testInstanceCreation [
	| model |
	model := GOLGameModel rows: 3 columns: 3.
	self assert: model game numberOfRows equals: 3.
	self assert: model game numberOfColumns equals: 3.
]

{ #category : #tests }
GOLGameModelTest >> testOverPopulation [
	| model cell|
	model := GOLGameModel rows: 3 columns: 3.
	model game at: 2 at:2 put: GOLGameCellModel alive.
	model game at: 1 at:1 put: GOLGameCellModel alive.
	model game at: 1 at:2 put: GOLGameCellModel alive.
	model game at: 1 at:3 put: GOLGameCellModel alive.
	model game at: 2 at:1 put: GOLGameCellModel alive.
	cell := model getNextGenerationAt: 2 at: 2.
	self assert: cell isAlive equals: false.
]

{ #category : #tests }
GOLGameModelTest >> testPatternBlinker [
	| model|
	model := GOLGameModel rows: 3 columns: 3.
	model game at: 1 at:2 put: GOLGameCellModel alive.
	model game at: 2 at:2 put: GOLGameCellModel alive.
	model game at: 3 at:2 put: GOLGameCellModel alive.
	model getNextGeneration.
	self assert: (model game at: 2 at:2) isAlive equals: true.
	self assert: (model game at: 1 at:2) isAlive equals: false.
	self assert: (model game at: 3 at:2) isAlive equals: false.
	self assert: (model game at: 2 at:1) isAlive equals: true.
	self assert: (model game at: 2 at:3) isAlive equals: true.
	model getNextGeneration.
	self assert: (model game at: 2 at:2) isAlive equals: true.
	self assert: (model game at: 1 at:2) isAlive equals: true.
	self assert: (model game at: 3 at:2) isAlive equals: true.
	self assert: (model game at: 2 at:1) isAlive equals: false.
	self assert: (model game at: 2 at:3) isAlive equals: false.
	
]

{ #category : #tests }
GOLGameModelTest >> testUnderPopulation [
	| model cell|
	model := GOLGameModel rows: 3 columns: 3.
	model game at: 2 at:2 put: GOLGameCellModel alive.
	cell := model getNextGenerationAt: 2 at: 2.
	self assert: cell isAlive equals: false.
]
