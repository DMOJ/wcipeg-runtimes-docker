FROM dmoj/runtimes-tier2

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb [arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' > /etc/apt/sources.list.d/dart.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends unzip libtinfo5 xz-utils \
        gnat gfortran tcl php-cli gforth && \
    rm -rf /var/lib/apt/lists/*

ENV PATH "/opt/tprolog:/opt/groovy/bin:/opt/kotlin/bin:${PATH}:/opt/swift/usr/bin:/opt/zig"
