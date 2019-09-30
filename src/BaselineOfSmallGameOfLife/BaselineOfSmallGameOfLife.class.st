Class {
	#name : #BaselineOfSmallGameOfLife,
	#superclass : #BaselineOf,
	#category : #BaselineOfSmallGameOfLife
}

{ #category : #baselines }
BaselineOfSmallGameOfLife >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'GameOfLife' ]
]
