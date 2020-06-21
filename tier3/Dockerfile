FROM debian:buster

RUN echo deb http://deb.debian.org/debian/ stretch main > /etc/apt/sources.list.d/stretch.list && \
    echo deb http://security.debian.org/debian-security stretch/updates main >> /etc/apt/sources.list.d/stretch.list && \
    echo 'APT::Default-Release "buster";' > /etc/apt/apt.conf.d/99stretch && \
    sed -i 's/main$/main contrib non-free/' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        curl file bzip2 gzip build-essential gcc g++ python3-pip python3-dev python3-setuptools python3-wheel \
        cython3 libseccomp-dev python2 fp-compiler php-cli libxtst6 tini unrar sudo && \
    apt-get install -y -t stretch --no-install-recommends openjdk-8-jdk-headless openjdk-8-jre-headless && \
    rm -rf /var/lib/apt/lists/* && \
		mkdir /opt/jail && curl "https://dmoj.ca/~xyene/wcipeg-jail.tar.gz" | tar -xz -C /opt/jail --strip-components=1 && \
    mkdir /opt/jail/tmp /opt/jail/proc /opt/jail/dev && \
    useradd -m judge && \
    dpkg --add-architecture i386 && \
    	apt-get update && \
    	apt-get install -y libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 && \
    apt-get install -y --no-install-recommends \
        jq apt-transport-https dirmngr gnupg ca-certificates \
        ghc racket ruby nasm libc6-dev-i386 && \
    ( \
        apt-get install -y --no-install-recommends make m4 patch unzip libgmp-dev && \
        bash -c 'echo | sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh) --no-backup' && \
        runuser -u judge -- opam init --shell-setup --disable-sandboxing && \
        runuser -u judge -- opam install -y base core stdio zarith && \
        runuser -u judge -- opam clean && rm -rf ~judge/.opam/repo \
    ) && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/debian stable-buster main" > \
        /etc/apt/sources.list.d/mono-official-stable.list && \
    curl https://dmoj.ca/dmoj-apt.key | apt-key add - && \
    echo 'deb [arch=amd64] https://apt.dmoj.ca/ stretch main non-free' > /etc/apt/sources.list.d/dmoj.list && \
    (echo 'Package: *'; echo 'Pin: origin download.mono-project.com'; echo 'Pin-Priority: 990') > /etc/apt/preferences.d/mono && \
    apt-get update && \
    (cd /tmp && \
        apt download mono-roslyn && \
        dpkg-deb -R mono-roslyn_*.deb roslyn/ && \
        sed -i -e '/^Conflicts: chicken-bin/d' roslyn/DEBIAN/control && \
        dpkg-deb -b roslyn mono-roslyn_no_conflict.deb && \
        apt-get install -y --no-install-recommends mono-devel && \
        dpkg -i mono-roslyn_no_conflict.deb && \
        rm mono-roslyn_no_conflict.deb) && \
    rm -rf /var/lib/apt/lists/* && \
    echo "judge ALL=(root) NOPASSWD:SETENV: /usr/sbin/chroot" >> /etc/sudoers

COPY gcc-chroot /usr/bin/peg-g++-4.1.3
COPY gcc-chroot /usr/bin/peg-g++-4.9.1
COPY gcc-chroot /usr/bin/peg-gcc-4.7.2

ENTRYPOINT ["/usr/bin/tini", "/code/run"]
