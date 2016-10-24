'''
Modularity and Leading Eigenvector clustering (community detection) methods
Includes time measuares
'''

import igraph as ig
import sys
import time

def main():
	if len(sys.argv) < 2:
		print('\nUSAGE: python3.5 community_detection.py [sim.txt]\n')
		return

	sim_file = sys.argv[1]		# Similarity matrix file

	# Load similarity matrix
	sim = []
	i = 0
	with open(sim_file) as sf:
		for line in sf:
			sim_line = line.strip('\n').split(sep='\t')
			sim_line = [float(value) for value in sim_line]
			sim.append(sim_line)

	g = ig.Graph.Weighted_Adjacency(sim, mode=ig.ADJ_UNDIRECTED , attr="weight", loops=True)
	# Modularity
	start_time = time.time()
	dendogram = ig.Graph.community_fastgreedy(g, weights=g.es["weight"])
	clusters = dendogram.as_clustering()
	membership_mod = clusters.membership
	print("Modularity time --- %s seconds ---" % (time.time() - start_time))

	# Leading eigenvector
	start_time = time.time()
	dendogram = ig.Graph.community_leading_eigenvector(g, clusters=100, weights=g.es["weight"])
	membership_lead = dendogram.membership
	print("L. eigenvector time--- %s seconds ---" % (time.time() - start_time))

	with open('modularity.txt', 'w') as result:
		for num in membership_mod:	result.write('%s ' % num)

	with open('leading.txt', 'w') as result:
		for num in membership_lead:	result.write('%s ' % num)

if __name__ == '__main__':

	main()
