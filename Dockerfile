FROM public.ecr.aws/lambda/python:3.8

COPY requirements.txt ${LAMBDA_TASK_ROOT}

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . ${LAMBDA_TASK_ROOT}

ENV AWS_DEFAULT_REGION us-east-1
ENV AWS_ACCOUNT_ID 000000000000

CMD [ "app.handler" ]
