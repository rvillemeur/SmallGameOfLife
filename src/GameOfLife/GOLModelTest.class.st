"
I manage the test for Game of Life model rule implementation.
"
Class {
	#name : 'GOLModelTest',
	#superclass : 'TestCase',
	#category : 'GameOfLife-Tests',
	#package : 'GameOfLife',
	#tag : 'Tests'
}

{ #category : 'tests' }
GOLModelTest >> testBecomeAlive [
	| model cell|
	model := GOLModel rows: 3 columns: 3 pattern: #( true false false
																  true false false
																  true false false  ).
	cell := model getNextGenerationAtX: 2 atY: 2.
	self assert: cell equals: true.
]

{ #category : 'tests' }
GOLModelTest >> testNextGeneration [
	| model cell|
	model := GOLModel rows: 3 columns: 3 pattern: #( true true false
																  false true false
																  false false true  ).
	cell := model getNextGenerationAtX: 2 atY: 2.
	self assert: cell equals: true.
	
	model := GOLModel rows: 3 columns: 3 pattern: #( true true false
																  false true false
																  false false false  ).
	cell := model getNextGenerationAtX: 2 atY: 2.
	self assert: cell equals: true.
]

{ #category : 'tests' }
GOLModelTest >> testOverPopulation [
	| model cell|
	model := GOLModel rows: 3 columns: 3 pattern: #( true true false
																  true true false
																  true false false  ).
	cell := model getNextGenerationAtX: 2 atY: 2.
	self assert: cell equals: false.
]

{ #category : 'tests' }
GOLModelTest >> testPatternBlinker [
	| model|
	model := GOLModel rows: 3 columns: 3 pattern: GOLGameExample blinkerPattern .
	
	model getNextGeneration.
	self assert: (model isAliveAtX: 1 atY:1) equals: false.
	self assert: (model isAliveAtX: 2 atY:1) equals: false.
	self assert: (model isAliveAtX: 3 atY:1) equals: false.
	
	self assert: (model isAliveAtX: 1 atY:2) equals: true.
	self assert: (model isAliveAtX: 2 atY:2) equals: true.
	self assert: (model isAliveAtX: 3 atY:2) equals: true.
		
	self assert: (model isAliveAtX: 1 atY:3) equals: false.
	self assert: (model isAliveAtX: 2 atY:3) equals: false.
	self assert: (model isAliveAtX: 3 atY:3) equals: false.

	model getNextGeneration.
	self assert: (model isAliveAtX: 2 atY:2) equals: true.
	self assert: (model isAliveAtX: 2 atY:1) equals: true.
	self assert: (model isAliveAtX: 2 atY:3) equals: true.
	self assert: (model isAliveAtX: 1 atY:2) equals: false.
	self assert: (model isAliveAtX: 3 atY:2) equals: false.
	
]

{ #category : 'tests' }
GOLModelTest >> testReproduction [
	| model cell|
	model := GOLModel rows: 3 columns: 3 pattern: #( true true false
																  false false false
																  false false true  ).
	cell := model getNextGenerationAtX: 2 atY: 2.
	self assert: cell equals: true.
]

{ #category : 'tests' }
GOLModelTest >> testUnderPopulation [
	| model cell|
	model := GOLModel rows: 3 columns: 3 pattern: #( false false false
																  false true false
																  false false false  ).
	cell := model getNextGenerationAtX: 2 atY: 2.
	self assert: cell equals: false.
]
