build:
	docker build -t arm-cipher .

run:
	docker run -it --rm --name arm-cipher arm-cipher
