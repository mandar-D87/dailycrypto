import requests
from bs4 import BeautifulSoup as BSoup
import MySQLdb

db = MySQLdb.connect(host='localhost',
                     user='root',
                     password='',
                     database='dailycrypto')

cursor = db.cursor()


def scrape():
    res = requests.get('https://bitcoinist.com/category/bitcoin/')
    soup = BSoup(res.text, 'html.parser')
    main = soup.select('.featured-image')[6:]
    for data in main:
        link = data.get('href')
        title = data.get('title')
        posted_by = 'Bitcoinist_News'
        cursor.execute('INSERT IGNORE INTO POSTS(title,slug,posted_by) VALUES (%s,%s,%s);', [title, link, posted_by])
        db.commit()













