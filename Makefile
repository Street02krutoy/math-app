RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)


create:
	dart run nylo_framework:main make:$(RUN_ARGS)
nylo:
	dart run nylo_framework:main $(RUN_ARGS)
run:
	flutter run