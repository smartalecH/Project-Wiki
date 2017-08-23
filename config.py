import os
basedir = os.path.abspath(os.path.join(os.path.abspath(os.path.dirname(__file__)), '..'))


class Config:
    DEBUG = os.environ.get('DEBUG', False)
    SECRET_KEY = os.environ.get('SECRET_KEY', <put some hard to guess string here>)
    WTF_CSRF_ENABLED = True
    MONGODB_SETTINGS = {
        'db': os.environ.get('DB_NAME', 'admin'),
        'host': os.environ.get('DB_SERVICE', <database ip>),
        'port': os.environ.get('DB_PORT', <database port>),
        'username': os.environ.get('DB_USER', <database username>),
        'password': os.environ.get('DB_PASS', <database password>)
    }
    
    MAIL_SERVER = 'smtp.googlemail.com'
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USERNAME = os.environ.get('MAIL_USERNAME', <email>)
    MAIL_PASSWORD = os.environ.get('MAIL_PASSWORD', <email password>)
    MAIL_SENDER = 'Project Wiki <{}>'.format(os.environ.get('MAIL_USERNAME', <email>))
    MAIL_SUBJECT_PREFIX = '[Do-not-reply]'
    
    # Super admin username, email, and password
    # The email can be the same as the one above.
    ADMIN_USERNAME = os.environ.get('ADMIN_USERNAME', <admin username>)
    ADMIN_EMAIL = os.environ.get('ADMIN_EMAIL', <admin email>)
    ADMIN_PASSWORD = os.environ.get('ADMIN_PASSWORD', <admin password>)

    UPLOAD_FOLDER = os.path.join(basedir, 'Project_Wiki_Data', 'uploads')


config = Config()
