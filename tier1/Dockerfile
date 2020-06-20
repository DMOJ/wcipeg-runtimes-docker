FROM debian:buster

RUN echo deb http://deb.debian.org/debian/ stretch main > /etc/apt/sources.list.d/stretch.list && \
    echo deb http://security.debian.org/debian-security stretch/updates main >> /etc/apt/sources.list.d/stretch.list && \
    echo 'APT::Default-Release "buster";' > /etc/apt/apt.conf.d/99stretch && \
    sed -i 's/main$/main contrib non-free/' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        curl file bzip2 gzip build-essential gcc g++ python3-pip python3-dev python3-setuptools python3-wheel \
        cython3 libseccomp-dev python2 fp-compiler libxtst6 tini unrar sudo && \
    apt-get install -y -t stretch --no-install-recommends openjdk-8-jdk-headless openjdk-8-jre-headless && \
    rm -rf /var/lib/apt/lists/* && \
		curl -LO dmoj.ca/~xyene/wcipeg-jail.rar && unrar x wcipeg-jail.rar /opt && rm wcipeg-jail.rar && \
    useradd -m judge && \
		mkdir /opt/jail/dev && mkdir /opt/jail/proc && \
		dpkg --add-architecture i386 && \
    	apt-get update && \
    	apt-get install -y libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386
RUN echo "judge ALL=(root) NOPASSWD:SETENV: /usr/sbin/chroot" >> /etc/sudoers

COPY gcc-chroot /usr/bin/peg-g++-4.1.3
COPY gcc-chroot /usr/bin/peg-g++-4.9.1
COPY gcc-chroot /usr/bin/peg-gcc-4.7.2

ENTRYPOINT ["/usr/bin/tini", "/code/run"]
