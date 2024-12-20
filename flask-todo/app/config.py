DEV_DB = 'sqlite:///task.db'

PG_USER = 'admin'
PG_PASS = 'dbPassword'
PG_DB = 'superdb'
PG_HOST = 'db'
PG_PORT = '5432'

PROD_DB = f'postgresql://{PG_USER}:{PG_PASS}@{PG_HOST}:{PG_PORT}/{PG_DB}'