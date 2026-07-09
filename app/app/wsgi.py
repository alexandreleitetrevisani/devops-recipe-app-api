import os
from django.core.wsgi import get_wsgi_application
from whitenoise import WhiteNoise

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'app.settings')

application = get_wsgi_application()

# Aponta o WhiteNoise para ler de /app/staticfiles
application = WhiteNoise(application, root='/app/staticfiles')
application.add_files('/app/staticfiles', prefix='static/')
