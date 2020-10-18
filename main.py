from flask import Flask, render_template, request, session, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
import json
from datetime import datetime
from flask_mail import Mail
import os
import math
from werkzeug.utils import secure_filename
from apscheduler.schedulers.background import BackgroundScheduler
import time
from scrape import scrape



with open('config.json', 'r') as config:
    params = json.load(config)['params']

local_server = True

app = Flask(__name__)
app.secret_key = 'let us crypto'
app.config['UPLOAD_FOLDER'] = params['upload_location']
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail-password'],
)
mail = Mail(app)
if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)

class Contacts(db.Model):
    srno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80),nullable=False)
    email = db.Column(db.String(20),nullable=False)
    phone_num = db.Column(db.String(12),nullable=False)
    msg = db.Column(db.String(120),nullable=False)
    date = db.Column(db.String(12),nullable=False)

class Posts(db.Model):
    srno = db.Column(db.Integer, primary_key=True)
    img = db.Column(db.String(80),nullable=False)
    title = db.Column(db.String(20),nullable=False, unique=True)
    slug = db.Column(db.String(50),nullable=False)
    content = db.Column(db.String(120),nullable=False)
    posted_by = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12),nullable=False)


@app.route('/')
def home():
    posts = Posts.query.order_by(Posts.date.desc()).all()
    last = math.ceil(len(posts)/int(params['no_of_posts']))
    #[0:params['no_of_posts']]
    page = request.args.get('page')
    if (not str(page).isnumeric()):
        page = 1
    page = int(page)
    posts = posts[(page-1)*int(params['no_of_posts']): (page-1)*int(params['no_of_posts'])+int(params['no_of_posts'])]
    #Pagination Logic
    # first page
    if (page==1):
        prev = '#'
        next = '/?page='+ str(page+1)
    # last page
    elif (page==last):
        prev = '/?page=' + str(page-1)
        next = '#'
    # middle page
    else:
        prev = '/?page=' + str(page-1)
        next = '/?page=' \
               '' + str(page+1)

    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)

@app.route('/about')
def about():
    return render_template('about.html', params=params)

@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():
    if ('user' in session and session['user'] == params["admin_user"]):
        posts = Posts.query.order_by(Posts.date.desc()).all()
        return render_template('dashboard.html', params=params, posts=posts)


    if request.method == 'POST':
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if (username == params["admin_user"] and userpass == params["admin_pass"]):
            session['user'] = username
            posts = Posts.query.order_by(Posts.date.desc()).all()
            return render_template('dashboard.html', params=params, posts=posts)
    else:
        return render_template('login.html', params=params)

# @app.route('/post/<string:post_slug>', methods=['GET'])
# def post_route(post_slug):
#         post = Posts.query.filter_by(slug=post_slug).first()
#         return render_template('post.html', params=params, post=post)


@app.route('/post/<string:post_slug>', methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)


@app.errorhandler(404)
def go_to(url):
    url = str(str(request.path).split('/post/')[1])
    return redirect(url)


@app.route('/edit/<string:srno>', methods=['GET', 'POST'])
def edit(srno):
    if ('user' in session and session['user'] == params["admin_user"]):
        if request.method == 'POST':
            box_title = request.form.get('title')
            slug = request.form.get('slug')
            content = request.form.get('content')
            posted_by = request.form.get('posted_by')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if srno == '0':
                post = Posts(title=box_title, slug=slug, img=img_file, content=content, posted_by=posted_by, date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(srno=srno).first()
                post.title = box_title
                post.slug = slug
                post.content = content
                post.posted_by = posted_by
                post.img_file = img_file
                post.date = date
                db.session.commit()
                return redirect('/edit/'+srno)
        post = Posts.query.filter_by(srno=srno).first()
        return render_template('edit.html', params=params, post=post, srno=srno)


@app.route('/uploader', methods=['GET', 'POST'])
def uploader():
    if ('user' in session and session['user'] == params["admin_user"]):
        if (request.method == 'POST'):
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return 'Uploaded Successfully'



@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')



@app.route('/delete/<string:srno>', methods=['GET', 'POST'])
def delete(srno):
    if ('user' in session and session['user'] == params["admin_user"]):
        post = Posts.query.filter_by(srno=srno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')



@app.route('/contact', methods=['GET', 'POST'])
def contact():
    if (request.method == 'POST'):
        '''Add Entry to database'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        entry = Contacts(name=name, email=email, phone_num=phone, msg=message, date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New Message on Dailycrypto from ' + name,
                          sender=email,
                          recipients=[params['gmail-user']],
                          body = message + '\n' + '\n' + name + '\n' + phone + '\n' + email
                          )
    return render_template('contact.html', params=params)


scheduler = BackgroundScheduler()
scheduler.add_job(func=scrape, trigger='interval', minutes=5, id='my_scrape')
scheduler.start()

app.run(debug=True)








    