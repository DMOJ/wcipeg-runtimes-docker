FROM dmoj/runtimes-tier1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        jq apt-transport-https dirmngr gnupg ca-certificates \
        openjdk-11-jdk-headless clang ghc golang racket ruby scala nasm libc6-dev-i386 && \
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
        dpkg -i mono-roslyn_no_conflict.deb) && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/home/judge/.cargo/bin:/opt/pypy2/bin:/opt/pypy3/bin:${PATH}" DMOJ_CARGO_OFFLINE="1"
