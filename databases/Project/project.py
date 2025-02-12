import pyodbc
from mpl_toolkits.mplot3d import axes3d
import numpy as np
import matplotlib.pyplot as plt

server = 'mysqlservergeorges.database.windows.net'
database = 'ExercisesDatabase'
username = 'examiner'
password = 'passworD!' 

cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)

cursor = cnxn.cursor()

"""
/* Ερώτημα 1 */
"""

cursor.execute("""
SELECT YEAR(release_date) AS year , COUNT(*) AS movies_per_year
FROM movie
WHERE budget > 1000000
GROUP BY YEAR(release_date)
ORDER BY year DESC """)


x=[]
y=[]

for i in cursor:
    x.append(i[0])
    y.append(i[1])

plt.title("Ερώτημα 1")
plt.xlabel('year')
plt.ylabel('movies_per_year')
plt.bar(x,y)
plt.show()

"""
/* Ερώτημα 2 */
"""

cursor.execute("""
SELECT genre.name AS genre,COUNT(*) AS movies_per_genre
FROM genre,hasGenre,movie
WHERE genre.id = hasGenre.genre_id AND hasGenre.movie_id = movie.id AND (movie.budget > 1000000 OR movie.runtime>120)
GROUP BY genre.name""")



x=[]
y=[]



for i in cursor:
    x.append(i[0])
    y.append(i[1])


fig, ax = plt.subplots()

hbars = ax.barh(x,y)

ax.invert_yaxis()

ax.set_title('Ερώτημα 2')


plt.ylabel('genre')
plt.xlabel('movies_per_genre')
plt.show()


"""
/* Ερώτημα 3 */
"""

cursor.execute("""
SELECT genre.name as genre, YEAR(release_date) as year, COUNT(*) as  movies_per_gy
FROM movie
JOIN (genre 
    JOIN hasGenre ON genre.id=hasGenre.genre_id) 
    ON hasGenre.movie_id=movie.id
GROUP BY genre.name,YEAR(release_date)
HAVING YEAR(release_date) is not NULL""")

genre=[]
year=[]
movies_per_gy=[]



for i in cursor:
    genre.append(i[0])
    year.append(i[1])
    movies_per_gy.append(i[2])

# Initializing Figure
fig = plt.figure()
ax1 = fig.add_subplot(111, projection='3d')
ax1.set_facecolor((1.0, 1.0, 1.0))


# Creating a dictionary from categories to x-axis coordinates
xCategories = genre


i=0
xDict = {}
x=[]
for category in xCategories:
  if category not in xDict:
    xDict[category]=i
    x.append(i)
    i+=1
  else:
    x.append(xDict[category])



# Defining the starting position of each bar (x is already defined)
y = year
z = np.zeros(len(movies_per_gy))


# Defining the length/width/height of each bar.
dx = np.ones(len(x))*0.01
dy = np.ones(len(y))
dz = movies_per_gy

ax1.bar3d(x, y, z, dx, dy, dz)

ax1.set_zlabel('movies_per_gy')

plt.title("Ερώτημα 3")
plt.xlabel("genre")
plt.ylabel("year")

plt.xticks(range(len(xDict.values())), xDict.keys())
plt.show()


"""
/* Ερώτημα 4 */
"""

cursor.execute("""
SELECT Year(release_date) AS year, SUM(revenue) AS revenues_per_year
FROM movie
INNER JOIN movie_cast ON (movie.id=movie_cast.movie_id AND movie_cast.name LIKE 'Morgan Freeman')
GROUP BY Year(release_date)""")

x=[]
y=[]


for i in cursor:
    x.append(i[0])
    y.append(i[1])



plt.title("Ερώτημα 4")
plt.xlabel('year')
plt.ylabel('revenues_per_year')
plt.bar(x,y)
plt.show()

"""
/* Ερώτημα 5 */
"""

cursor.execute("""
SELECT  Year(release_date) as year,  MAX(budget) AS max_budget
FROM movie
GROUP BY Year(release_date)
HAVING MAX(budget)>0
ORDER BY Year(release_date) DESC""")

x=[]
y=[]


for i in cursor:
    x.append(i[0])
    y.append(i[1])

plt.title("Ερώτημα 5")
plt.xlabel('year')
plt.ylabel('max_budget')
plt.bar(x,y)
plt.show()


"""
/* Ερώτημα 7 */
"""

cursor.execute("""
SELECT AVG(rating) as avg_rating, COUNT(*) AS rating_count
FROM ratings
GROUP BY user_id""")

x=[]
y=[]


for i in cursor:
    x.append(i[0])
    y.append(i[1])

plt.figure(figsize=(20, 3))  # width:20, height:3

plt.title("Ερώτημα 7")
plt.xlabel('avg_rating')
plt.ylabel('rating_count')
plt.scatter(x, y,s=1)
plt.show()