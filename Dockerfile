FROM python:3.8.12
MAINTAINER Evgeny Medvedev <evge.medvedev@gmail.com>
ENV PROJECT_DIR=polygon-etl

RUN mkdir /$PROJECT_DIR
WORKDIR /$PROJECT_DIR
COPY . .
RUN pip install --upgrade pip && pip install -e /$PROJECT_DIR/[streaming]

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ENTRYPOINT ["/tini", "--", "python", "polygonetl"]
