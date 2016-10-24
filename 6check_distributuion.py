'''
Verificates the distribution quality of clusters. 
A good distribution is considered when all clusters have at least 0.5% of the total data.
'''

import sys
import os.path 

MIN_PROPORTION = 0.005

def main():
	# Check number of args
	if len(sys.argv) < 4:
		print('\nUSAGE: python3.5 check_distribution.py [rules_files.txt] [cluster_path] [relation_name]\n')
		return

	# Collect args
	rules_file = sys.argv[1]		# Path of .txt containing all rules
	cluster_path = sys.argv[2]		# Path of files containing clusters
	relation_name = sys.argv[3]		# Relation name

	cluster_number = 1
	file_name = cluster_path + relation_name + str(cluster_number) +'.out' # Pattern for a cluster file

	# Count total rules number of rules
	with open(rules_file) as rf:
		rules_number = sum(1 for _ in rf)

	min_rules_number = int(MIN_PROPORTION * float(rules_number))		# Minimum number of rules per cluster

	print('\nINITIAL INFO:')
	print('Relation name: ' + relation_name)
	print('Rules total number: ' + str(rules_number))
	print('Rules file: ' + rules_file)
	print('Searching clusters in: ' + cluster_path)
	print("0.5'%' of rules = " + str(min_rules_number))

	# Checking clusters files
	while os.path.isfile(file_name):
		with open(file_name) as fn:
			cluster_rules_number = sum(1 for _ in fn)
			if cluster_rules_number < min_rules_number:
				print('Cluster ' + str(cluster_number) + ' has too few rules. Not a good distribution!')
				return
		cluster_number = cluster_number + 1
		file_name = cluster_path + relation_name + str(cluster_number) +'.out'

	print('\nDISTRIBUTION RESULTS:')
	print('Found ' + str(cluster_number-1) + ' clusters.')
	print("All of them with at least 0.5% of total rules. This distribution is OKAY!")

if __name__ == '__main__':
	main()
