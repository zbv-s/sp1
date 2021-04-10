FROM amazonlinux
RUN mkdir sp && touch sp/file{1,2,3}
WORKDIR sp
COPY 7171_jab.sh .
RUN chmod +x 7171_jab.sh
CMD ./7171_jab.sh
