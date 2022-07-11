docker build -t datastation .
docker tag datastation:latest aloneguid/datastation:latest
docker push aloneguid/datastation:latest

# run with:
# docker run -it --rm -p 8192:8192 -p 4040:4040 -v ~/dsd:/opt/notebooks datastation

# log in to container:
# docker run -it --rm --entrypoint /bin/bash datastation