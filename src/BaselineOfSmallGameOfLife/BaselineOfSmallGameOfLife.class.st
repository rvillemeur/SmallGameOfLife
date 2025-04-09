Class {
	#name : 'BaselineOfSmallGameOfLife',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfSmallGameOfLife',
	#package : 'BaselineOfSmallGameOfLife'
}

{ #category : 'baselines' }
BaselineOfSmallGameOfLife >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'GameOfLife'
			with: [ spec requires: #( 'ContainersArray2D' ) ].
		spec
			baseline: 'ContainersArray2D'
			with: [
			spec repository: 'github://pharo-containers/Containers-Array2D/src' ] ]
]
