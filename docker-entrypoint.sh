#!/bin/sh
set -e

if [ "$#" -gt 0 ]; then
  exec "$@"
fi

python manage.py migrate --noinput --settings=config.settings.prod
python manage.py collectstatic --noinput --settings=config.settings.prod

exec daphne -b 0.0.0.0 -p 8000 config.asgi:application
