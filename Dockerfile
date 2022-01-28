# MIT License

# Copyright (c) 2016-2020 Martin Donath

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

FROM ubuntu:focal-20220105

LABEL "org.opencontainers.image.created=2022-01-28T22:51:22Z"
LABEL "org.opencontainers.image.authors=kbrs-miaha"
LABEL "org.opencontainers.image.source= URL to get source code for building the image (string)

org.opencontainers.image.version version of the packaged software

    The version MAY match a label or tag in the source code repository
    version MAY be Semantic versioning-compatible

org.opencontainers.image.revision Source control revision identifier for the packaged software.
org.opencontainers.image.vendor Name of the distributing entity, organization or individual.
org.opencontainers.image.licenses License(s) under which contained software is distributed as an SPDX License Expression.

RUN apt-get update && \
    apt-get install python3 -y && \
    apt-get install python3-pip -y

WORKDIR /opt/app

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

WORKDIR /docs

ENTRYPOINT ["mkdocs"]
CMD ["build", "--clean"]

