AMP = @

GCC = ${AMP}gcc
INCLUDE_FLAG = -Iinclude
LINK_FLAG = -lpng

RM = ${AMP}rm -f

NAMESPACER_NAMES = 
NAMESPACER_NAMES += namespacer_common

NAMESPACER_OBJ_NAMES = ${addsuffix .o, ${NAMESPACER_NAMES}}
NAMESPACER_OBJS = ${addprefix build/, ${NAMESPACER_OBJ_NAMES}}

MAIN_SRC = src/main.c
MAIN_OBJ = build/main.o

BIN = build/namespacer

default: ${BIN}

debug:
	${eval AMP := }

${MAIN_OBJ}: ${MAIN_SRC}
	${GCC} -c $< -o $@ ${INCLUDE_FLAG}

${NAMESPACER_OBJS}: build/%.o: src/%.c include/%.h
	${GCC} -c $< -o $@ ${INCLUDE_FLAG}

${BIN}: ${MAIN_OBJ} ${NAMESPACER_OBJS}
	${GCC} $^ -o $@ ${LINK_FLAG}

redo: clean default

run: ${BIN}
	@${BIN}

move:
	sudo cp ${BIN} /usr/bin

clean:
	${RM} ${BIN}
	${RM} ${MAIN_OBJ}
	${RM} ${NAMESPACER_OBJS}


