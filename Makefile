
all: debug

up		:
			@mkdir data && mkdir data/wordpress
			@docker compose -f ./src/docker-compose up -d --build

clean	:
			$(RM) -r $(OBJS) $(OBJS_D)

fclean	:	clean
			$(RM) $(BIN)

re		:	fclean all

.PHONY: all up down start stop ps re clean
