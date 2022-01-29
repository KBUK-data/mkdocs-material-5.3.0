# MIT License

# Copyright (c) 2016-2020 Martin Donath

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Stage 1 of multibuild
FROM ubuntu:focal-20220105 AS compile-image

LABEL org.opencontainers.image.created=2022-01-29
LABEL org.opencontainers.image.authors=kbrs-miaha
LABEL org.opencontainers.image.source=https://github.com/KBUK-data/mkdocs-material-5.3.0
LABEL org.opencontainers.image.version=2
LABEL org.opencontainers.image.licenses="MIT License"
LABEL KBUK-data.ubuntu=focal-20220105
LABEL KBUK-data.mkdocs-material=5.3.0
LABEL KBUK-data.mkdocs=1.2.1

RUN apt-get update && \
    apt-get install python3 python3-pip python3-venv git -y && \
    rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

# Stage 2 of multibuild
FROM ubuntu:focal-20220105 AS build-image

RUN apt-get update && \
    apt-get install python3 python3-pip python3-venv git -y && \
    rm -rf /var/lib/apt/lists/*

# Copy artifacts from build
COPY --from=compile-image /opt/venv /opt/venv

# Select virtual environment
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /docs

ENTRYPOINT ["mkdocs"]
CMD ["build", "--clean"]
