# $FreeBSD: head/tools/regression/pjdfstest/Makefile 219437 2011-03-09 22:39:10Z pjd $

PROG=	pjdfstest

${PROG}:	${PROG}.c
	@OSTYPE=`uname`; \
	CFLAGS=-D__OS_$${OSTYPE}__; \
	if [ $$OSTYPE = "FreeBSD" ]; then \
		CFLAGS="$$CFLAGS -DHAS_LCHMOD -DHAS_CHFLAGS -DHAS_FCHFLAGS -DHAS_LCHFLAGS -DHAS_FREEBSD_ACL"; \
	elif [ $$OSTYPE = "SunOS" ]; then \
		CFLAGS="$$CFLAGS -DHAS_TRUNCATE64 -DHAS_STAT64"; \
		CFLAGS="$$CFLAGS -lsocket"; \
	elif [ $$OSTYPE = "Darwin" ]; then \
		CFLAGS="$$CFLAGS -DHAS_LCHMOD -DHAS_CHFLAGS -DHAS_LCHFLAGS"; \
	elif [ $$OSTYPE == "Linux" ]; then \
		CFLAGS="$$CFLAGS -D_GNU_SOURCE"; \
	else \
		echo "Unsupported operating system: ${OSTYPE}."; \
		exit 1; \
	fi; \
	cmd="gcc -Wall $$CFLAGS ${PROG}.c -o ${PROG}"; \
	echo $$cmd; \
	$$cmd

clean:
	rm -f ${PROG}
