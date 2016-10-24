library(arules)

# ADULT
data(Adult)
transactions_adult <- as(Adult[,-(50:55)], "transactions")
# Default rules
rules <- apriori(transactions_adult, parameter = list(support = 0.15,confidence = 0.8,minlen=2))
summary(rules)
sorted_rules <- sort(rules, by = "lift")
sorted_rules <- as(sorted_rules, "data.frame")
write.table(sorted_rules[1],"adult_rules.txt")

# Rules based on closed itemsets without inverted ones!
closed_sets <- apriori(transactions_adult, parameter = list(support = 0.15, target="closed",minlen=2))
rules <- ruleInduction(transactions=transactions_adult,x=closed_sets, confidence = 0.8, control=list(method = "apriori",verbose=TRUE))
sorted_rules <- sort(rules, by = "lift")
isDuplicated <- duplicated(sorted_rules)
isSize2 <- size(items(generatingItemsets(sorted_rules)))==2
sorted_rules <- sorted_rules[!(isDuplicated & isSize2)]
sorted_rules <- as(sorted_rules, "data.frame")
write.table(sorted_rules[1],"adult_rules2.txt")


# BREAST-CANCER
csv_bc <- read.csv("bases/breast-cancer/breast_cancer.csv")
matrix_bc <- as(csv_bc,"matrix")
transactions_bc <- as(matrix_bc,"transactions")
# Default rules
rules <- apriori(transactions_bc, parameter = list(support = 0.07,confidence = 0.8,minlen=2))
summary(rules)
sorted_rules <- sort(rules, by = "lift")
sorted_rules <- as(sorted_rules, "data.frame")
write.table(sorted_rules[1],"bc_rules.txt")

# Rules based on closed itemsets without inverted ones!
closed_sets <- apriori(transactions_bc, parameter = list(support = 0.07, target="closed",minlen=2))
rules <- ruleInduction(transactions=transactions_bc,x=closed_sets, confidence = 0.75, control=list(method = "apriori",verbose=TRUE))
sorted_rules <- sort(rules, by = "lift")
isDuplicated <- duplicated(sorted_rules)
isSize2 <- size(items(generatingItemsets(sorted_rules)))==2
sorted_rules <- sorted_rules[!(isDuplicated & isSize2)]
summary(sorted_rules)
sorted_rules <- as(sorted_rules, "data.frame")
write.table(sorted_rules[1],"bc_rules2.txt")


# PROCON
csv_procon <- read.csv("bases/procon/procon.csv",sep=";", fileEncoding="latin1")
csv_procon <- csv_procon[,-(8:10)]
csv_procon <- csv_procon[,-(3)]
csv_procon <- csv_procon[,-(10)]
csv_procon <- csv_procon[,-(11:12)]
csv_procon <- csv_procon[,-(9)]
data_procon <- data.frame(sapply(csv_procon,as.factor))
transactions_procon <- as(data_procon,"transactions")
# Default rules
rules <- apriori(transactions_procon, parameter = list(support = 0.15,confidence = 0.8,minlen=2))
summary(rules)
sorted_rules <- sort(rules, by = "lift")
sorted_rules <- as(sorted_rules, "data.frame")
write.table(sorted_rules[1],"procon_rules.txt")

# Rules based on closed itemsets without inverted ones!
closed_sets <- apriori(transactions_procon, parameter = list(support = 0.1, target="closed",minlen=2))
rules <- ruleInduction(transactions=transactions_procon,x=closed_sets, confidence = 0.49, control=list(method = "apriori",verbose=TRUE))sorted_rules <- sort(rules, by = "lift")
sorted_rules <- sort(rules, by = "lift")
isDuplicated <- duplicated(sorted_rules)
isSize2 <- size(items(generatingItemsets(sorted_rules)))==2
sorted_rules <- sorted_rules[!(isDuplicated & isSize2)]
summary(sorted_rules)
sorted_rules <- as(sorted_rules, "data.frame")
write.table(sorted_rules[1],"procon_rules2.txt")


# VOTACOES
csv_vot <- read.csv("bases/votacoes/votacoes.csv")
vot <- data.frame(sapply(csv_vot,as.factor))
vot <- as(vot,"transactions")
# Default rules
rules <- apriori(vot, parameter = list(support = 0.005,confidence = 0.612,minlen=2))# 1980 rules!
sorted_rules <- sort(rules, by = "lift")
sorted_rules <- as(sorted_rules, "data.frame")
write.table(sorted_rules[1],"vot_rules.txt")

# Rules based on closed itemset, without inverted ones!
closed_sets <- apriori(vot, parameter = list(support = 0.005, target="closed",minlen=2))
rules <- ruleInduction(transactions=vot,x=closed_sets, confidence = 0.62, control=list(method = "apriori",verbose=TRUE))
sorted_rules <- sort(rules, by = "lift")
sorted_rules <- as(sorted_rules, "data.frame")
write.table(sorted_rules[1],"vot_rules2.txt")