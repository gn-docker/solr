FROM gnames/resolver:latest
MAINTAINER Dmitry Mozzherin
ENV LAST_FULL_REBUILD 2016-02-20

ENV SOLR_VERSION 3.5.0
ENV SOLR apache-solr-$SOLR_VERSION
ENV SOLR_DOWNLOAD http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$SOLR.tgz


RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install git lsof wget vim curl procps \
      openjdk-7-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget -nv --output-document=/opt/$SOLR.tgz $SOLR_DOWNLOAD && \
  tar -C /opt --extract --file /opt/$SOLR.tgz && \
  rm /opt/$SOLR.tgz && \
  mv /opt/$SOLR /opt/solr
  # git clone https://github.com/EOL/eol.git && \
  # cd eol && git checkout docker && cd .. && \
  # mkdir eol/solr/example && \
  # mkdir eol/solr/example/data && \
  # mv eol/solr/solr/solr.xml /opt/solr && \
  # mv eol/solr/solr/cores /opt/solr && \
  # apt-get -y purge git && \
  # apt-get -y autoremove && \
  # rm -rf eol

VOLUME /opt/solr

EXPOSE 8983
CMD [ "java", "-Xmx64g", "-Dsolr.solr.home=/opt/solr", "-jar example/start.jar", ">", "/dev/null", "2>&1"]

