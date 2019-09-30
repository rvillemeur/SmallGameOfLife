"
I represent a single cell in the game of life.
I'm either On (black), or Off (White) to display my current status. 
"
Class {
	#name : #GOLCell,
	#superclass : #SimpleSwitchMorph,
	#instVars : [
		'mouseAction'
	],
	#category : #GameOfLife
}

{ #category : #initialization }
GOLCell >> initialize [
	super initialize.
	self label: ''.
	self borderWidth: 2.
	bounds := 0 @ 0 corner: 16 @ 16.
	offColor := Color white.
	onColor := Color black.
	self useSquareCorners.
	self turnOff
]
