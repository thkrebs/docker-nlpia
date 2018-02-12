# docker-nlpia
Jupyter &amp; NLPIA Docker image

Integrating the the code for the book  Natural Language Processing in Action published here:
  https://github.com/totalgood/nlpia 

into a Docker image with Jupyter support.

## Description

Run the docker image with 

```bash
docker run -it --rm -p8888:8888 -v$PWD:/opt/notebooks/work /opt/thkrebs/docker-nlpia
```

Point the browser to the URL displayed. Notebooks saved in /opt/notebooks/work will be available in the current working directory
