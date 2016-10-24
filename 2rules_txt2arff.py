'''
TXT-rules to ARFF-rules converter.

Input txt rules format: attr1=value,attr2=value,... -> attr3=value,...
'''

import sys

def main():
	# Check number of args
	if len(sys.argv) < 3:
		print('\nUSAGE: python3.5 rules2arff.py [rules_file.txt] [relation_name]\n')
		return

	# Input file
	file_name = str(sys.argv[1])
	print('Reading rules from file: ' + file_name)

	relation_name = str(sys.argv[2])
	print('Relation name: ' + relation_name)

	# Attribute dictionary
	attributes = {}

	with open(file_name) as f:
		num_of_rules = sum(1 for _ in f)
		print('Number of lines (rules) = ' + str(num_of_rules))

	# Read input file
	with open(file_name) as f:
		current_rule = 0
		for rule in f:
			rule = rule.rstrip('\n')		# remove \n from end of string
			rule = rule.replace(" ", "")	# remove spaces
			rule_split = rule.split('->')	# Separete antecedent and consequent

			# Build item set string, with items separated by comma
			LHS = rule_split[0].split(',')	# Left-hand side of rule (antecedent)
			RHS = rule_split[1].split(',')	# Right-hand side (consequent)

			# Register attributes and their occurence in each rule
			for item in LHS:
				if item not in attributes.keys():
					new_list = [0 for _ in range(0, num_of_rules)]
					attributes[item] = new_list
				attributes[item][current_rule] = 1
			
			for item in RHS:
				if item not in attributes.keys():
					new_list = [0 for _ in range(0, num_of_rules)]
					attributes[item] = new_list
				attributes[item][current_rule] = 2
			current_rule = current_rule + 1

	for attribute_name in attributes.keys():
		print(str(attribute_name))


	# Write arff
	arff_file_name = relation_name + '.arff'
	with open(arff_file_name, 'w') as fa:
		# Write relation line
		fa.write('@RELATION ' + relation_name + '\n')

		# Write attribute list
		for attribute_name in attributes.keys():
			fa.write('@ATTRIBUTE ' +attribute_name+ ' NUMERIC' + '\n')

		# Write data
		fa.write('@DATA' + '\n')
		for rule_index in range(0,num_of_rules):
			data = ''
			for attribute_name in attributes.keys():
				data = data + str(attributes[attribute_name][rule_index]) + ','
			data = data[:-1] + '\n'	# remove last comma
			#print('data line = ' + data)
			fa.write(data)

	print('Done!')

if __name__ == '__main__':
	main()