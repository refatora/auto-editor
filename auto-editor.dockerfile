FROM python:3
WORKDIR /app
RUN pip install auto-editor
ENTRYPOINT ["auto-editor"]