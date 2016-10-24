'''
Put rules in clusters (files).
'''

import sys
import os.path 

def main():
	# Check number of args
	if len(sys.argv) < 3:
		print('\nUSAGE: python3.5 build_clusters.py [rules_file] [cluster_vector_file]\n')
		return

	# Read input parameters
	rules_file = sys.argv[1]
	cluster_vector_file = sys.argv[2]
	# Place cluster files in the same folder of the vector
	clusters_path = os.path.dirname(cluster_vector_file) + '/'

	with open(rules_file) as rf, open(cluster_vector_file) as cvf:
		cluster_vector = cvf.read()
		cluster_num = cluster_vector.split(' ')
		i = 0
		for rule in rf:
			cluster_file = clusters_path + 'cluster_' + cluster_num[i] + '.out'
			with open(cluster_file, 'a') as cf:
				cf.write(rule)
			i = i + 1

if __name__ == '__main__':
	main()