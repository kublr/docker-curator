FROM alpine:latest

RUN apk --no-cache add python3 py3-setuptools py3-pip gcc libffi py3-cffi python3-dev libffi-dev py3-openssl musl-dev linux-headers openssl-dev libssl1.1 && \
    pip3 install wheel && \
    pip3 install elasticsearch-curator==5.8.1 && \
    pip3 install boto3==1.9.143 && \
    pip3 install requests-aws4auth==0.9 && \
    pip3 install cryptography==2.6.1 && \
    apk del py3-pip gcc python3-dev libffi-dev musl-dev linux-headers openssl-dev && \
    sed -i '/import sys/a urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)' /usr/bin/curator && \
    sed -i '/import sys/a urllib3.contrib.pyopenssl.inject_into_urllib3()' /usr/bin/curator && \
    sed -i '/import sys/a import urllib3.contrib.pyopenssl' /usr/bin/curator && \
    sed -i '/import sys/a import urllib3' /usr/bin/curator

USER nobody:nobody

ENTRYPOINT ["/usr/bin/curator"]
