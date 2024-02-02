"
I manage the test for Game of Life model rule implementation.
"
Class {
	#name : #GOLModelTest,
	#superclass : #TestCase,
	#category : #'GameOfLife-Tests'
}

{ #category : #tests }
GOLModelTest >> testBecomeAlive [
	| model cell|
	model := GOLModel rows: 3 columns: 3 pattern: #( true false false
																  true false false
																  true false false  ).
	cell := model getNextGenerationAt: 2 at: 2.
	self assert: cell equals: true.
]

{ #category : #tests }
GOLModelTest >> testOverPopulation [
	| model cell|
	model := GOLModel rows: 3 columns: 3 pattern: #( true true false
																  true true false
																  true false false  ).
	cell := model getNextGenerationAt: 2 at: 2.
	self assert: cell equals: false.
]

{ #category : #tests }
GOLModelTest >> testPatternBlinker [
	| model|
	model := GOLModel rows: 3 columns: 3 pattern: #( false true false
																  false true false
																  false true false  ).
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
GOLModelTest >> testUnderPopulation [
	| model cell|
	model := GOLModel rows: 3 columns: 3 pattern: #( false false false
																  false true false
																  false false false  ).
	cell := model getNextGenerationAt: 2 at: 2.
	self assert: cell equals: false.
]
