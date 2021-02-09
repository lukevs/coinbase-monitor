FROM public.ecr.aws/lambda/python:3.8

COPY requirements.txt ${LAMBDA_TASK_ROOT}

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . ${LAMBDA_TASK_ROOT}

ENV AWS_DEFAULT_REGION us-east-1

CMD [ "app.handler" ]
