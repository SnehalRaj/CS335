import sys

id = 0

def fileToLineInfoArray( infile ):
	with open( infile, 'r' ) as data:
		lines = data.readlines()

	return [ ( len( line.split('\t') ) - 1, line.strip() ) for line in lines ]

def makeId():
	global id

	id += 1
	return 'n{}'.format( id )

def buildTrees( lines, lastIndent = 0, lastParentId = None ):
	i = 0

	trees = []

	if 0 == lastIndent:
		lines = list(filter( lambda l: l[0] > 0 or l[1] == 'tree', lines ))
	parentId = None
	while i < len( list(lines) ):
		if lines[i][0] == lastIndent:
			if 0 == lastIndent:
				parentId = None
			else:
				parentId = makeId()
				trees.extend( [ [ parentId, lines[i][1], lastParentId, lastIndent ] ] )
			i += 1
			continue

		nextLines = [ lines[i] ]
		i += 1
		while i < len( lines ) and not lines[i][0] == lastIndent:
			nextLines.append( lines[i] )
			i += 1

		if len( nextLines ) > 1:
			trees.extend( buildTrees( nextLines, lastIndent + 1, parentId ) )
		else:
			trees.extend( [ [ makeId(), nextLines[0][1], parentId, lastIndent + 1 ] ] )

	return trees

def generateGraph( trees ):
	f = open('tree.dot','w')
	f.write ('digraph tree {'+'\n')
	f.write ('\tratio=0.35;'+'\n')
	f.write ('\tnode [margin=0 shape=circle fontcolor=blue style=filled];'+'\n')
	f.write ('\tedge [arrowhead=none];'+'\n')

	# Go one rank at a time
	rank = 1
	while True:
		rankNodes = filter( lambda x: x[3] == rank, trees )
		if len( list(rankNodes )) == 0:
			break

		nodeList = []
		edgeList = []

		for node in rankNodes:
			nodeLabel = "\n".join( node[1].split(' - ') )
			nodeList.append( '{}[label="{}"];'.format( node[0], nodeLabel ) )
			if not node[2] is None:
				edgeList.append( '{} -> {};'.format( node[2], node[0] ) )
		f.write ('\tnode [margin=0 shape=circle fontcolor=white style=filled fillcolor="0.3 0.4 0.3"];'+'\n')
		f.write ('{{rank=same; {}}};'.format( ' '.join( nodeList ) )+'\n')
		f.write ('\n'.join( edgeList )+'\n')
		
		rank += 1
	f.write ('}'+'\n')

def main():
	infile = sys.argv[1]

	lines = fileToLineInfoArray( infile )

	trees = buildTrees( lines )

	generateGraph( trees )

if "__main__" == __name__:
	main()