FROM python:3.10.10

RUN mkdir usr/app
WORKDIR /usr/app

COPY . .

RUN pip install -r requirements.txt

CMD python app.py