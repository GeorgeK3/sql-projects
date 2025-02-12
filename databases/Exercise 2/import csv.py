import csv
import ast
file = open("dataset\keywords.csv", encoding="utf8")
csvreader = csv.reader(file)
header = next(csvreader)



f = open("dataset\Keyword.csv", 'w',newline='', encoding='utf8')

f1 = open("dataset\haskeyword.csv", 'w',newline='', encoding='utf8')

writer = csv.writer(f)

writer1 = csv.writer(f1)

writer.writerow(['id','name'])

writer1.writerow (['movie_id','keyword_id'])

ids= set()
for row in csvreader:
    json_str = row[1]
    data = ast.literal_eval(json_str)
    for i in range(len(data)):

        if not (data[i]['id'] in ids):
            ids.add(data[i]['id'])
            wrow = [data[i]['id'],data[i]['name']]
            writer.writerow(wrow)

        wrow1 = [row[0],data[i]['id']]
        writer1.writerow(wrow1)

f.close()

f1.close()

file.close()