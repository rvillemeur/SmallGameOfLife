"
Example layout of game of life
"
Class {
	#name : 'GOLGameExample',
	#superclass : 'Object',
	#category : 'GameOfLife-Example',
	#package : 'GameOfLife',
	#tag : 'Example'
}

{ #category : 'examples' }
GOLGameExample class >> blinkerBloc [

	<example>
	| game |
	game := GOLGameBloc
		        rows: 3
		        columns: 3
		        pattern:
		        #( false true false 
					  false true false 
					  false true false )
]

{ #category : 'examples' }
GOLGameExample class >> pentathlonBloc [

	<example>
	| game |
	game := GOLGameBloc
		        rows: 9
		        columns: 16
		        pattern:
			        #( false false false false false false false false false false false false false false false false 
						  false false false false false false false false false false false false false false false false 
						  false false false false false false false false false false false false false false false false 
						  false false false false false true  false false false false true false false false  false false 
						  false false false true  true  false true true   true   true false true true false   false false 
						  false false false false false true false false  false false true false false false  false false 
						  false false false false false false false false false false false false false false false false 
						  false false false false false false false false false false false false false false false false
			           false false false false false false false false false false false false false false false false ).

]

{ #category : 'see class side' }
GOLGameExample >> seeClassSide [ 
]
