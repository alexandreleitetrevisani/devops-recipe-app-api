"""
WSGI config for app project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.2/howto/deployment/wsgi/
"""

#import os

#from django.core.wsgi import get_wsgi_application

#os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'app.settings')

#application = get_wsgi_application()

import os
from django.core.wsgi import get_wsgi_application
from whitenoise import WhiteNoise  # <--- ADICIONE ESTA LINHA

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'app.settings')

application = get_wsgi_application()

# Força o WhiteNoise a envelopar a aplicação e mapear a pasta /vol/web/static
application = WhiteNoise(application, root='/vol/web/static')
application.add_files('/vol/web/static', prefix='static/')

