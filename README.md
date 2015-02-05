# coursera_datascience
R cheatsheet
https://github.com/startupjing/Tech_Notes/blob/master/R/R_language.md
Quick R
http://www.statmethods.net/

# Compare SQL actions

## SQL
```SQL
SELECT summarize(col1, col2) as newcol
INTO results
FROM table
WHERE check(col3, col4) IS TRUE
GROUP BY col5, categorize(col6)
HAVING subcheck(col7, col8) IS TRUE
ORDER BY key(col9) DESC
LIMIT 10;
```
## R
```R
aggdata <-aggregate(cbind(col1, col2) ~ col5 + categorize(col6), data=table, FUN=summarize)
having <-aggregate(cbind(col7, col8) ~ col5 + categorize(col6), data=table, FUN=subcheck)
order_key <- aggregate(col9 ~ col5 + categorize(col6), data=table, FUN=key)
aggdata[having, ][order(-order_key), ]
```

## R using data.table
```R
table[check(col3, col4), c('newcol', having_check) := list(summarize(col1, col2), subcheck(col7, col8)), 
by=(col5, categorize(col6))][having_check][order(-key(col9))][1:10]
```

## Python using Pandas
```python
selected = table[check(table.col3, table.col4)]
results = selected.groupby(['col5', categorize(selected.col6)]).fiter(
    lambda t: subcheck(t.col7, t.col8)
  ).apply(
    lambda t:DataFrame(dict(newcol=summarize(t.col1, t.col2),sortkey=key(t.col9))
  ).sort('sortkey', ascending=False).head(10)
```

##In Program using Collectors
```Python
def get_answers():
	results = []
	for g in generate_group(col5, col6, categorize):
		collector = []
		key_collector = []
		having_collector = []
		for p in parameter_range(g):
			if check(col3(g, p), col4(g, p)):
				collector.append(col1(g, p), col2(g, p))
				having_collector.append(col7(g, p), col8(g, p))
				key_collector.append(col9(g, p))
		if subcheck(having_collector):
			newcol = summarize(collector)
			sortkey = key(key_collector)
			results.append((sortkey, newcol))
	return results

results = sorted(get_anwser(), reverse=True)[:10]
```


## In Program using Yield
```Python
def yield_anwsers():
	def calculate_group(g):
		for p in parameter_range(g):
			if check(col3(g, p), col4(g, p)):
				collector = (col1(g, p), col2(g, p))
				having = (col7(g, p), col8(g, p))
				key = col9(g, p)
				yield collector, having, key

	
	for g in generate_group(col5, col6, categorize):
		collectors, havings, keys = zip(*calculate_group(g))
		if subcheck(havings):
			newcol = summarize(collectors)
			sortkey = key(keys)
			yield sortkey, newcol

results = sorted(yield_anwsers(), reverse=True)[:10]
```

## In Program vector style
```Python
def yield_anwsers():
	for g in generate_group(col5, col6, categorize):
		ps = makeps(parameter_range)
		col3 = makecol3(g, ps)
		col4 = makecol4(g, ps)
		loc = makloc(check, col3, col4)
		col1 = makecol1(g, loc, ps)
		col2 = makecol2(g, loc, ps)
		col7 = makecol7(g, loc, ps)
		col8 = makecol8(g, loc, ps)
		col9 = makecol9(g, loc, ps)
		if subcheck(col7, col8):
			newcol = summarize(col1, col2)
			sortkey = key(col9)
			yield sortkey, newcol

results = sorted(yield_anwsers(), reverse=True)[:10]
```


