FROM docker.io/library/python:3.12

LABEL maintainer="wangyufengx"  

ENV PYTHON_VERSION="3.12.4"
ENV JAVA_VERSION="1.8"
  
# 安装基础工具  
RUN	 set -eux; \
    apt-get update -y \ 
 	&& apt-get upgrade -y; \
 	apt-get install -y --no-install-recommends \
			curl 	\
			gnupg 	\
			unixodbc-dev; \
	pip install --upgrade pip setuptools wheel; \
	wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc \
	&& echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://mirrors.cernet.edu.cn/Adoptium/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list \
	&& apt-get update -y \
	&& apt-get install -y temurin-8-jdk \
	&& java -version
