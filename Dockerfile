FROM python:3.10-slim

ENV PYTHONBUFFERED=1

ADD ./requirements.txt /app/requirements.txt

ADD . /app 
WORKDIR /app

RUN apt update -y

RUN pip install --upgrade pip
RUN pip install django
RUN pip install djangorestframework
RUN pip install gunicorn
RUN pip install asgiref==3.7.2
# RUN pip install mysqlclient==2.2.0 --no-binary :all:
RUN pip install python-decouple==3.8
RUN pip install python-dotenv==1.0.0
RUN pip install pytz==2023.3.post1
RUN pip install sqlparse==0.4.4
RUN pip install typing_extensions==4.8.0


# RUN python manage.py makemigrations 
# RUN python /app/manage.py migrate


# COPY ./entrypoint.sh /app/entrypoint.sh

EXPOSE 8000


# ENTRYPOINT ["sh", "/app/entrypoint.sh"]

CMD ["gunicorn", "--bind", ":8000", "--timeout", "600", "--workers", "1", "freelunch.wsgi:application"]